FROM docker.elastic.co/logstash/logstash:6.1.1

COPY ojdbc7-12.1.0.2.jar /usr/share/logstash/lib/ojdbc7.jar

COPY kt /tmp/kt

USER root
RUN yum install -y zip unzip \
    && chown -R logstash: /tmp/kt && chmod 775 /tmp/kt \
	&& rm -rf /var/cache/yum 

RUN zip -q -d /usr/share/logstash/logstash-core/lib/org/apache/logging/log4j/log4j-core/2.6.2/log4j-core-2.* org/apache/logging/log4j/core/lookup/JndiLookup.class

ENV LS_JAVA_OPTS '-server -Xss512k -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1 -XshowSettings:vm'

VOLUME /tmp

USER logstash