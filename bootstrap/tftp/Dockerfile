FROM alpine:3
RUN apk --no-cache add \
  curl \
  tftp-hpa
COPY entrypoint.sh /entrypoint.sh
EXPOSE 69/udp
ENTRYPOINT ["/entrypoint.sh"]
