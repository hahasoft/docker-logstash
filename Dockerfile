FROM docker.elastic.co/logstash/logstash:6.1.1

COPY ojdbc7-12.1.0.2.jar /usr/share/logstash/lib/ojdbc7.jar

COPY kt /tmp/kt

USER root

RUN chown -R logstash: /tmp/kt && chmod 775 /tmp/kt

ENV LS_JAVA_OPTS '-server -Xss512k -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1 -XshowSettings:vm'

VOLUME /tmp

USER logstash