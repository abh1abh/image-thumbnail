cmake_minimum_required(VERSION 3.25)

# Toolchain must be known BEFORE project(); let presets pass it instead, or keep this:
if(NOT DEFINED CMAKE_TOOLCHAIN_FILE AND DEFINED ENV{VCPKG_ROOT})
  set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE FILEPATH "")
endif()

# suppress the old FindBoost module warning
cmake_policy(SET CMP0167 NEW)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

project(image-thumbnail LANGUAGES CXX)

find_package(Boost 1.80 REQUIRED COMPONENTS beast asio system)

add_executable(image-thumbnail src/main.cpp)
target_link_libraries(image-thumbnail PRIVATE Boost::beast Boost::asio Boost::system)

if (WIN32)
  target_compile_definitions(image-thumbnail PRIVATE _WIN32_WINNT=0x0A00 WIN32_LEAN_AND_MEAN)
endif()