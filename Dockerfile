FROM jtidocker/jticellular

WORKDIR /usr/src/app
COPY phantomjs-2.1.1-linux-x86_64.tar.bz2 /tmp/phantomjs/
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production
# Bundle app source
COPY . .

# apk build at /usr/src/app/hybrid/platforms/android/app/build/outputs/apk/debug/app-debug.apk
# Commands to run the apk builder:
# docker build -t build-name .
# docker run -it -v (local folder):/usr/src/app/apk build-name /usr/src/app/copyAPK.sh
RUN [ "ojet", "build", "android" ]