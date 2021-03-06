FROM prato/autopilot-base

# Alpine packages
RUN apk --no-cache \
    add \
#        curl \
        bash \
        ca-certificates

# The Consul binary
# ENV CONSUL_VERSION=0.6.4
# RUN curl -Lo /tmp/consul.zip https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip && \
#    cd /bin && \
#    unzip /tmp/consul.zip && \
#    chmod +x /bin/consul && \
#    rm /tmp/consul.zip

# The Consul web UI
RUN curl -Lo /tmp/webui.zip https://releases.hashicorp.com/consul/${CONSUL_VER}/consul_${CONSUL_VER}_web_ui.zip && \
    mkdir /ui && \
    cd /ui && \
    unzip /tmp/webui.zip && \
    rm /tmp/webui.zip

# Consul config
# COPY etc/consul.json etc/consul/
# Vault https://www.vaultproject.io/downloads.html
# sha256 283b4f591da8a4bf92067bf9ff5b70249f20705cc963bea96ecaf032911f27c2  vault_0.6.0_linux_amd64.zip
# curl https://releases.hashicorp.com/vault/0.6.0/vault_0.6.0_linux_amd64.zip

# copy bootstrap scripts
# COPY bin/* /usr/local/bin/

# Put Consul data on a separate volume to avoid filesystem performance issues
# with Docker image layers. Not necessary on Triton, but...
VOLUME ["/data"]

# We don't need to expose these ports in order for other containers on Triton
# to reach this container in the default networking environment, but if we
# leave this here then we get the ports as well-known environment variables
# for purposes of linking.
EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53 53/udp

#ENV GOMAXPROCS 2
ENV SHELL /bin/bash
