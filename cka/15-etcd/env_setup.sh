#!/bin/bash

#切换至root

mkdir /opt/KUIN00601

mkdir /var/lib/backup

# 拷贝ca证书
cp /etc/kubernetes/pki/etcd/ca.crt /opt/KUIN00601/ca.crt

# 拷贝client 证书
cp /etc/kubernetes/pki/etcd/server.crt /opt/KUIN00601/etcd-client.crt

# 拷贝client 秘钥
cp /etc/kubernetes/pki/etcd/server.key /opt/KUIN00601/etcd-client.key

# 如果没有etcdctl，需要先安装


# 生成etcd快照
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
snapshot save \
/data/backup/etcd-snapshot-previous.db