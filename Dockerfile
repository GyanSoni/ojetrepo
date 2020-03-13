FROM node:10

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk wget unzip && \
    apt-get install -y gradle && \
    rm -rf /var/lib/apt/lists/*

ENV ANDROID_HOME /opt/android-sdk-linux

RUN mkdir .gradle && \
    cd .gradle && \
    echo "systemProp.http.proxyHost=www-proxy.server.url.com \nsystemProp.http.proxyPort=80\nsystemProp.https.proxyHost=www-proxy.server.url.com\nsystemProp.https.proxyPort=80" > gradle.properties && \
    cd ..

RUN mkdir -p ${ANDROID_HOME} && \
    cd ${ANDROID_HOME} && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O android_tools.zip && \
    unzip android_tools.zip && \
    rm android_tools.zip

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools
RUN yes | sdkmanager --licenses
RUN sdkmanager 'platform-tools'
RUN sdkmanager 'tools'
RUN sdkmanager 'platforms;android-26'
RUN sdkmanager 'platforms;android-28'
RUN sdkmanager 'build-tools;29.0.3'
RUN export PATH=${PATH}
RUN export ANDROID_HOME=${ANDROID_HOME}

RUN npm install -g @oracle/ojet-cli
RUN npm install -g cordova