FROM alpine:latest

ARG KUBECTL_VERSION
ARG TARGETARCH=arm64

LABEL maintainer="Kreato <hi@krea.to>"
LABEL description="Alpine-based Docker image that contains kubectl." 
LABEL version=${KUBECTL_VERSION}

RUN apk add --no-cache curl openssl && \
    curl -L -o kubectl "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl" && \
    curl -L -o kubectl.sha256 "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl.sha256" && \
    echo "$(cat kubectl.sha256) kubectl" | sha256sum -c && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl && \
    rm kubectl.sha256 && \
    apk del curl openssl

ENTRYPOINT ["kubectl"]

CMD ["version", "--client"]

