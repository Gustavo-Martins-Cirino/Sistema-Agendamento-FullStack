FROM maven:3.8-openjdk-17 AS build
WORKDIR /workspace


COPY . .


WORKDIR /workspace/SistemaDeAgendamento-FullStack

RUN mvn -B dependency:go-offline
RUN mvn -B clean package -DskipTests

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

COPY --from=build /workspace/SistemaDeAgendamento-FullStack/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
