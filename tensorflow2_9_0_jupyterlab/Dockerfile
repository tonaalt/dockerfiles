FROM tensorflow/tensorflow:2.9.0-gpu
LABEL maintainer="toni.aaltonen@samk.fi"

# Update the image to the latest packages
RUN apt-get update && apt-get upgrade -y
RUN apt install  openssh-server sudo -y
RUN useradd -rm -d /home/user -s /bin/bash -g root -G sudo -u 1000 user 
RUN  echo 'user:user' | chpasswd
RUN service ssh start
USER user
WORKDIR /home/user
RUN pip3 install jupyterlab
RUN mkdir /home/user/.jupyter && touch .jupyter/jupyter_lab_config.py && echo "c = get_config()" >> .jupyter/jupyter_lab_config.py && echo "c.LabServerApp.open_browser = False" >> .jupyter/jupyter_lab_config.py && echo "c.ServerApp.ip = '0.0.0.0'" >> .jupyter/jupyter_lab_config.py && echo "c.NotebookApp.notebook_dir = '/home/user/persistent'" >> .jupyter/jupyter_lab_config.py
USER root
# apt install required packages
#RUN apt install -y zip htop screen libgl1-mesa-glx
#RUN apt install -y python3-pip
# pip install required packages
# we change to user for pip installs
#  /home/user/.jupyter && touch  && echo .jupyter/jupyter_lab_config.py && echo "c = get_config()" >> .jupyter/jupyter_lab_config.py 
EXPOSE 22
EXPOSE 8888
RUN echo "export PATH=/home/user/.local/:$PATH" >> /home/user/.bashrc
CMD ["/usr/sbin/sshd","-D"]

# add screen
# pyplot & 

