#!/bin/bash
set -e

# update kube config
aws configure set default.region ${CLUSTER_REGION}
if [ -n "${EKS_CLUSTER_NAME}" ];then
    aws eks --region ${CLUSTER_REGION} update-kubeconfig --name ${EKS_CLUSTER_NAME}
fi
# aws ECR configure
eval $(aws ecr get-login --no-include-email --region ${CLUSTER_REGION})

#aws ECS credential configure
ecs-cli configure profile --profile-name ecs-profile

exec "$@"
