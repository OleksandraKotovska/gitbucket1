FROM eclipse-temurin:17

COPY target/executable/gitbucket.war /opt/gitbucket.war

RUN ln -s /gitbucket /root/.gitbucket

VOLUME /gitbucket

EXPOSE 8080 29418

CMD ["sh", "-c", "java -jar /opt/gitbucket.war"]