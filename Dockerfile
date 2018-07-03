FROM jenkins/jenkins:2.130-alpine

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

USER root

RUN apk update \
&& apk add docker shadow \
&& curl -Lo /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.10.5/bin/linux/amd64/kubectl \
&& chmod +x /usr/bin/kubectl \
&& usermod -aG docker jenkins

COPY jenkins/ /usr/share/jenkins/

RUN chown -R jenkins:root /usr/share/jenkins/ref \
&& /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER jenkins
