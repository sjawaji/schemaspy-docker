FROM anapsix/alpine-java:8
ENV LC_ALL C
WORKDIR /app/

ENV SCHEMA_SPY_VERSION=6.1.0
ENV MYSQL_VERSION=6.0.6
ENV SQL_LITE_VERSION=3.30.1

RUN apk --no-cache add \
    	busybox-extras \
    	graphviz ttf-ubuntu-font-family java-postgresql-jdbc && \
    mkdir lib && \
    wget -O lib/schemaspy.jar \
    	https://github.com/schemaspy/schemaspy/releases/download/v${SCHEMA_SPY_VERSION}/schemaspy-${SCHEMA_SPY_VERSION}.jar && \
    wget -O lib/mysql-connector-java.jar \
    	https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/${MYSQL_VERSION}/mysql-connector-java-${MYSQL_VERSION}.jar && \
    wget -O lib/sqlite-jdbc.jar \
    	https://repo.maven.apache.org/maven2/org/xerial/sqlite-jdbc/${SQL_LITE_VERSION}/sqlite-jdbc-${SQL_LITE_VERSION}.jar

RUN adduser -u 1000 -DG root default && \
    mkdir output && \
    chmod -R g+rwX .

USER default

COPY --chown=default:root start.sh conf ./

CMD [ "sh", "start.sh" ]
