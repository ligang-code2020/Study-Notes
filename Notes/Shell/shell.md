# Shell 笔记

### Shell 中遍历单个字符的二种方法：

---

#### 方法一

sed 是一款流编辑工具，用来对文本进行过滤与替换工作， sed 通过输入读取文件内容，但一次仅读取一行内容进行某些指令处理后输出，sed 更适合于处理大数据文件。

```bash
echo jalsdfjlasjdl | sed "s/[^\n]/&\n/g"  //输出单个字符
```

#### 方法二

```bash
str="love you jingjing"
for i in $(seq ${#str}); do
    echo ${str:$i-1:1}       //输出单个字符
done
```

### 按照分割符号遍历数组(将字符串变成数组)：

---

```bash
#!/bin/bash
a="hello world nice to meet you"
#要将$a分割开，先存储旧的分隔符
OLD_IFS="$IFS"

#设置分隔符
IFS=" "

#如下会自动分隔
arr=($a)

#恢复原来的分隔符
IFS="$OLD_IFS"

#遍历数组
for s in ${arr[@]}
    do
    echo "$s"
done
```

---

### 来看一个实例

这个脚本实现了将字符串转换成数组，然后实现二个数组求差集。

```bash
#!/bin/bash
# “#!” 是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行
source /etc/profile
# grep -v grep： 在文档中过滤掉包含有grep字符的行
# awk '{print $2}'： 按空格截取第二个

#检索到正在允许的flinkJobId，可能是多个。
flinkJobId=`flink list | grep : | awk '{print $4}'`

#获取hdfs目录下的日志文件名
dir=`hdfs dfs -ls /html-web-monitor-beam-flink/flink-checkpoints | awk '{print $8}'`

#------字符串转化为数组--------------------------------------------------------------------------

#要将$flinkJobId分割开，先存储旧的分隔符
old_JobId="$JobId"
#设置分隔符
JobId=" "
#如下会自动分隔
arr=($flinkJobId)
#恢复原来的分隔符
JobId="$old_JobId"

#-----------------------------------------------------------------------------------------------

MonitorAlarm(){
    # 输出文本
   echo "[INFO] 执行定时删除脚本"`date +'%Y-%m-%d %H:%M:%S'`

   #拼接前缀，组成新数组
   for i in ${arr[@]}
   do
       arr[$count]="/html-web-monitor-beam-flink/flink-checkpoints/$i"
       count=$((count + 1))
   done

#------数组求差集--------------------------------------------------------------------------------

   l2=" ${arr[*]} "                    # add framing blanks
   for item in ${dir[@]};
   do
   if ! [[ $l2 =~ " $item " ]] ; then    # use $item as regexp
       Array3+=($item)
   fi

   done

#-----------------------------------------------------------------------------------------------

   for i in "${Array3[@]}";
   do
   hdfs dfs -rm -r $i
   done

}
MonitorAlarm
```

---

### 定时发送信息脚本

```bash
#!/bin/bash
function send_messages_to_kafka {
    msg=$(generator_message)
    echo -e $msg | $KAFKA_HOME/bin/kafka-console-producer.sh --broker-list 172.21.91.206:9092 --topic flink-performance-test
}
#--------------------生成随机数--------------------
function rand {
    min=$1
    max=$(($2-$min+1))
    num=$(date +%s%N)
    echo $(($num%$max+$min))
}
#-------------------------------------------------

function generator_message {
    #产生1~1000000之间的随机数
    uid=$(rand 1 1000000);
    g=$(rand 1 100000);
    appid=$(rand 1 10000)
    timestamp=`date '+%s'`;
    msg={\"fpr\":895,\"rts\":1363,\"ppo\":[[\"subPages/pages/order/index\",0,0,0,[1],1135]],\"rho\":[[\"https://log.aldwx.com/d.html\",368,347,327,[0,0]]],\"key\":\"wx51a67be90ec28ff2\",\"g\":\"$g\",\"l\":\"28.094796,111.373202\",\"u\":\"$uid\",\"s\":\"\","t":$timestamp}
    echo $msg
}

generator_message


#while true
#do
# send_messages_to_kafka
# sleep 0.1
#done
```

---

## 一些知识点

-   echo

    > 1.在 Shell 脚本语言中，函数返回值可以用 return 和 echo 返回，但是 return 有数值大小的限制，所以我们一般用时<font color="red">echo</font>来返回值。

-   grep

    > grep 命令用于查找文件里符合条件的字符串

-   awk
    > AWK 是一种处理文本文件的语言，是一个强大的文本分析工具。  
    > 例如：`` `flink list | grep : | awk '{print $4}'` ``  
    > 打印第二个字段
