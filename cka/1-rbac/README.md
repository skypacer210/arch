### 题目

设置配置环境：

    [candidate@node-1] $ kubectl config use-context k8s

Context

为部署流水线创建一个新的 ClusterRole 并将其绑定到范围为特定的 namespace 的特定 ServiceAccount。

Task

创建一个名为 deployment-clusterrole 且仅允许创建以下资源类型的新 ClusterRole：
Deployment
StatefulSet
DaemonSet

在现有的 namespace app-team1 中创建一个名为 cicd-token 的新 ServiceAccount。
限于 namespace app-team1 中，将新的 ClusterRole deployment-clusterrole 绑定到新的 ServiceAccount cicd-token。

### 准备环境

考试时候无需，直接按照题目要求切换集群即可！！！

执行准备脚本

    bash ./env_setup.sh

### 答题

#### 1. 创建clusterrole

    k create clusterrole deployment-clusterrole --verb=create --resource=deployments,statefulsets,daemonsets

#### 2. 新建Serviceaccount

    k -n app-team1 create serviceaccount cicd-token

#### 4. 创建broleinding

    k -n app-team1 create rolebinding cicd-token-rolebinding --clusterrole=deployment-clusterrole --serviceaccount=app-team1:cicd-token

### 验证

基于auth命令验证角色是否有对资源进行操作的权限

    k auth can-i create deployment --as system:serviceaccount:app-team1:cicd-token

期望返回no

    k auth can-i create deployment --as system:serviceaccount:app-team1:cicd-token -n app-team1

期望返回yes
