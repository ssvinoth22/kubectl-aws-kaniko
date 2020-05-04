#!/bin/bash
set -e

aws eks --region ${CLUSTER_REGION} update-kubeconfig --name ${CLUSTER_NAME}

eval $(aws ecr get-login --no-include-email --region ${CLUSTER_REGION})

exec "$@"
