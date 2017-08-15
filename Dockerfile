FROM centos:7
MAINTAINER tjtjtjtj

RUN yum -y install openssh-server openssh
RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t dsa -N "" -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t ecdsa -N "" -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -t ed25519 -N "" -f /etc/ssh/ssh_host_ed25519_key

RUN mkdir /var/run/sshd
RUN sed -ri 's/^#RSAAuthentication yes/RSAAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

RUN useradd -d /home/docker docker
RUN mkdir -p /home/docker/.ssh
RUN chmod 700 /home/docker/.ssh
COPY ./keys/docker_id_rsa.pub /home/docker/.ssh/authorized_keys
RUN chmod 600 /home/docker/.ssh/authorized_keys
RUN chown -R docker:docker /home/docker/.ssh
RUN sed -ri 's/docker:x/docker:/' /etc/passwd

RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
