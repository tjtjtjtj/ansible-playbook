FROM centos:6
MAINTAINER tjtjtjtj

RUN yum -y install openssh-server
RUN useradd docker
RUN mkdir -p /home/docker/.ssh
RUN chmod 700 /home/docker/.ssh
COPY ./keys/docker_id_rsa.pub /home/docker/.ssh/authorized_keys
RUN chmod 600 /home/docker/.ssh/authorized_keys
RUN chown -R docker:docker /home/docker/.ssh

RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
