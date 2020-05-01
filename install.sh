#!/bin/bash
set -e

#apk add --update -t deps curl make py-pip openssl

# install kubectl
# https://aur.archlinux.org/packages/kubectl-bin/
# curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
# chmod +x /usr/local/bin/kubectl

# # install Helm
# # https://helm.sh/docs/intro/install/#from-script
# curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | sh

# # install S3 plugin for Helm
# helm plugin install https://github.com/hypnoglow/helm-s3.git --version $HELM_S3_PLUGIN_VERSION

# # aws-iam-authenticator
# # https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
# curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator
# curl -o aws-iam-authenticator.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator.sha256
# openssl sha1 -sha256 aws-iam-authenticator
# chmod +x ./aws-iam-authenticator
# mv aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
# aws-iam-authenticator help

# # awscli
# pip install awscli
# aws --version

# # install YAML tools
# pip install yamllint yq

# update kube config
# aws configure set default.region ${CLUSTER_REGION}
aws eks --region ${CLUSTER_REGION} update-kubeconfig --name ${CLUSTER_NAME}

exec "$@"
