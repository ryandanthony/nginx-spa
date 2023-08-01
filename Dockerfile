FROM nginx:stable-alpine
RUN apk add bash
ADD https://s3.amazonaws.com/se-com-docs/bins/json_env /usr/local/bin/
RUN chmod +x /usr/local/bin/json_env

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY nginx-site.conf /etc/nginx/conf.d/default.conf
COPY mime.types /etc/nginx/mime.types

ENV CONFIG_FILE_PATH /app

RUN mkdir /app

RUN echo "<code>Add your index.html to /app: COPY index.html /app/index.html</code>" > /app/index.html

# Copy our start script
COPY start-container.sh /usr/local/bin/start-container

ENTRYPOINT ["start-container"]

CMD ["nginx"]
