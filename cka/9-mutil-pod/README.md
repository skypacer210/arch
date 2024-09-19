### 题目

设置配置环境：

    [candidate@node-1] $ kubectl config use-context k8s

Task

按如下要求调度一个 Pod：      
名称：kucc8        
app containers: 2       
container 名称/images：        
- nginx     
- memcached

### 准备环境

考试时候无需，直接按照题目要求切换集群即可！！！

执行准备脚本

    bash ./env_setup.sh


### 解析

考点：pod 概念

参考链接：https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/


### 答题


#### 1. 切换集群

    kubectl config use-context k8s

#### 2. 创建pod yaml

    k run kucc8 --image=nginx --dry-run=client -o yaml > mutil-container-draft.yaml

#### 3. 拷贝或者直接编辑该yaml文件，

    cp mutil-container-draft.yaml mutil-container.yaml

#### 4. 编辑mutil-container.yaml

#### 5. 创建

    k apply -f mutil-container.yaml

### 验证

确保 pod 是 running 的

```
ubuntu@kubeworker01:/Users/yangyong/arch/cka/8-node-count$ k get pod kucc8
NAME    READY   STATUS    RESTARTS   AGE
kucc8   2/2     Running   0          4m2s
```