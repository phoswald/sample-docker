FROM alpine:3.23

# Generell
RUN apk add --no-cache curl make tar

# Für Action Runner: z.B. actions/checkout@v4, actions/cache@v4
RUN apk add --no-cache nodejs

# Für Dockerfiles
RUN apk add --no-cache docker-cli

# Für Java
RUN mkdir -p /usr/local/apache-maven && \
    apk add --no-cache openjdk25-jdk && \
    curl "https://downloads.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.tar.gz" -s | \
    tar -xz -C /usr/local/apache-maven --strip-components=1 && \
    ln -s /usr/local/apache-maven/bin/mvn /usr/local/bin/
