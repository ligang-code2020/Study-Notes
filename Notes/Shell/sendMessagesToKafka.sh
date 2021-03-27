#!/bin/bash
function send_messages_to_kafka() {
    msg=$(generator_message)
    echo $msg
    echo -e $msg | $KAFKA_HOME/bin/kafka-console-producer.sh --broker-list 172.21.91.206:9092 --topic flink-performance-test
}
function rand() {
    min=$1
    max=$(($2 - $min + 1))
    num=$(date +%s%N)
    echo $(($num % $max + $min))
}
function generator_message() {
    uid=$(rand 1 1000000)
    g=$(rand 1 100000)
    appid=$(rand 1 10000)
    timestamp=$(($(date +%s%N) / 1000000))
    msg={\"fpr\":895,\"rts\":1363,\"ppo\":[[\"subPages/pages/order/index\",0,0,0,[1],1135]],\"rho\":[[\"https://log.aldwx.com/d.html\",368,347,327,[0,0]]],\"key\":\"wx51a67be90ec28ff2\",\"g\":\"$g\",\"l\":\"28.094796,111.373202\",\"u\":\"$uid\",\"s\":\"\",\"t\":$timestamp}
    echo $msg
}

#generator_message

#while true
#do
# send_messages_to_kafka
# sleep 0.1
#done

runtime="1 minute"
endtime=$(date -ud "$runtime" +%s)

while [[ $(date -u +%s) -le $endtime ]]; do
    echo "Time Now: $(date +%H:%M:%S)"

    send_messages_to_kafka
    sleep $(($RANDOM % 10))
done
