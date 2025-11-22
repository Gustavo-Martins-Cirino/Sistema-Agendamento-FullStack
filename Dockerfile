FROM maven:3.8-openjdk-17 AS build
WORKDIR /workspace


COPY . .


RUN echo "=== ESTRUTURA COMPLETA ==="
RUN pwd
RUN ls -la
RUN echo "=== PROCURANDO POR POM.XML ==="
RUN find . -name "pom.xml" -type f


RUN mvn -B clean package -DskipTests

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app


COPY --from=build /workspace/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
