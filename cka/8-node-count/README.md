### 题目

设置配置环境：

    [candidate@node-1] $ kubectl config use-context k8s

Task

检查有多少 nodes 已准备就绪（不包括被打上 Taint：NoSchedule 的节点），     
并将数量写入 /opt/KUSC00402/kusc00402.txt

### 准备环境

考试时候无需，直接按照题目要求切换集群即可！！！

### 答题

考点：检查节点角色标签，状态属性，污点属性的使用

参考链接：https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/deployment/

题目要求，不包括被打上 Taint：NoSchedule 的就绪节点，所以要排除 NoSchedule 的。

#### 法1. 过滤出Taints为NoSchedule的Node, 这里是第一行，总共3个，那么符合题目要求的节点就是3-1=2

```
ubuntu@kubeworker01:/Users/yangyong/project/cka/8-node-count$ kubectl describe nodes | grep -i Taints
Taints:             node-role.kubernetes.io/control-plane:NoSchedule
Taints:             <none>
Taints:             <none>
```

#### 法2: 一步到位，直接查

基于grep的 -vc，即排除匹配之外的

    kubectl describe nodes | grep -i Taints | grep -vc NoSchedule

#### 写入文件

    echo "查出来的数字" > /opt/KUSC00402/kusc00402.txt

### 验证

```
cat /opt/KUSC00402/kusc00402.txt
```