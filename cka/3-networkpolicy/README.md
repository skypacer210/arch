### 题目

设置配置环境：

    [candidate@node-1] $ kubectl config use-context hk8s

Task

在现有的 namespace my-app 中创建一个名为 allow-port-from-namespace 的新 NetworkPolicy。
确保新的 NetworkPolicy 允许 namespace echo 中的 Pods 连接到 namespace my-app 中的 Pods 的 9000 端口。

进一步确保新的 NetworkPolicy：
不允许对没有在监听 端口 9000 的 Pods 的访问
不允许非来自 namespace echo 中的 Pods 的访问

### 准备环境

考试时候无需，直接按照题目要求切换集群即可！！！

执行准备脚本

    bash ./env_setup.sh

### 答题

配置网络策略 NetworkPolicy

上面解释成白话，双重否定就是肯定，所以最后两句话的意思就是：
仅允许端口为 9000 的 pod 方法。
仅允许 echo 命名空间中的 pod 访问。

这里要注意，考试的考题，可能会故意将 echo 和 my-app 两个调换位置。所以不要搞混了。他们其实只是个名字而已，叫什么都无所谓，但要分清谁访问谁。
题目“确保新的 NetworkPolicy 允许 namespace echo 中的 Pods 连接到 namespace my-app 中的 Pods 的 9000 端口”，这句话的意思是
echo 访问 my-app。所以
echo 是访问者，my-app 是被访问者。所以下面要创建一个 my-app 的 yaml，里面 ingress 流量控制的 matchLabels 写 project: echo。
翻译成白话，A 访问 B，我们应该在 B 上设置一个防火墙(ingress)，允许 A 来访问。

考点：NetworkPolicy 的创建

参考链接：https://kubernetes.io/zh-cn/docs/concepts/services-networking/network-policies/

#### 1. 查看ns的所有标签

```
ubuntu@kubeworker01:/Users/yangyong/arch/cka/3-networkpolicy$ k get ns echo --show-labels
NAME   STATUS   AGE   LABELS
echo   Active   45s   kubernetes.io/metadata.name=echo
```

#### 2. 打标签

注意！真实考试环境很有可能没有标签（当然默认标签也可以用，但太冗长了），我们需要自己打一个

```
ubuntu@kubeworker01:/Users/yangyong/arch/cka/3-networkpolicy$ k label ns echo project=echo
namespace/echo labeled
ubuntu@kubeworker01:/Users/yangyong/arch/cka/3-networkpolicy$ k get ns echo --show-labels
NAME   STATUS   AGE    LABELS
echo   Active   5m3s   kubernetes.io/metadata.name=echo,project=echo
```

#### 3. 手动新建yaml，如果忘记了apiVersion，可以查询k8s资源

```
ubuntu@kubeworker01:/Users/yangyong/arch/cka/3-networkpolicy$ k api-resources | grep networkpolicies
networkpolicies                   netpol       networking.k8s.io/v1              true         NetworkPolicy
```

#### 4. 创建networkpolicy

```
ubuntu@kubeworker01:/Users/yangyong/arch/cka/3-networkpolicy$ k apply -f networkpolicy.yaml
networkpolicy.networking.k8s.io/allow-port-from-namespace created
```

### 验证

```
ubuntu@kubeworker01:/Users/yangyong/arch/cka/3-networkpolicy$ k describe -n my-app networkpolicy
Name:         allow-port-from-namespace
Namespace:    my-app
Created on:   2024-06-18 23:28:09 +0800 CST
Labels:       <none>
Annotations:  <none>
Spec:
  PodSelector:     <none> (Allowing the specific traffic to all pods in this namespace)
  Allowing ingress traffic:
    To Port: 9000/TCP
    From:
      NamespaceSelector: project=echo
  Not affecting egress traffic
  Policy Types: Ingress
```