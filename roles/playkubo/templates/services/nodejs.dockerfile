FROM resin/rpi-raspbian

# Install dependencies
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y unzip 
RUN apt-get install -y build-essential
RUN apt-get install -y nodejs
RUN apt-get install -y npm

ADD src/ /src
WORKDIR /src

RUN npm install

EXPOSE 8080
 
CMD ["nodejs", "server.js"]