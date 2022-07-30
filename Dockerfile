FROM ghcr.io/siemens/kas/kas:latest
# https://github.com/orgs/siemens/packages/container/kas%2Fkas/29269788?tag=latest

WORKDIR /

ENV USER_NAME TCR
ENV PRODUCT Microfabricator

# https://embeddeduse.com/2019/02/11/using-docker-containers-for-yocto-builds/
ARG host_uid=1001
ARG host_gid=1001
RUN groupadd -g $host_gid $USER_NAME && \
    useradd -g $host_gid -m -s /build/poky-kirkstone/bitbake/bin/bitbake -u $host_uid $USER_NAME

COPY kirkstone.yaml ./

CMD ["kas", "build", "kirkstone.yaml"]