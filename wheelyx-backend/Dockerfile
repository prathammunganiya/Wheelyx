# =====================================================================
# Wheelyx Backend - Production Multi-Stage Dockerfile for Railway
# Base: Eclipse Temurin Java 17 + Apache Tomcat 10.1 (Jakarta Servlet 6.0)
# =====================================================================

# Stage 1: Build the backend application
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# Cache Maven dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B || true

# Copy source code and package WAR
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Production runtime with Apache Tomcat 10.1
FROM tomcat:10.1-jdk17-temurin

# Remove default Tomcat sample applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy wheelyx-backend as ROOT application (maps endpoints to /)
COPY --from=build /app/target/wheelyx-backend.war /usr/local/tomcat/webapps/ROOT.war

# Expose container port (default 8080)
EXPOSE 8080

# Dynamically bind Tomcat to Railway's assigned $PORT if provided, then start Tomcat
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/g\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]
