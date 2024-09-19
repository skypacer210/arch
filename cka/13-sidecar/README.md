### 题目

设置配置环境：

    [candidate@node-1] $ kubectl config use-context k8s

Context

将一个现有的 Pod 集成到 Kubernetes 的内置日志记录体系结构中（例如 kubectl logs）。        
添加 streaming sidecar 容器是实现此要求的一种好方法。

Task

使用 busybox Image 来将名为 sidecar 的 sidecar 容器添加到现有的 Pod 11-factor-app 中。       
新的 sidecar 容器必须运行以下命令：

    /bin/sh -c tail -n+1 -f /var/log/11-factor-app.log

使用挂载在/var/log 的 Volume，使日志文件 11-factor-app.log 可用于 sidecar 容器。      
除了添加所需要的 volume mount 以外，请勿更改现有容器的规格。

### 准备环境

考试时候无需，直接按照题目要求切换集群即可！！！

执行准备脚本

    bash ./env_setup.sh

### 解析

考点：将现有的 deploy 暴露成 nodeport 的 service。

添加一个名为 sidecar 的边车容器(使用 busybox 镜像)，加到已有的 pod 11-factor-app 中。
确保 sidecar 容器能够输出 /var/log/11-factor-app.log 的信息。
使用 volume 挂载 /var/log 目录，确保 sidecar 能访问 11-factor-app.log 文件

参考链接：https://kubernetes.io/zh-cn/docs/concepts/cluster-administration/logging/

这道题的大体流程为：	

1. 通过 kubectl get pod -o yaml 的方法备份原始 pod 信息，删除旧的 pod 11-factor-ap
2. 复制一份新 yaml 文件，添加 一个名称为 sidecar 的容器
3. 挂载 emptyDir 的卷，确保两个容器都挂载了 /var/log 目录
4. 创建含有 sidecar 的 pod，并通过 kubectl logs 验证

### 答题

#### 1. 切换集群

    kubectl config use-context k8s

#### 2. 导出这个 pod 的 yaml 文件

    kubectl get pod 11-factor-app -o yaml > varlog.yaml

#### 3. 备份 yaml 文件，防止改错了，回退。

    cp varlog.yaml varlog-bak.yaml

#### 4. 修改 varlog.yaml 文件

    vim varlog.yaml

#### 5. 删除原先的 pod，大约需要等 2 分钟，中途不要 CTRL+C 终止命令。

    kubectl delete pod 11-factor-app

#### 6. 检查一下是否删除了

    kubectl get pod 11-factor-app

#### 7. 新建这个 pod

    kubectl apply -f varlog.yaml

### 验证

法1：看日志

    kubectl logs 11-factor-app sidecar

法2：直接执行容器中命令

```
ubuntu@kubeworker01:/Users/yangyong/arch/cka/13-sidecar$ kubectl exec 11-factor-app -c sidecar -- tail -f /var/log/11-factor-app.log
Thu Jun 20 00:19:52 UTC 2024 INFO 342
Thu Jun 20 00:19:53 UTC 2024 INFO 343
Thu Jun 20 00:19:54 UTC 2024 INFO 344
Thu Jun 20 00:19:55 UTC 2024 INFO 345
```

法3： 进入sidecar容器，看日志是否已经写入

```
ubuntu@kubeworker01:/Users/yangyong/arch/cka/13-sidecar$ k exec -it 11-factor-app -c sidecar -- /bin/sh
/ # tail -f /var/log/11-factor-app.log
Wed Jun 19 23:45:43 UTC 2024 INFO 4029
Wed Jun 19 23:45:44 UTC 2024 INFO 4030
Wed Jun 19 23:45:45 UTC 2024 INFO 4031
Wed Jun 19 23:45:46 UTC 2024 INFO 4032
Wed Jun 19 23:45:47 UTC 2024 INFO 4033
Wed Jun 19 23:45:48 UTC 2024 INFO 4034
Wed Jun 19 23:45:49 UTC 2024 INFO 4035
Wed Jun 19 23:45:50 UTC 2024 INFO 4036
Wed Jun 19 23:45:51 UTC 2024 INFO 4037
```