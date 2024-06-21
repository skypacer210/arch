### 题目

设置配置环境：

    [candidate@node-1] $ kubectl config use-context k8s

Task

通过 pod label name=cpu-loader，找到运行时占用大量 CPU 的 pod，       
并将占用 CPU 最高的 pod 名称写入文件 /opt/KUTR000401/KUTR00401.txt（已存在）。

### 准备环境

考试时候无需，直接按照题目要求切换集群即可！！！

执行准备脚本

    bash ./env_setup.sh

### 答题

查看 pod 名称 -A 是所有 namespace 的意思

    kubectl top pod -l name=cpu-loader --sort-by=cpu -A

将 cpu 占用最多的 pod 的 name 写入/opt/test1.txt 文件

echo "查出来的 Pod Name" > /opt/KUTR000401/KUTR00401.txt

TODO：环境有错误！！！

```
code
```

### 验证

检查

```
cat /opt/KUTR000401/KUTR00401.txt
```