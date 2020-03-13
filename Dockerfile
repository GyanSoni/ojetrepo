FROM node:current-slim

WORKDIR /usr/src/app

# COPY phantomjs-2.1.1-linux-x86_64.tar.bz2 /tmp/phantomjs/
COPY package*.json ./
RUN apt-get update
RUN apt-get install bzip2
RUN npm config set registry https://registry.npmjs.com/
RUN npm install

# If you are building your code for production
# RUN npm ci --only=production
# Put app source into docker
COPY . .

# APK build at /usr/src/app/hybrid/platforms/android/app/build/outputs/apk/debug/app-debug.apk
# Commands to run the apk builder:
# docker build -t gerardgm/ojet-android .
# docker run -it -v C:\Users\gerargar\ojetapps\ProsegurGo\apks:/usr/src/app/apks gerardgm/prosegur-build /usr/src/app/script/android_build_script.sh version1 version2