FROM centos:7
MAINTAINER tjtjtjtj

RUN yum groupinstall "Base"

CMD ["/bin/bash"]
