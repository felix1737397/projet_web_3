FROM dart:beta-sdk AS build

WORKDIR /app
COPY . .
WORKDIR /app/felixdashboard_api
RUN dart pub get

# Copy app source code and AOT compile it.
# Ensure packages are still up-to-date if anything has changed
# RUN dart pub get --offline
RUN dart compile exe bin/main.dart -o bin/main

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM debian:stretch
COPY --from=build /runtime/ /
COPY --from=build /app/felixdashboard_api/bin/main /app/bin/

# RUN apt-get update -y && apt-get install -y curl && apt-get install -y graphicsmagick


# Start server.
EXPOSE 8080
CMD ["/app/bin/main"]