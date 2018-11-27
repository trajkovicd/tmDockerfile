FROM registry.access.redhat.com/rhel7/rhel:latest
USER root
LABEL name="Solution-Soft/Time Machine" vendor="SolutionSoft Systems Inc" version="1.1" release="1" summary="Time Machine Container" description="Time Machine creates virtual clocks for time shift testing of Applications" url="https://solution-soft.com" maintainer="Dragan Trajkovic - SolutionSoft Systems Inc."
COPY help.1 /
RUN mkdir -p "/licenses"
COPY licenses /licenses
RUN yum repolist --disablerepo=* \
    &&     yum-config-manager --disable \* > /dev/null \
    &&     yum-config-manager --enable rhel-7-server-rpms > /dev/null
RUN yum -y update-minimal --security --sec-severity=Important --sec-severity=Critical --setopt=tsflags=nodocs
ADD tm_linux_2.6.up_x86_64-12.7R22.tgz /
RUN echo timemachine.example.com > /etc/hostname
RUN useradd -ms /bin/bash tester1
USER tester1
