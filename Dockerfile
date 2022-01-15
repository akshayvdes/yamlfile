FROM maven:3.6.1-jdk-8 as maven_build
WORKDIR /app
COPY . .
RUN mvn clean package

FROM tomcat:8.5.43-jdk8
COPY --from=maven_build /app/target/* /usr/local/tomcat/webapps/
