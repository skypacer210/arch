#!/bin/bash

# 创建NS
kubectl create ns ing-internal

# 创建ingressClass
kubectl apply -f ingress-class.yaml

# 创建hello deploy 和 service
kubectl apply -f hello.yaml