sudo docker stop nginx
sudo docker rm nginx
sudo docker build -t utd/nginx .
sudo docker run -p 80:80 -d --link=pronet --name nginx utd/nginx