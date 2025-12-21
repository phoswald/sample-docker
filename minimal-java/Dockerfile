FROM code.phoswald.ch/philip/builder:latest AS build

WORKDIR /build/

ADD Minimal.java .

RUN javac Minimal.java
    
RUN ls -la /build
 
###############################################################################

FROM code.phoswald.ch/philip/jre-25:latest AS prepare

# Copy everything we need from / to /prepare
RUN mkdir -p /prepare/usr/local/jre && \
    mkdir -p /prepare/lib/ && \
    cp -r /usr/lib/jvm/java-25-openjdk/.     /prepare/usr/local/jre/ && \
    rm -rf                                   /prepare/usr/local/jre/legal && \
    cp    /lib/ld-musl-x86_64.so.1           /prepare/lib/ && \ 
    cp    /lib/libc.musl-x86_64.so.1         /prepare/lib/ && \
    cp    /usr/lib/libz.so.1                 /prepare/lib/

RUN find /prepare

# OpenSUSE:
# 
# RUN zypper --non-interactive install -n glibc-locale
# 
# RUN set -x \
#     mkdir -p /prepare/lib64 \
#     mkdir -p /prepare/usr/lib/locale \
# #   mkdir -p /prepare/usr/share/locale \
#     mkdir -p /prepare/usr/local \
#     mkdir -p /prepare/etc \
#     cp    /lib64/ld-linux-x86-64.so.2 /prepare/lib64/ && \
#     cp    /lib64/libc.so.6            /prepare/lib64/ && \
#     cp    /lib64/libpthread.so.0      /prepare/lib64/ && \
#     cp    /lib64/libz.so.1            /prepare/lib64/ && \
#     cp    /lib64/libdl.so.2           /prepare/lib64/ && \
#     cp    /lib64/libm.so.6            /prepare/lib64/ && \
# #   cp    /lib64/librt.so.1           /prepare/lib64/ && \
#     cp -r /usr/lib/locale/de_CH.utf8  /prepare/usr/lib/locale/ && \
# #   cp -r /usr/share/locale/de        /prepare/usr/share/locale/ && \
# #   cp -r /usr/share/locale/de_CH     /prepare/usr/share/locale/ && \
#     cp -r /usr/local/jdk*             /prepare/usr/local/jre && \
#     echo "Europe/Zurich"           >  /prepare/etc/timezone
 
###############################################################################

FROM scratch

# Copy root filesystem from previous image
COPY --from=prepare /prepare /

ENV TZ=Europe/Zurich
ENV LANG=de_CH.UTF-8
ENV LC_ALL=de_CH.UTF-8
ENV PATH=/usr/local/jre/bin
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=50 -Dapp.prop1=FromDockerfile"
ENV APP_ENV1=FromDockerfile

# Define user/group (optional, does NOT require /etc/passwd)
USER 2001:2001

# Copy application from previous image and define command
WORKDIR /usr/local/application/
COPY --from=build /build/Minimal.class .
ENTRYPOINT ["java", "-Dapp.prop2=FromDockerfile", "Minimal", "ArgFromDockerfile"]
