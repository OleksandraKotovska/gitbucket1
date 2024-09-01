FROM eclipse-temurin:17

COPY target/scala-2.13/gitbucket_2.13-4.41.0.war /opt/gitbucket.war

RUN ln -s /gitbucket /root/.gitbucket

VOLUME /gitbucket

EXPOSE 8080 29418

CMD ["sh", "-c", "java -jar /opt/gitbucket.war"]