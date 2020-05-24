FROM debian:sid

COPY . /build/
RUN apt-get update
RUN env DEBIAN_FRONTEND=noninteractive apt -y install debhelper git-buildpackage po4a gettext man-db
RUN cd /build/live-build && gbp buildpackage --git-ignore-branch
RUN env DEBIAN_FRONTEND=noninteractive apt -y install ./*.deb debian-archive-keyring librsvg2-bin fonts-ubuntu
RUN ./build.sh
