# ProNet Web Portal

## Installation

We will be using Docker to set up the development environment for this rails app. 

Please install Docker for your platform from this download page. [https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/)

Now, wherever you cloned this directory, `cd` into the directory. 

To bring the server up and listening execute this command.

`docker-compose up --build`

To execute any rails or rake commands you will have to prefix that command with `docker-compose run web <command>`

For example, to create and migrate the database, execute the following.

`docker-compose run web rake db:create && rails db:migrate`

Now, navigate to [http://localhost:3000](http://localhost:3000) to see the home page.

### Caveats

On windows, when running the `docker-compose run` command, make sure you use the `--rm` option to destroy the container after you run the command. For example: `docker-compose run --rm web rake db:create`