FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests
FROM openjdk:17-slim
COPY --from=build  /target/ReidShop-3.0.1.war demo.war
EXPOSE 8083
ENTRYPOINT ["java","-war","demo.war"]

