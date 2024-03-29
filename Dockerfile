FROM ubuntu:latest AS build
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk && \
    apt-get install -y maven
WORKDIR /app
COPY . .
RUN mvn clean package

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/WebMvcApp05Application.jar /app/WebMvcApp05Application.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "WebMvcApp05Application.jar"]
