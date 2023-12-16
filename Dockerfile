# Stage 1: Build Stage
FROM maven:3.8.4-openjdk-11 AS builder

WORKDIR /app

COPY pom.xml .
#RUN mvn dependency:go-offline

COPY src ./src
RUN mvn package 

# Stage 2: Production Stage
FROM tomcat:9.0-jdk11-openjdk-slim

COPY --from=builder /app/target/addressbook.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
