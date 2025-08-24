FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

ADD scripts/ /opt/build/

RUN /opt/build/prerequisites.sh
RUN /opt/build/toolchain.sh
