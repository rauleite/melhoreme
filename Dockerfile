FROM ubuntu
MAINTAINER raul@melhore.me

ENV DEBIAN_FRONTEND noninteractive

ENV PYTHON /usr/bin/python2.7

RUN sed -i 's/us-central1.gce/us-central1.gce.clouds/' /etc/apt/sources.list && sudo apt-get update
# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		wget \
		python2.7
		# build-essential \
		# libxss1 libappindicator1 libindicator7 xdg-utils 

# For node-gyp
RUN apt-get install -y build-essential

# For MongoDB
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

RUN	wget -q -O - http://dl-ssl.google.com/linux/linux_signing_key.pub |  apt-key add - \                                                                                    \
	&& echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
	&& apt-get update

RUN	apt-get install -y \
	google-chrome-stable

#RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
#	dpkg -i google-chrome*.deb 

RUN apt-get install -y --no-install-recommends \
	xfonts-base \
	xvfb
	
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 4.3.1

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN npm install -g gulp

#RUN apt-get autoremove -y \
#	&& apt-get clean -y \

ENV APP_NAME melhoreme

# RUN mkdir -p /usr/src/$APP_NAME

COPY . /usr/src/$APP_NAME

WORKDIR /usr/src/$APP_NAME
# COPY package.json /usr/src/$APP_NAME/

# COPY * /usr/src/$APP_NAME/

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN sudo apt-get install -y --force-yes mongodb-org

# RUN mongo --version
RUN mkdir -p /data/db
# ADD .bin/db-backup .bin/db-backup
# WORKDIR /usr/src/$APP_NAME
# RUN nohup mongod &
# RUN sleep 5
# RUN mongorestore ./db-backup --host=0.0.0.0

# RUN npm install

EXPOSE 8080
EXPOSE 3000

# CMD [ "gulp", "run" ]
# CMD ["mongorestore", "./db-backup"]