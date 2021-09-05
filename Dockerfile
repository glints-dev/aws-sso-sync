FROM alpine:3.14.2 AS downloader

ARG SSOSYNC_VERSION=1.0.0-rc.9
ENV SSOSYNC_VERSION=${SSOSYNC_VERSION}

RUN apk add --no-cache ca-certificates curl && \
    curl -Lo ssosync.tar.gz https://github.com/awslabs/ssosync/releases/download/v${SSOSYNC_VERSION}/ssosync_Linux_x86_64.tar.gz && \
    tar -xvf ssosync.tar.gz && \
    rm ssosync.tar.gz

FROM scratch

COPY --from=downloader /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=downloader /ssosync /ssosync
ENTRYPOINT ["/ssosync"]

