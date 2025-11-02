FROM alpine:3.18
LABEL maintainer="Adnan Ayyub"
RUN apk add --no-cache bash
COPY . /app
WORKDIR /app
CMD ["/bin/sh", "-c", "echo hi && sleep 1"]
