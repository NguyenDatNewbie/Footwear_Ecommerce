# Stage 1: Build the application with Maven
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory in the build container
WORKDIR /app

# Copy the project files to the build container
COPY . .

# Build the application and skip the tests
RUN mvn clean package -DskipTests

# Stage 2: Run the application with OpenJDK
FROM openjdk:17-slim

# Set the working directory in the run container
WORKDIR /app

# Copy the WAR file from the build container to the run container
COPY --from=build /app/target/reidshop-0.0.1-SNAPSHOT.war /app/demo.war

# Expose the port the application will run on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/demo.war"]
