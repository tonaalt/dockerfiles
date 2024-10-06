FROM nvidia/cuda:11.8.0-devel-ubuntu22.04
LABEL maintainer="toni.aaltonen@samk.fi"
RUN apt-get update && apt-get upgrade -y
RUN apt install  openssh-server sudo -y
RUN apt install -y zip htop screen libgl1-mesa-glx python3-pip
RUN useradd -rm -d /home/user -s /bin/bash -g root -G sudo -u 1000 user 
RUN  echo 'user:user' | chpasswd
RUN service ssh start
USER user
WORKDIR /home/user
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
RUN pip3 install jupyterlab \ 
                 bitsandbytes==0.39.0 \
                 datasets==2.12.0 \
                 loralib==0.1.1 \
                 einops==0.6.1 \
                 transformers==4.30.1 \
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
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/libcudnn8_8.9.2.26-1+cuda11.8_amd64.deb

USER root 
EXPOSE 22
EXPOSE 8888
RUN echo "export PATH=/home/user/.local/:$PATH" >> /home/user/.bashrc
CMD ["/bin/bash","-c", "/usr/sbin/sshd -D ; screen -dmS jupyter lab --notebook-dir=/home/user/persistent"]
# pyplot & 

