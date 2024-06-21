#!/bin/bash

kubectl create deployment --image=nginx front-end --dry-run=client -o yaml > front-end.yaml

kubectl apply -f front-end.yaml
