FROM nvcr.io/nvidia/pytorch:21.08-py3
LABEL maintainer="toni.aaltonen@samk.fi"
# Update the image to the latest packages
RUN apt-get update && apt-get upgrade -y
RUN apt install  openssh-server sudo -y
RUN apt install -y zip htop screen libgl1-mesa-glx
RUN useradd -rm -d /home/user -s /bin/bash -g root -G sudo -u 1000 user 
RUN  echo 'user:user' | chpasswd
RUN service ssh start
USER user
WORKDIR /home/user
RUN pip3 install jupyterlab
RUN mkdir /home/user/.jupyter && touch .jupyter/jupyter_lab_config.py && echo "c = get_config()" >> .jupyter/jupyter_lab_config.py && echo "c.LabServerApp.open_browser = False" >> .jupyter/jupyter_lab_config.py && echo "c.ServerApp.ip = '0.0.0.0'" >> .jupyter/jupyter_lab_config.py && echo "c.NotebookApp.notebook_dir = '/home/user/persistent'" >> .jupyter/jupyter_lab_config.py
RUN git clone https://github.com/WongKinYiu/yolov7.git
RUN mkdir weights
WORKDIR /home/user/weights
RUN wget https://github.com/WongKinYiu/yolov7/releases/download/v0.1/yolov7_training.pt
RUN pip3 install --no-cache-dir -r /home/user/yolov7/requirements.txt
WORKDIR /home/user
USER root
# apt install required packages
#RUN apt install -y zip htop screen libgl1-mesa-glx
#RUN apt install -y python3-pip
# pip install required packages
# we change to user for pip installs
#  /home/user/.jupyter && touch  && echo .jupyter/jupyter_lab_config.py && echo "c = get_config()" >> .jupyter/jupyter_lab_config.py
RUN apt update
RUN apt install -y nano graphviz 
EXPOSE 22
EXPOSE 8888
EXPOSE 6006
RUN echo "export PATH=/home/user/.local/bin:$PATH" >> /home/user/.bashrc
CMD ["/usr/sbin/sshd","-D"]

# add screen
# pyplot & 

