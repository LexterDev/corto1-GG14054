# Usar una imagen base de Maven para compilar el proyecto
FROM maven:3.8.1-openjdk-17-slim as build

# Copiar el código fuente del proyecto
WORKDIR /app
COPY . .

# Ejecutar Maven para limpiar y compilar sin pruebas
RUN mvn clean package -DskipTests

# Ahora usar una imagen de Java para ejecutar la app
FROM openjdk:17-jdk-slim

# Copiar el .jar generado desde la imagen de Maven
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Exponer el puerto de la app
EXPOSE 8080

# Ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]
