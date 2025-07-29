# syntax=docker/dockerfile:1

########## Build ##########
FROM ubuntu:24.04 AS build


RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential cmake git curl ca-certificates pkg-config curl zip unzip tar \
 && rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/microsoft/vcpkg.git /vcpkg \
 && /vcpkg/bootstrap-vcpkg.sh


WORKDIR /app
COPY CMakeLists.txt CMakePresets.json vcpkg.json ./
COPY src ./src


RUN cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_TOOLCHAIN_FILE=/vcpkg/scripts/buildsystems/vcpkg.cmake \
    -DVCPKG_FEATURE_FLAGS=manifests \
&& cmake --build build --config Release



########## Run ##########
FROM ubuntu:24.04 AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends libstdc++6 \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=build /app/build/image-thumbnail /app/image-thumbnail

EXPOSE 8080
ENTRYPOINT ["/app/image-thumbnail"]
