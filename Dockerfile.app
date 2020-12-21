FROM emergya/ionic-builder:latest as builder

WORKDIR /app

# set context to source code
COPY package*.json /app/

RUN npm install

COPY ./ /app/

RUN ionic build browse --no-interactive --confirm

RUN ionic cordova platform add android &&\
    ionic cordova build --release android --no-interactive --confirm

FROM nginx:1.19

RUN mkdir /artifacts

COPY --from=builder /app/www /usr/share/nginx/html
COPY --from=builder /app/platforms/android/ /artifacts

CMD ["nginx", "-g", "daemon off;"]