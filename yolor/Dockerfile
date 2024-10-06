FROM nvcr.io/nvidia/pytorch:20.11-py3
LABEL maintainer="toni.aaltonen@samk.fi"

# Update the image to the latest packages
RUN apt-get update && apt-get upgrade -y
RUN apt install  openssh-server sudo -y
RUN useradd -rm -d /home/user -s /bin/bash -g root -G sudo -u 1000 user 
RUN  echo 'user:user' | chpasswd
RUN service ssh start
# apt install required packages
RUN apt install -y zip htop screen libgl1-mesa-glx
RUN apt install -y python3-pip
# pip install required packages
# we change to user for pip installs 
USER user
WORKDIR /home/user
RUN git clone https://github.com/WongKinYiu/yolor.git
RUN pip install -qr yolor/requirements.txt
RUN pip3 install seaborn thop
#RUN git clone https://github.com/JunnYu/mish-cuda
#RUN cd mish-cuda && python3 setup.py build install
RUN git clone https://github.com/fbcotter/pytorch_wavelets
RUN cd pytorch_wavelets && pip3 install .
RUN bash yolor/scripts/get_coco.sh
RUN rm -f -r cookie
#RUN pip3 install -qr yolor/requirements.txt
RUN pip3 install torch==1.10.1+cu111 torchvision==0.11.2+cu111 torchaudio==0.10.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN pip3 install numpy pycocotools PyYAML typing_extensions scipy 
USER root
# Back to root, so we ssh is playing nice
RUN pip3 install gdown
# getting pretrained weights is totally broken in repo, used this way, might break at some point
#get pretrained weights, trained with coco
#get coco dataset and setup files
RUN cd /home/user/yolor/ && gdown 1Tdn3yqpZ79X7R1Ql0zNlNScB1Dv9Fp76
RUN cd /home/user/yolor/ && gdown 1UflcHlN5ERPdhahMivQYCbWWw7d2wY7U
RUN unzip coco2017labels.zip -d /home/user
#RUN mkdir /home/user/coco/images
RUN unzip val2017.zip -d /home/user/coco/images
EXPOSE 22
RUN echo "export PATH=/home/user/.local/:$PATH" >> /home/user/.bashrc
#RUN chmod +rw /home/user/coco /home/user/yolor
RUN chown -R user /home/user/coco /home/user/yolor
CMD ["/usr/sbin/sshd","-D"]
#yolor1034 working one
#python3 test.py --data data/coco.yaml --img 1280 --batch 32 --conf 0.001 --iou 0.65 --device 0 --cfg cfg/yolor_p6.cfg --weights yolor_p6.pt --name yolor_p6_val
