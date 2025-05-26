以前的部署方式
项目是一个web项目，部署方式是用以下命令部署：

nohup java -jar /application/jar包名.jar  >/dev/null 2>&1 &
1
然后修改了点代码，重启方式是：

ps -ef |grep jar包名		# 获取进程id
kill -9 {pid}			# 杀掉进程
1
2
由于前后端不分离，导致有时候修改前端的一点东西，一天可能好几次重启服务，频繁地使用这几个命令觉得太麻烦了，于是写了以下shell脚本

更优雅地启动/重启/停止服务
#!/bin/bash

# Java环境变量
export JAVA_HOME=/usr/java/jdk1.8.0_131-cloudera
export JRE_HOME=${JAVA_HOME}/jre

# jar包位置
APP_HOME=/application
# 应用名称 命令第一个参数
APP_NAME=$1

# 使用说明，用来提示输入参数
usage() {
    echo "执行: sh boot [jar包名] [start|stop|restart|status]"
}

# 检查程序是否在运行
is_exist(){
        # 获取PID
	PID=$(ps -ef |grep ${APP_NAME} | grep -v $0 |grep -v grep |awk '{print $2}')
        # -z "${pid}"判断pid是否存在，如果不存在返回1，存在返回0
        if [ -z "${PID}" ]; then
                # 如果进程不存在返回1
                return 1
        else
                # 进程存在返回0
                return 0
        fi
}

# 启动服务
start(){
        is_exist
        if [ $? -eq "0" ]; then
                echo "${APP_NAME} 进程已经启动, PID=${PID}"
        else
                nohup ${JRE_HOME}/bin/java -jar ${APP_HOME}/${APP_NAME} >/dev/null 2>&1 &
                PID=$(echo $!)
                echo "${APP_NAME} 启动成功, PID=$!"
        fi
}

# 停止服务
stop(){
        is_exist
        if [ $? -eq "0" ]; then
                kill -9 ${PID}
                echo "${APP_NAME} 进程停止, PID=${PID}"
        else
                echo "${APP_NAME} 进程不存在"
        fi
}

# 重启服务
restart(){
        stop
        start
}

# 查看进程状态
status(){
        is_exist
        if [ $? -eq "0" ]; then
                echo "${APP_NAME} is running, PID=${PID}"
        else
                echo "${APP_NAME} 进程不存在"
        fi
}
# 命令第二个参数
case $2 in
"start")
        start
        ;;
"stop")
        stop
        ;;
"restart")
        restart
        ;;
"status")
       status
        ;;
        *)
        usage
        ;;
esac

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
修改下java环境变量和jar包位置，就可以一条命令完成 启动 /重启 / 停止 操作

sh 脚本名 jar包名 start|stop|restart|status
————————————————
版权声明：本文为CSDN博主「章全蛋」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_41049126/article/details/103955778

