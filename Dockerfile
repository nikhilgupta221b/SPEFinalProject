
# Use the official OpenJDK 11 image as base
FROM openjdk:17

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/blogs-0.0.1-SNAPSHOT.jar /app/

# Command to run the application when the container starts
CMD ["java", "-jar", "blogs-0.0.1-SNAPSHOT.jar"]

EXPOSE 9292
