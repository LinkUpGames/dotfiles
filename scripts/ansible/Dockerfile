FROM fedora:latest

WORKDIR /app

RUN dnf update -y

RUN dnf install ansible -y

COPY . .
