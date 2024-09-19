### 题目

设置配置环境：

[candidate@node-1] $ kubectl config use-context wk8s

Task

名为 node02 的 Kubernetes worker node 处于 NotReady 状态。      
调查发生这种情况的原因，并采取相应的措施将 node 恢复为 Ready 状态，确保所做的任何更改永久生效。      
可以使用以下命令，通过 ssh 连接到 node02 节点：

    ssh node02

可以使用以下命令，在该节点上获取更高权限：

    sudo -i

### 准备环境

考试时候无需，直接按照题目要求切换集群即可！！！

执行准备脚本

    bash ./env_setup.sh

### 解析

考点：将现有的 deploy 暴露成 nodeport 的 service。

参考链接：https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/deployment/

### 答题

#### 1. 登录node2

    ssh node02

#### 2. 切换为root

    sudo -i

#### 3. 启动 kubelet 服务

    systemctl start kubelet

#### 4. 设置为开机启动

```
ubuntu@kubeworker02:~$ sudo systemctl enable kubelet
Created symlink /etc/systemd/system/multi-user.target.wants/kubelet.service → /lib/systemd/system/kubelet.service.
```

#### 5. 检查

```
ubuntu@kubeworker02:~$ systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /usr/lib/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: active (running) since Thu 2024-06-20 10:26:39 CST; 1min 1s ago
       Docs: https://kubernetes.io/docs/
   Main PID: 290854 (kubelet)
      Tasks: 10 (limit: 3478)
     Memory: 34.0M
        CPU: 879ms
     CGroup: /system.slice/kubelet.service
             └─290854 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime-endpoi>

Jun 20 10:27:34 kubeworker02 kubelet[290854]: E0620 10:27:34.047947  290854 remote_image.go:180] "PullImage from image service failed" err="rpc error: code = Unknown desc = failed to pull and unpack image \">
Jun 20 10:27:34 kubeworker02 kubelet[290854]: E0620 10:27:34.047988  290854 kuberuntime_image.go:55] "Failed to pull image" err="failed to pull and unpack image \"docker.io/library/nginx-slim:0.8\": failed t>
Jun 20 10:27:34 kubeworker02 kubelet[290854]: E0620 10:27:34.048200  290854 kuberuntime_manager.go:1262] container &Container{Name:webapp,Image:nginx-slim:0.8,Command:[],Args:[],WorkingDir:,Ports:[]Container>
Jun 20 10:27:34 kubeworker02 kubelet[290854]: E0620 10:27:34.048238  290854 pod_workers.go:1298] "Error syncing pod, skipping" err="failed to \"StartContainer\" for \"webapp\" with ErrImagePull: \"failed to >
Jun 20 10:27:34 kubeworker02 kubelet[290854]: I0620 10:27:34.896076  290854 scope.go:117] "RemoveContainer" containerID="fcf542990eebfe217e7848894aed49caf5309fc09739f88bf38f7b6a493c5f1c"
Jun 20 10:27:34 kubeworker02 kubelet[290854]: E0620 10:27:34.896493  290854 pod_workers.go:1298] "Error syncing pod, skipping" err="failed to \"StartContainer\" for \"converter\" with CrashLoopBackOff: \"bac>
Jun 20 10:27:38 kubeworker02 kubelet[290854]: I0620 10:27:38.704936  290854 scope.go:117] "RemoveContainer" containerID="de452a32cecc1bb8fc6b93b8f2e1e8e9c2c8fba3312845608ff1ff7b46a2c798"
Jun 20 10:27:38 kubeworker02 kubelet[290854]: I0620 10:27:38.705105  290854 scope.go:117] "RemoveContainer" containerID="3440c03936b39e85e7bbf66878efaaf8fc2bcff7a9819307479ff54f1c0d9f24"
Jun 20 10:27:38 kubeworker02 kubelet[290854]: E0620 10:27:38.705209  290854 pod_workers.go:1298] "Error syncing pod, skipping" err="failed to \"StartContainer\" for \"converter\" with CrashLoopBackOff: \"bac>
Jun 20 10:27:40 kubeworker02 kubelet[290854]: I0620 10:27:40.900721  290854 scope.go:117] "RemoveContainer" containerID="46659c95773884fb9ea3dde96b03bf866b40e13544d7d870e29e9ebe45dc60e0"
```

#### 6. 切记，做完后，要退回到初始节点

    exit

    exit

### 验证

再次检查节点状态， 确保 node02 节点恢复 Ready 状态

```
ubuntu@kubeworker02:~$ kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
kubemaster     Ready    control-plane   11d   v1.29.5
kubeworker01   Ready    <none>          11d   v1.29.5
kubeworker02   Ready    <none>          11d   v1.29.5
```
