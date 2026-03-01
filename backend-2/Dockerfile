FROM gradle:8.5-jdk17 AS build
WORKDIR /app

# Copy everything (or at least build files + src)
COPY . .

# Build jar (Spring Boot)
RUN gradle clean bootJar --no-daemon -x test

# ---- Run stage ----
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

COPY --from=build /app/build/libs/*.jar /app/app.jar

EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]