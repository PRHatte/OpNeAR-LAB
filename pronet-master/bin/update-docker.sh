# Note: Please run this from the root directory of the project.
# 

REDIS_CONTAINER_NAME=redis
NGINX_CONTAINER_NAME=nginx
RAILS_CONTAINER_NAME=pronet
SIDEKIQ_CONTAINER_NAME=sidekiq


# Pull the latest changes
echo "Pulling the latest changes on git..."
git pull origin master

# Shutdown the apps
# 
echo "Stopping down the app services"
sudo docker stop $RAILS_CONTAINER_NAME
sudo docker rm $RAILS_CONTAINER_NAME
sudo docker stop $SIDEKIQ_CONTAINER_NAME
sudo docker rm $SIDEKIQ_CONTAINER_NAME

# Stop the services
# 
echo "Stopping the services"
sudo docker stop $REDIS_CONTAINER_NAME
sudo docker rm $REDIS_CONTAINER_NAME

sudo docker stop $NGINX_CONTAINER_NAME
sudo docker rm $NGINX_CONTAINER_NAME

# Start redis first
# 
sudo docker run -P -d --name $REDIS_CONTAINER_NAME redis

# Prepare the rails container
sudo docker build -t utd/pronet -f Dockerfile .
sudo docker run -p 3000:3000 -d --link=$REDIS_CONTAINER_NAME --name $RAILS_CONTAINER_NAME utd/pronet

sudo docker build -t utd/sidekiq -f Dockerfile-sidekiq .
sudo docker run -d --link=$REDIS_CONTAINER_NAME --name $SIDEKIQ_CONTAINER_NAME utd/sidekiq


# Nginx is last
cd docker
sudo docker build -t utd/nginx .
sudo docker run -p 80:80 -d --link=$RAILS_CONTAINER_NAME --name $NGINX_CONTAINER_NAME utd/nginx