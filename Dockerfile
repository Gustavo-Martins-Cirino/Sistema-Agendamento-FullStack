FROM maven:3.8-openjdk-17 AS build
WORKDIR /workspace


COPY . .


RUN echo "=== ESTRUTURA DE PASTAS ==="
RUN pwd
RUN ls -la
RUN echo "=== CONTEÚDO DA PASTA SistemaDeAgendamento-FullStack ==="
RUN ls -la SistemaDeAgendamento-FullStack/


WORKDIR /workspace/SistemaDeAgendamento-FullStack

RUN mvn -B dependency:go-offline
RUN mvn -B clean package -DskipTests

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

COPY --from=build /workspace/SistemaDeAgendamento-FullStack/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
