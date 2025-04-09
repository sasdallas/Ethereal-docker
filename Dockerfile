FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

ADD scripts/ /opt/build/

RUN /opt/build/prerequisites.sh
RUN /opt/build/toolchain.sh