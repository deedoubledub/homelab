FROM alpine:3

RUN apk add tftp-hpa

EXPOSE 69/udp

CMD [ "in.tftpd", "--foreground", "--secure", "/var/lib/tftpboot" ]
