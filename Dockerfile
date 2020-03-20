FROM quay.io/openshift/origin-jenkins-agent-nodejs:4.3

USER root

COPY google-chrome.repo /etc/yum.repos.d/google-chrome.repo

RUN INSTALL_PKGS="google-chrome-stable" && \
    DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-fast-datapath --disablerepo=rhel-fast-datapath-beta --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl" && \
    curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
    curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum $DISABLES -y --setopt=tsflags=nodocs --disableplugin=subscription-manager install epel-release && \
    yum $DISABLES -y --setopt=tsflags=nodocs --disableplugin=subscription-manager install $INSTALL_PKGS && \
    rpm -V  $INSTALL_PKGS && \
    yum clean all  && \
    localedef -f UTF-8 -i en_US en_US.UTF-8

USER 1001
