FROM maven:3.8-openjdk-17 AS build
WORKDIR /workspace


COPY . .


RUN POM_FILE=$(find . -name "pom.xml" -type f | head -1) && \
    if [ -n "$POM_FILE" ]; then \
      PROJECT_DIR=$(dirname "$POM_FILE"); \
      echo "Encontrado POM em: $PROJECT_DIR"; \
      cd "$PROJECT_DIR"; \
      mvn -B clean package -DskipTests; \
    else \
      echo "ERRO: Nenhum pom.xml encontrado!"; \
      exit 1; \
    fi

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app


COPY --from=build /workspace/*/target/*.jar app.jar 2>/dev/null || \
COPY --from=build /workspace/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
