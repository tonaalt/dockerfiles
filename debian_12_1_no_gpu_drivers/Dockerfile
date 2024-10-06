FROM debian:12.1
LABEL maintainer="toni.aaltonen@samk.fi"
RUN apt-get update && apt-get upgrade -y
RUN apt install  openssh-server sudo -y
RUN apt install -y zip htop screen libgl1-mesa-glx python3-pip
RUN useradd -rm -d /home/user -s /bin/bash -g root -G sudo -u 1000 user 
RUN  echo 'user:user' | chpasswd
RUN service ssh start
USER user
WORKDIR /home/user

USER root 
EXPOSE 22
EXPOSE 8888
RUN echo "export PATH=/home/user/.local/:$PATH" >> /home/user/.bashrc
CMD ["/bin/bash","-c", "/usr/sbin/sshd -D"]
# pyplot & 

