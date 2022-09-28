FROM	alpine:3.14

# Install nginx + openssl and configure SSL
RUN		apk update \
		&& apk add --no-cache --update nginx openssl \
		&& mkdir -p /etc/nginx/ssl \
		&& openssl req -x509 -nodes \
		-out /etc/nginx/ssl/dtanigaw.42.fr.crt \	
		-keyout /etc/nginx/ssl/dtanigaw.42.fr.key \
		-subj "/C=FR/CN=dtanigaw.42.fr" \
		&& mkdir -p /var/run/nginx

COPY	./conf/nginx.conf /etc/nginx/http.d/default.conf

EXPOSE	443

# Run nginx on the foreground to prevent the container from halting
CMD	[ "nginx", "-g", "daemon off;" ]