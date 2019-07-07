FROM alpine:latest
RUN apk update;
RUN apk add nginx curl nano bash
RUN adduser -D -g 'www' www && \
    mkdir /www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www
RUN mkdir -p /run/nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /www/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
