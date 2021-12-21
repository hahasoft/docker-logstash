FROM docker.elastic.co/logstash/logstash:7.6.2

COPY ojdbc7-12.1.0.2.jar /usr/share/logstash/lib/ojdbc7.jar
COPY kafka_header.rb /usr/share/logstash/vendor/bundle/jruby/2.5.0/gems/logstash-integration-kafka-10.0.1-java/lib/logstash/inputs/kafka.rb
COPY kt /tmp/kt

USER root
RUN yum install -y zip unzip \
    && chown -R logstash: /tmp/kt && chmod 775 /tmp/kt \
	&& rm -rf /var/cache/yum 
RUN zip -q -d /usr/share/logstash/logstash-core/lib/jars/log4j-core-2.* org/apache/logging/log4j/core/lookup/JndiLookup.class

ENV XPACK_MONITORING_ENABLED=false
VOLUME /tmp

USER logstash