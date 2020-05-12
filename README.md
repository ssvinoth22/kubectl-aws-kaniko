# kubectl-aws-Kaniko
A Docker image (based on Alpine) that comes with all the tools you need to work with Kubernetes, Helm charts, kaniko , AWS (awscli), and AWS EKS. Intended to be a flexible foundation of tools for CI/CD workflows.

Included Tools

 kubectl - https://kubernetes.io/docs/reference/kubectl/overview/

 Helm 3 - https://github.com/kubernetes/helm

skkafold - https://skaffold.dev/docs/install/

Helm S3 plugin - https://github.com/hypnoglow/helm-s3

awscli https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html

aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator

yamllint - https://github.com/adrienverge/yamllint

yq (YAML parser based on jq) - https://github.com/kislyuk/yq

kaniko executor

Example Usage
#start up an image to administer an AWS EKS cluster
kubectl-aws-kaniko:1.0.0
```
   docker run -it \
  -e AWS_ACCESS_KEY_ID="<AWS key>" \
  -e AWS_SECRET_ACCESS_KEY="<AWS secret>" \
  -e CLUSTER_NAME=<Clustername> \
  -e CLUSTER_REGION=us-west-2 \
  ssvinoth22/kubectl-aws-kaniko:1.0.0


kubectl-aws-kaniko:2.0.0 support ECS and make EKS cluster name as optional

docker run -it \
  -e AWS_ACCESS_KEY_ID="<AWS key>" \
  -e AWS_SECRET_ACCESS_KEY="<AWS secret>" \
  -e EKS_CLUSTER_NAME=<Clustername> \
  -e CLUSTER_REGION=us-west-2 \
  ssvinoth22/kubectl-aws-kaniko:2.0.0

docker run -it \
  -e AWS_ACCESS_KEY_ID="<AWS key>" \
  -e AWS_SECRET_ACCESS_KEY="<AWS secret>" \
  -e CLUSTER_REGION=us-west-2 \
  ssvinoth22/kubectl-aws-kaniko:2.0.0

#the above command drops into a bash shell with

# Automatically register ECR login

#confirm it worked by listing your pods
kubectl get pods --all-namespaces


#kaniko to build and push docker image to ECR
/kaniko/executor --dockerfile=dockerfile --destination=<ACCOUNTNUMBER>.dkr.ecr.<REGION>.amazonaws.com/<REPO>:<VERSION>


```

Documentation:  https://github.com/GoogleContainerTools/kaniko   

git repo: https://github.com/ssvinoth22/kubectl-aws-skaffold
