FROM ubuntu:22.04

ARG VERSION

ENV VERSION=${VERSION}

RUN apt update && \
    apt install -y --no-install-recommends \
    wget netbase unzip iproute2 vim net-tools jq curl gnupg2 software-properties-common ntp \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoremove -y && apt autoclean -y

RUN wget https://download.platon.network/platon/platon/ubuntu22.04/${VERSION}/platon -O /usr/bin/platon
RUN wget https://download.platon.network/platon/platon/ubuntu22.04/${VERSION}/platonkey -O /usr/bin/platonkey
RUN chmod +x /usr/bin/platon
RUN chmod +x /usr/bin/platonkey
RUN mkdir -pv /root/platon-node

WORKDIR /root/

# p2p port
EXPOSE 16789
# rpc port
EXPOSE 6789
# metrics port
EXPOSE 6060

VOLUME /root/platon-node

WORKDIR /root

COPY entrypoint.sh /root
RUN chmod +x /root/entrypoint.sh

ENV LANG C.UTF-8

ENTRYPOINT ["bash", "-c", "/root/entrypoint.sh"]
