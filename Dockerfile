FROM python:3.8-slim

RUN addgroup user && adduser -h /home/user -D user -G user -s /bin/sh

COPY . /usr/src/app/tr-projects-rest

# Set config to prod
ENV CLUSTER_ENV=prod

WORKDIR /usr/src/app/tr-projects-rest

RUN apt-get update \
	&&  apt-get add python3 libpq uwsgi-python3 \
	py3-pip \
	bash openssh curl ca-certificates openssl less htop \
	g++ make wget rsync \
	build-base libpng-dev freetype-dev libexecinfo-dev openblas-dev libgomp lapack-dev \
    libgcc libquadmath musl libxml2-dev libxslt-dev \
	libgfortran \
	lapack-dev \
    # && apt-get install -y gcc libc-dev libxslt-dev libxml2 \
    && pip install --upgrade pip \
    && pip install -r requirements.txt

EXPOSE 8080
CMD ["/usr/local/bin/uwsgi", "--ini", "server.ini"]
