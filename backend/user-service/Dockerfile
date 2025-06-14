FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package

FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

#EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]

# docker build -t user-service:1.0.0 .
# docker run -p 8081:8081 --name user-service user-service
# kubectl apply -f deployment.yaml
# kubectl apply -f service.yaml
# kubectl get deployment
# kubectl get pods
# kubectl logs -f <pod-name>
# kubectl logs -f user-service-794b48d4cc-66qn2 
# kubectl describe pod user-service-794b48d4cc-66qn2

# swagger
# http://localhost:30036/swagger-ui/index.html