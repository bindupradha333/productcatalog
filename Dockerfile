FROM openjdk:11-jre-slim
RUN mkdir /app
WORKDIR /app



EXPOSE 7070
ENTRYPOINT ["java", "-jar", "app.jar"]
