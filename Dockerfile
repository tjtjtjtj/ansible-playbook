FROM centos:7
MAINTAINER tjtjtjtj

RUN yum -y install openssh-server
RUN useradd docker
RUN mkdir -p /home/docker/.ssh
RUN chmod 700 /home/docker/.ssh
COPY ./keys/docker_id_rsa.pub /home/docker/.ssh/authorized_keys
RUN chmod 600 /home/docker/.ssh/authorized_keys
RUN chown -R docker:docker /home/docker/.ssh
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN systemctl start sshd
RUN systemctl stop sshd

RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
