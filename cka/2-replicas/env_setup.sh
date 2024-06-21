#!/bin/bash

k create deployment --image=nginx nginx --dry-run=client -o yaml > presentation.yaml

k apply -f presentation.yaml
