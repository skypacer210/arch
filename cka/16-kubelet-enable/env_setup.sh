#!/bin/bash

# 停止Kubelet进程
sudo systemctl disable kubelet

# 查看进程状态
systemctl status kubelet