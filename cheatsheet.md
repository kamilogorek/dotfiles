# vim
## map enter to arbitrary command
:map <cr> :w\|:!my-command args<cr>

# docker
## run postgres
docker run --rm --name pg-docker -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres
## run mongodb
docker run --rm --name mongo-docker -e MONGO_INITDB_ROOT_USERNAME=mongo -e MONGO_INITDB_ROOT_PASSWORD=docker -d -p 27017:27017 -v $HOME/docker/volumes/mongodb:/data/db mongo
## run mysql (mariadb)
docker run --rm --name mysql-docker -e MYSQL_USER=root -e MYSQL_ROOT_PASSWORD=docker -d -p 3306:3306 -v $HOME/docker/volumes/mysql:/var/lib/mysql mariadb

# sentry
## bump symbolic
VERSION=10.2.0; sed -i '' "s/symbolic\(..\).*/symbolic\1$VERSION/g" $(find . -type f -name 'requirements*.txt') && (git branch -D bump-symbolic || true) && git co -b bump-symbolic && git commit -am "deps: Update symbolic to $VERSION"
