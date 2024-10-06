### build an updated container
### build container in this folder
sudo docker build -t torch_test1 .
### starting container
sudo screen -d -m sudo docker run --rm -p 2213:22 --gpus "device=0" -it --name torch_p0 torch_test_production:latest
###
docker attach
### check running containers
sudo docker ps -q
### 
### kill all running containers
docker kill $(docker ps -q)