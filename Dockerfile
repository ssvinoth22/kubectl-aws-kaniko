FROM gcr.io/kaniko-project/executor:latest as kaniko
FROM alpine:3.11

# https://aur.archlinux.org/packages/kubectl-bin/
ENV KUBECTL_VERSION "1.17.4"

# set some defaults
ENV AWS_DEFAULT_REGION "us-west-2"

# https://github.com/hypnoglow/helm-s3
ENV HELM_S3_PLUGIN_VERSION "0.9.2"

RUN apk --no-cache upgrade \
  && apk add --update bash ca-certificates git python \
  && apk add --update -t deps curl make py-pip openssl  \
  && apk add docker openrc \
  && rc-update add docker boot 
#   && docker version
# copy kaniko tools
COPY --from=kaniko /kaniko /kaniko
RUN chmod +x /kaniko

ENV PATH=/kaniko:$PATH
ENV DOCKER_CONFIG='/kaniko/.docker'

#install kubectl
# https://aur.archlinux.org/packages/kubectl-bin/
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl

# install Helm
# https://helm.sh/docs/intro/install/#from-script
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | sh 

# install S3 plugin for Helm
RUN helm plugin install https://github.com/hypnoglow/helm-s3.git --version ${HELM_S3_PLUGIN_VERSION}

# install skaffold 
RUN curl -L https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 -o skaffold \
&& chmod +x skaffold \
&& mv skaffold /usr/local/bin

# aws-iam-authenticator
# https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
RUN curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator \
    && curl -o aws-iam-authenticator.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator.sha256 \
    &&  openssl sha1 -sha256 aws-iam-authenticator \
    &&  chmod +x ./aws-iam-authenticator \
    &&  mv aws-iam-authenticator /usr/local/bin/aws-iam-authenticator \
    &&  aws-iam-authenticator help

# awscli
RUN pip install awscli 

# install YAML tools
RUN pip install yamllint yq

# cleanup
RUN apk del --purge deps \
&& rm /var/cache/apk/* \
&& rm -rf /tmp/*

COPY install.sh /opt/install.sh
#RUN /opt/install.sh


RUN mkdir -p kube
RUN chmod +x /opt/install.sh

ENTRYPOINT [ "/opt/install.sh" ]
CMD ["bash"]