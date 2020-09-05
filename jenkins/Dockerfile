FROM jenkins/jenkins:2.254
USER root
COPY hudson.model.UpdateCenter.xml .
COPY sources.list .
RUN mv hudson.model.UpdateCenter.xml /usr/share/jenkins/ref/hudson.model.UpdateCenter.xml
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bac
RUN mv sources.list /etc/apt/sources.list

#--recv可能需要变化
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 40976EAF437D05B5
RUN apt-get update
RUN apt-get install libicu-dev -y

ENV JENKINS_UC "https://updates.jenkins-zh.cn"
ENV JENKINS_UC_DOWNLOAD "https://mirrors.tuna.tsinghua.edu.cn/jenkins"
ENV JENKINS_OPTS="-Dhudson.model.UpdateCenter.updateCenterUrl=https://updates.jenkins-zh.cn/update-center.json"

RUN /usr/local/bin/install-plugins.sh cloudbees-folder 
RUN /usr/local/bin/install-plugins.sh antisamy-markup-formatter 
RUN /usr/local/bin/install-plugins.sh build-timeout 
RUN /usr/local/bin/install-plugins.sh credentials-binding 
RUN /usr/local/bin/install-plugins.sh timestamper 
RUN /usr/local/bin/install-plugins.sh ws-cleanup 
RUN /usr/local/bin/install-plugins.sh ant 
RUN /usr/local/bin/install-plugins.sh gradle 
RUN /usr/local/bin/install-plugins.sh pipeline-stage-view 
RUN /usr/local/bin/install-plugins.sh pipeline-build-step 
RUN /usr/local/bin/install-plugins.sh pipeline-model-api 
RUN /usr/local/bin/install-plugins.sh pipeline-model-extensions 
RUN /usr/local/bin/install-plugins.sh git-server 
RUN /usr/local/bin/install-plugins.sh workflow-cps-global-lib 
RUN /usr/local/bin/install-plugins.sh branch-api 
RUN /usr/local/bin/install-plugins.sh workflow-multibranch 
RUN /usr/local/bin/install-plugins.sh pipeline-stage-tags-metadata 
RUN /usr/local/bin/install-plugins.sh pipeline-model-definition 
RUN /usr/local/bin/install-plugins.sh lockable-resources 
RUN /usr/local/bin/install-plugins.sh workflow-aggregator 
RUN /usr/local/bin/install-plugins.sh okhttp-api 
RUN /usr/local/bin/install-plugins.sh github-api 
RUN /usr/local/bin/install-plugins.sh github 
RUN /usr/local/bin/install-plugins.sh github-branch-source 
RUN /usr/local/bin/install-plugins.sh pipeline-github-lib 
RUN /usr/local/bin/install-plugins.sh pipeline-stage-view 
RUN /usr/local/bin/install-plugins.sh ssh-slaves 
RUN /usr/local/bin/install-plugins.sh matrix-auth 
RUN /usr/local/bin/install-plugins.sh pam-auth 
RUN /usr/local/bin/install-plugins.sh ldap 
RUN /usr/local/bin/install-plugins.sh email-ext 
RUN /usr/local/bin/install-plugins.sh localization-support 
RUN /usr/local/bin/install-plugins.sh localization-zh-cn
