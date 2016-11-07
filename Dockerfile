FROM ubuntu:latest
MAINTAINER Dusty Wilson <dusty@linux.com>
# Originated from Jessie Frazelle <jess@linux.com>
# at https://github.com/jessfraz/dockerfiles/tree/master/chrome/stable

# Install prereqs
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	apt-transport-https \
	ca-certificates \
	curl \
	fonts-symbola \
	gnupg \
	hicolor-icon-theme \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpulse0 \
	libv4l-0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Chrome
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends google-chrome-stable && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#COPY local.conf /etc/fonts/local.conf

# setup user
RUN useradd -d /user -m user
WORKDIR /user
USER user

ENTRYPOINT [ "google-chrome" ]
CMD [ "--user-data-dir=/data" ]
