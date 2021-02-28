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
