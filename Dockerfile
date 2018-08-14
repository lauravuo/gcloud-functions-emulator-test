FROM google/cloud-sdk:latest

COPY .docker/config.json /root/.config/configstore/@google-cloud/functions-emulator/config.json

WORKDIR /root/build

# The Emulator only supports Node v6.x.x
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install -y nodejs && \
  npm install -g @google-cloud/functions-emulator

COPY ./build /root/build
COPY ./package.json /root/build/package.json
COPY ./package-lock.json /root/build/package-lock.json

RUN npm install --only=production
