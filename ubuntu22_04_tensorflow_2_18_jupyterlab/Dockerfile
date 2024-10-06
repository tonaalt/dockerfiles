FROM tensorflow/tensorflow:2.18.0rc0-gpu-jupyter
LABEL maintainer="toni.aaltonen@samk.fi"
RUN apt-get update && apt-get upgrade -y
RUN apt install  openssh-server sudo -y
RUN apt install -y zip htop screen libgl1-mesa-glx python3-pip
RUN useradd -rm -d /home/user -s /bin/bash -g root -G sudo -u 1000 user 
RUN  echo 'user:user' | chpasswd
RUN service ssh start
USER user
WORKDIR /home/user
RUN pip3 install jupyterlab \ 
                 bitsandbytes \
                 datasets \
                 loralib \
                 einops \
                 transformers \
                 opencv-python \
                 requests \
                 pandas \
                 peft \
                 tokenizers \
                 wget \
                 Flask \
                 BeautifulSoup4 \
                 Selenium \
                 loralib \
                 einops
RUN mkdir /home/user/.jupyter && touch .jupyter/jupyter_lab_config.py && echo "c = get_config()" >> .jupyter/jupyter_lab_config.py \
                              && echo "c.LabServerApp.open_browser = False" >> .jupyter/jupyter_lab_config.py \ 
                              && echo "c.ServerApp.ip = '0.0.0.0'" >> .jupyter/jupyter_lab_config.py \ 
                              && echo "c.NotebookApp.notebook_dir = '/home/user/persistent'" >> .jupyter/jupyter_lab_config.py


USER root 
EXPOSE 22
EXPOSE 8888
RUN echo "export PATH=/home/user/.local/:$PATH" >> /home/user/.bashrc
CMD ["/bin/bash","-c", "/usr/sbin/sshd -D"]
