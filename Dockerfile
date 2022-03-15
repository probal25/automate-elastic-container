FROM docker.elastic.co/elasticsearch/elasticsearch:7.10.0 AS builder
USER root
# environmental settings
ENV ES_JAVA_OPTS '-Xms512m -Xmx512m'
ENV cluster.name '__heisenbug__'
ENV discovery.type 'single-node'
ENV bootstrap.memory_lock 'true'
RUN echo 'vm.max_map_count=262144' >> /etc/sysctl.conf

ADD preload.sh index.json bulk_data.json /

RUN /usr/local/bin/docker-entrypoint.sh elasticsearch -d -E path.data=/tmp/data \
    && while [[ "$(curl -s -o /dev/null -w '%{http_code}' localhost:9200)" != "200" ]]; do sleep 1; done \
    && /preload.sh

FROM docker.elastic.co/elasticsearch/elasticsearch:7.10.0
COPY --from=builder /tmp/data/ /usr/share/elasticsearch/data/
