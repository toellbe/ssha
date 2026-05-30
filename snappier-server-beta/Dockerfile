ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base system
ARG BUILD_ARCH=amd64

# Install base packages
RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        curl \
        jq \
        ffmpeg \
        unzip \
        tzdata \
        file \
        ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Build arguments
ARG SNAPPIER_SERVER_VERSION=1.5.6-2
ARG SNAPPIER_SERVER_DOWNLOAD_BASE_URL=https://snappierserver.app/betaFiles

ENV SNAPPIER_SERVER_VERSION=${SNAPPIER_SERVER_VERSION}

# Copy all rootfs files first
COPY rootfs/ /

# Download and install Snappier Server CLI based on architecture
RUN case "${BUILD_ARCH}" in \
    aarch64) \
        SNAPPIER_ARCH="arm64" \
        ;; \
    amd64) \
        SNAPPIER_ARCH="x64" \
        ;; \
    *) \
        echo "Unsupported architecture: ${BUILD_ARCH}" && exit 1 \
        ;; \
    esac \
    && echo "Downloading Snappier Server CLI for ${SNAPPIER_ARCH}..." \
    && curl -L -o snappier-server-cli.zip "${SNAPPIER_SERVER_DOWNLOAD_BASE_URL}/snappier-server-cli-v${SNAPPIER_SERVER_VERSION}-linux-${SNAPPIER_ARCH}.zip" \
    && unzip snappier-server-cli.zip \
    && ls -la snappier-server-cli-v${SNAPPIER_SERVER_VERSION}-linux-${SNAPPIER_ARCH} \
    && file snappier-server-cli-v${SNAPPIER_SERVER_VERSION}-linux-${SNAPPIER_ARCH} \
    && chmod +x snappier-server-cli-v${SNAPPIER_SERVER_VERSION}-linux-${SNAPPIER_ARCH} \
    && mv snappier-server-cli-v${SNAPPIER_SERVER_VERSION}-linux-${SNAPPIER_ARCH} /usr/local/bin/snappier-server \
    && rm snappier-server-cli.zip \
    && ls -la /usr/local/bin/snappier-server \
    && file /usr/local/bin/snappier-server

COPY rootfs/ /

WORKDIR /app

# Make run scripts executable
RUN chmod a+x /etc/services.d/*/run \
    && chmod a+x /etc/cont-init.d/*

# Labels
LABEL \
    io.hass.name="Snappier Server Beta" \
  io.hass.description="Self-hosted, lightweight recording and streaming service" \
  io.hass.arch="${BUILD_ARCH}" \
  io.hass.type="addon" \
  io.hass.version=${SNAPPIER_SERVER_VERSION} \
  maintainer="Home Assistant Community Add-ons" \
    org.opencontainers.image.title="Snappier Server Beta" \
  org.opencontainers.image.description="Self-hosted, lightweight recording and streaming service" \
  org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
  org.opencontainers.image.authors="Home Assistant Community Add-ons" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.url="https://www.snappierserver.app"
