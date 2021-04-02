### STAGE 1: Build ###
FROM node:12.7-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build 

### STAGE 2: Run ###
FROM nginx:1.17.9
COPY site.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
RUN chmod -R 777 /var/log/nginx /var/cache/nginx/ && chmod 644 /etc/nginx/*
#RUN --from=build cp -r /usr/src/app/dist /usr/share/nginx/html
EXPOSE 80

