# Multi-stage build for Wheelyx (Java 17 + Tomcat 10.1)
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY wheelyx-backend ./wheelyx-backend
COPY wheelyx-frontend ./wheelyx-frontend
RUN mvn clean package -DskipTests

FROM tomcat:10.1-jdk17-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/wheelyx.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
