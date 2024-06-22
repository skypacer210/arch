### 题目

    [candidate@node-1] $ kubectl config use-context k8s

将 deployment presentation 扩展至 4 个 pods

### 准备环境

考试时候无需，直接按照题目要求切换集群即可！！！

执行准备脚本

    bash ./env_setup.sh

### 答题

扩容 deployment 副本数量，记住命令！

#### 1. 查询当前部署的副本数：

```
ubuntu@kubeworker01:/Users/yangyong/arch/cka/2-replicas$ k get deployments
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
front-end      3/3     3            3           8d
presentation   1/1     1            1           2m21s
```

#### 2. 执行扩容

```
ubuntu@kubeworker01:/Users/yangyong/arch/cka/2-replicas$ k scale deployment presentation --replicas=4
deployment.apps/presentation scaled
```

### 验证

显示4/4，说明有4个POD。

```
ubuntu@kubeworker01:/Users/yangyong/arch/cka/2-replicas$ k get pod -l app=presentation
NAME                           READY   STATUS    RESTARTS   AGE
presentation-6f57ccbc7-6mtwc   1/1     Running   0          3h25m
presentation-6f57ccbc7-lznzs   1/1     Running   0          4m39s
presentation-6f57ccbc7-t9hjj   1/1     Running   0          4m39s
presentation-6f57ccbc7-zwxhl   1/1     Running   0          4m39s

```