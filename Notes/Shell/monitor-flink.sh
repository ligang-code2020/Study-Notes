#!/bin/bash
# “#!” 是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行
source /etc/profile
# 变量
webhook=https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=3d1d6a7b-4557-4120-923b-14563843900b

# grep -v grep： 在文档中过滤掉包含有grep字符的行
# awk '{print $2}'： 按空格截取第二个

flinkJobId=$(yarn application -list -appStates RUNNING 2>/dev/null | grep pipeline | awk '{print $2}')

#要将$flinkJobId分割开，先存储旧的分隔符
old_JobId="$JobId"
#设置分隔符
JobId=" "
#如下会自动分隔
arr=($flinkJobId)
#恢复原来的分隔符
JobId="$old_JobId"

arr_length=${#arr[@]}

arr1=${arr[0]}
arr2=${arr[1]}


MonitorAlarm(){


    # 脚本每一分钟轮询一次
        echo "[INFO] 进入监控脚本"`date +'%Y-%m-%d %H:%M:%S'`

    # 判断二个pipeline是否都在正常运行
    if [ -z "$arr1" ] || [ -z "$arr2" ]; then

    # performancepipeline 挂了
    if [ "$arr1" != "performancepipeline" ] && [ "$arr2" != "performancepipeline" ]; then
        # 通知企业微信群
        curl $webhook -X POST -d '{ "msgtype": "text", "text": { "content": "performancepipeline 不知道什么原因挂了，正在重启！" } }' --header "Content-Type: application/json"

        # performancepipeline 提交语句
       /usr/local/flink-1.12.0/bin/flink run -m yarn-cluster -ynm performancepipeline \
       -d -c com.xsyx.ops.pipeline.PerformancePipeline /home/html-web-monitor-beam-flink-bundled-1.0-SNAPSHOT.jar \
       --runner=FlinkRunner \
       --streaming=true \
       --parallelism=120 \
       --checkpointingInterval=120000 \
       --performanceGroupId=performance-write-es-0420 \
       --checkpointTimeoutMillis=360000 \
       --minPauseBetweenCheckpoints=60000 \
       --jobName=performancepipeline \
       --allowNonRestoredState=true \
       --maxParallelism=240
    fi

    # reportpipeline 挂了
    if [ "$arr1" != "reportpipeline" ] && [ "$arr2" != "reportpipeline" ]; then
        # 通知企业微信群
        curl $webhook -X POST -d '{ "msgtype": "text", "text": { "content": "reportpipeline 不知道什么原因挂了，正在重启！" } }' --header "Content-Type: application/json"

        # reportpipeline 提交语句
        /usr/local/flink-1.12.0/bin/flink run -m yarn-cluster \
        -d -yD taskmanager.numberOfTaskSlots=6 \
        -yD taskmanager.memory.task.heap.size=10g \
        -yD taskmanager.memory.network.max=1g \
        -yD taskmanager.memory.network.min=1g \
        -yD jobmanager.heap.size=2g \
        -ynm reportpipeline \
        -c com.xsyx.ops.pipeline.ReportPipeline /home/html-web-monitor-beam-flink-bundled-1.0-SNAPSHOT.jar \
        --runner=FlinkRunner \
        --streaming=true \
        --parallelism=4 \
        --checkpointingInterval=180000 \
        --reportGroupId=report-write-es-0413 \
        --checkpointTimeoutMillis=300000 \
        --minPauseBetweenCheckpoints=120000 \
        --jobName=reportpipeline
    fi

    else
        echo "[SUCCESS] flink-yarn 正常运行中，轮询时间="$(date +'%Y-%m-%d %H:%M:%S')
    fi


}
MonitorAlarm
