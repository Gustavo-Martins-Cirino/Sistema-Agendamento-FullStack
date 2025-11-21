FROM maven:3.8-openjdk-17 AS build
WORKDIR /workspace


COPY pom.xml .


RUN mvn -B dependency:resolve dependency:resolve-plugins


COPY src ./src


RUN mvn -B clean package -DskipTests


FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

COPY --from=build /workspace/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
