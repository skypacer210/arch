### 题目

设置配置环境：

    [candidate@node-1] $ kubectl config use-context hk8s

Task

创建名为 app-config 的 persistent volume，容量为 1Gi，访问模式为 ReadWriteMany。    
volume 类型为 hostPath，位于 /srv/app-config

### 准备环境

考试时候无需，直接按照题目要求切换集群即可！！！

执行准备脚本

    bash ./env_setup.sh

### 答题

考点：hostPath 类型的 pv

参考链接：https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-persistent-volume-storage/

直接从官方复制合适的案例，修改参数，然后设置 hostPath 为 /srv/app-config 即可。

依次点击 Tasks → Configure Pods and Containers → Configure a Pod to Use a PersistentVolume for Storage

最好是熟记PV yaml

#### 1. 基于示例创建pv.yaml, 编辑

    vim pv.yaml

#### 2. 创建PV

```
ubuntu@kubeworker01:/Users/yangyong/project/cka/10-pv$ k apply -f pv.yaml
persistentvolume/app-config created
```

### 验证

查询PV，RWX 是 ReadWriteMany，RWO 是 ReadWriteOnce。

```
ubuntu@kubeworker01:/Users/yangyong/project/cka/10-pv$ k get pv app-config
NAME         CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
app-config   1Gi        RWX            Retain           Available           app-config     <unset>                          26s
```