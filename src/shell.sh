#shell中遍历单个字符的二种方法
#方法一
/*
sed是一款流编辑工具，用来对文本进行过滤与替换工作，
sed通过输入读取文件内容，但一次仅读取一行内容进行某些指令处理后输出，sed更适合于处理大数据文件。
*/
echo jalsdfjlasjdl | sed "s/[^\n]/&\n/g"  

#方法二
#----------------------------------------------------------------
#!/bin/bash
str="love you jingjing"
for i in $(seq ${#str}); do
    echo ${str:$i-1:1}
done
