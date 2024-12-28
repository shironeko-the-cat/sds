# Use an official Flutter SDK image as the base image
FROM ghcr.io/cirruslabs/flutter:3.27.1

# Set the working directory in the container
WORKDIR /app

# Copy the Flutter project into the container
COPY . .

RUN flutter config --enable-web

# Get Flutter dependencies
RUN flutter pub get

# Build the Flutter app
RUN flutter build web

# Expose the web server port
EXPOSE 8081

# Run the Flutter web app
CMD ["flutter", "run", "-d", "web-server", "--web-port=8081","--web-hostname=0.0.0.0"]
