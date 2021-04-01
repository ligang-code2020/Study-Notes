#!/bin/bash
# “#!” 是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行
source /etc/profile
# 变量
webhook=https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=a43804b9-dde0-40a3-9461-5d2f1cdfe14e

# grep -v grep： 在文档中过滤掉包含有grep字符的行
# awk '{print $2}'： 按空格截取第二个

flinkJobId=$(flink list | grep : | awk '{print $4}')

MonitorAlarm() {
    # 输出文本
    echo "[INFO] 进入监控脚本"$(date +'%Y-%m-%d %H:%M:%S')
    if [[ -z "$flinkJobId" ]]; then
        curl $webhook -X POST -d '{ "msgtype": "text", "text": { "content": "flink程序不知道什么原因挂了，正在重启！" } }' --header "Content-Type: application/json"
        # 杀死僵尸进程
        #/usr/local/flink-1.10.2/bin/stop-cluster.sh
        #/usr/local/flink-1.10.2/bin/start-cluster.sh
        # 提交命令
        #/usr/local/flink-1.10.2/bin/flink run -d -c com.xsyx.ops.pipeline.PerformancePipeline /home/html-web-monitor-beam-flink-bundled-1.0-SNAPSHOT.jar \
        #--runner=FlinkRunner \
        #--streaming=true \
        #--parallelism=3
    else
        echo "[SUCCESS] flink 运行中，pid： $flinkJobId，轮询时间="$(date +'%Y-%m-%d %H:%M:%S')
    fi
}
MonitorAlarm
