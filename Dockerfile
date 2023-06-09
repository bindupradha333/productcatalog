FROM openjdk:11-jre-slim
RUN mkdir /app
WORKDIR /app



EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]