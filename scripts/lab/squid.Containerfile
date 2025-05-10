# FROM quay.io/fedora/fedora-coreos:stable
# RUN dnf install -y squid

FROM docker.io/ubuntu/squid:latest

RUN echo smallzen-squid > /etc/hostname

COPY dnf.conf /etc/squid/conf.d/dnf.conf
