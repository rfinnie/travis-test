FROM debian:sid

COPY . /build/
RUN echo 'deb http://deb.debian.org/debian/ sid non-free contrib' >> /etc/apt/sources.list
RUN apt -y update
RUN env DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends build-essential debhelper git-buildpackage po4a gettext man-db
RUN cd /build/live-build && gbp buildpackage --git-ignore-branch
RUN env DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends /build/*.deb debian-archive-keyring librsvg2-bin fonts-ubuntu
RUN /build/build.sh
