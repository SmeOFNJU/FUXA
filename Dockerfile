FROM node:14

# Create app directory
WORKDIR /usr/src/app

# Clone FUXA repository
# RUN git clone https://github.com/frangoteam/FUXA.git
RUN git clone https://github.com/SmeOFNJU/FUXA.git

# Change working directory to beetle
WORKDIR /usr/src/app/beetle

# Install server
WORKDIR /usr/src/app/beetle/server
RUN npm install
RUN npm install morgan
RUN npm install socket.io
RUN npm install fs-extra
RUN npm install winston
RUN npm install ip


# Workaround for sqlite3 https://stackoverflow.com/questions/71894884/sqlite3-err-dlopen-failed-version-glibc-2-29-not-found
RUN apt-get update && apt-get install -y sqlite3 libsqlite3-dev && \
    apt-get autoremove -yqq --purge && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*  && \
    npm install --build-from-source --sqlite=/usr/bin sqlite3

ADD . /usr/src/app/beetle

WORKDIR /usr/src/app/beetle/server
EXPOSE 1881
CMD [ "npm", "start" ]
