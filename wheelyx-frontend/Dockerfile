# =====================================================================
# Wheelyx Frontend - Production Multi-Stage Dockerfile for Railway
# Base: Maven + Apache Tomcat 10.1 (Jakarta Servlet 6.0 / JSP 3.1)
# =====================================================================

# Stage 1: Build the frontend package and inject .env if present
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src
COPY build-config.js .
COPY .env* ./

# If node is available or during build, run config sync, then package WAR
RUN mvn clean package -DskipTests

# Stage 2: Production runtime with Apache Tomcat 10.1
FROM tomcat:10.1-jdk17-temurin

# Clean default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy wheelyx-frontend as ROOT webapp
COPY --from=build /app/target/wheelyx-frontend.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

# Dynamically bind Tomcat to Railway's assigned $PORT if provided, then start Tomcat
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/g\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]
