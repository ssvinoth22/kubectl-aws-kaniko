## Example Usage

```sh
# start up an image to administer an AWS EKS cluster
docker run -it \
  -e AWS_ACCESS_KEY_ID="<AWS key>" \
  -e AWS_SECRET_ACCESS_KEY="<AWS secret>" \
  -e AWS_DEFAULT_REGION="us-west-2" \
  coastapp/kube-tools-aws:latest
docker run -it \
  -e AWS_ACCESS_KEY_ID="<AWS key>" \
  -e AWS_SECRET_ACCESS_KEY="<AWS secret>" \
  -e CLUSTER_NAME="<clustername>" \
  -e CLUSTER_REGION="us-west-2" \
  ssvinoth22/kubectl-aws-skaffold:1.0.0

# the above command drops into a bash shell with
# all of the tooling for the following commands...

# configure kubectl auth for an existing EKS cluster named "my-cluster"
aws eks update-kubeconfig --name my-cluster

# confirm it worked by listing your pods
kubectl get pods --all-namespaces

# or list your helm deployments
helm ls --all-namespaces

# now do stuff for your CI/CD process...
```
