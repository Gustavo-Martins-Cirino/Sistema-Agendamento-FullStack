FROM maven:3.8-openjdk-17 AS build
WORKDIR /workspace
COPY . .
RUN mvn -B clean package -DskipTests

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /workspace/target/*.jar app.jar


RUN echo "=== VARIÁVEIS DE AMBIENTE ==="
RUN env | grep MYSQL
RUN env | grep SPRING

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
