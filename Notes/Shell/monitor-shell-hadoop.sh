#!/bin/bash
# “#!” 是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行
source /etc/profile
# 变量
appName=sparkstreaming-front-log
webhook=https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=a301f9f0-7edd-4190-9831-36b9d5610456

# grep -v grep： 在文档中过滤掉包含有grep字符的行
# awk '{print $2}'： 按空格截取第二个

pid=$(yarn application -list -appStates RUNNING 2>/dev/null | grep application_ | grep $appName | awk '{print $1}')

MonitorAlarm() {
    # 输出文本
    echo "[INFO] 进入监控脚本"$(date +'%Y-%m-%d %H:%M:%S')
    if [[ -z "$pid" ]]; then
        curl $webhook -X POST -d '{ "msgtype": "text", "text": { "content": "'$appName' 不知道什么原因没启动，正在启动！" } }' --header "Content-Type: application/json"

        # 提交命令
        /usr/local/spark-2.4.0-bin-hadoop2.7/bin/spark-submit \
            --master yarn \
            --class com.xsyx.ops.SparkStreamingFrontLogNew \
            --deploy-mode client \
            --executor-memory 2g \
            --executor-cores 2 \
            --driver-memory 3g \
            --num-executors 7 \
            --conf spark.default.parallelism=2000 \
            --conf spark.sql.shuffle.partitions=1000 \
            /home/html_web_monitor_spark_jar_yarn/html_web_monitor_spark_jar/html-web-monitor-spark.jar reload 60 >/data/html-web-monitor-spark-hadoop/$(date +'%Y%m%d%H')log.log 2>&1 &
    else
        echo "[SUCCESS] $appName 运行中，pid： $pid，轮询时间="$(date +'%Y-%m-%d %H:%M:%S')
    fi
}
MonitorAlarm
