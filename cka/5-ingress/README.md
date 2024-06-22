### 题目

设置配置环境：

    [candidate@node-1] $ kubectl config use-context k8s

Task
如下创建一个新的 nginx Ingress 资源：      
名称: ping        
Namespace: ing-internal     
使用服务端口 5678 在路径 /hello 上公开服务 hello

可以使用以下命令检查服务 hello 的可用性，该命令应返回 hello：

    curl -kL <INTERNAL_IP>/hello

### 准备环境

考试时候无需，直接按照题目要求切换集群即可！！！

执行准备脚本

    bash ./env_setup.sh

### 答题

考点：Ingress 的创建

参考链接：https://kubernetes.io/zh-cn/docs/concepts/services-networking/ingress/

#### 1. 切换集群

    kubectl config use-context k8s

#### 2. 获取ingressclass

    kubectl get ingressclass

#### 3. 拷贝官文的 yaml 案例minimal-ingress.yaml，修改相关参数即可，

    vim ingress.yaml

#### 4. 创建ingress

    kubectl apply -f ingress.yaml

### 验证

查看 ingress 的 IP，然后通过提供的 curl 命令，测试 ingress 是否通。
创建 ingress 后，需要等约 3 分钟后，才会获取到 IP 地址。