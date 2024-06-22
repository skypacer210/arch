### 题目

设置配置环境：

    [candidate@node-1] $ kubectl config use-context k8s

Task

监控 pod foo 的日志并：        
提取与错误 RLIMIT_NOFILE 相对应的日志行     
将这些日志行写入 /opt/KUTR00101/foo

### 准备环境

考试时候无需，直接按照题目要求切换集群即可！！！

执行准备脚本

    bash ./env_setup.sh

### 答题

考点：logs命令

#### 1. 切换集群

    kubectl config use-context k8s

#### 2. Log

    kubectl logs foo | grep "RLIMIT_NOFILE" > /opt/KUTR00101/foo

### 验证

cat /opt/KUTR00101/foo