# Use official Java 17 image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy Maven wrapper and pom.xml for caching
COPY mvnw pom.xml ./
COPY .mvn .mvn

# Download dependencies (caches this layer)
RUN chmod +x mvnw && ./mvnw dependency:go-offline -B

# Copy the rest of the source code
COPY src ./src

# Build the application
RUN ./mvnw clean package -DskipTests

# Expose port (used by Spring Boot)
EXPOSE 8080

# Run the app
CMD ["java", "-jar", "target/demoSpring-0.0.1-SNAPSHOT.jar"]
