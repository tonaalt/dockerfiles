FROM nvidia/cuda:12.6.0-devel-ubuntu24.04
LABEL maintainer="toni.aaltonen@samk.fi"
RUN apt-get update && apt-get upgrade -y
RUN apt install  openssh-server sudo -y
RUN apt install -y zip htop screen python3-pip
RUN apt-get install -y --no-install-recommends python3-venv 
RUN olduser="$(getent passwd 1000 | cut -d: -f1)" \
 && usermod -l user -d /home/user -m "$olduser"
RUN  echo 'user:user' | chpasswd
RUN service ssh start
USER user
WORKDIR /home/user
RUN python3 -m venv /home/user/.venv
ENV PATH="/home/user/.venv/bin:$PATH"
RUN pip install --upgrade pip \
 && pip install --index-url https://download.pytorch.org/whl/cu126 \
        --extra-index-url https://pypi.org/simple \
        torch torchvision

RUN pip install jupyterlab \ 
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
