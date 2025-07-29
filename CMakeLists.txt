cmake_minimum_required(VERSION 3.25)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

project(image-thumbnail LANGUAGES CXX)

find_package(Boost 1.80 REQUIRED beast system)

add_executable(image-thumbnail src/main.cpp)

target_link_libraries(image-thumbnail PRIVATE Boost::beast Boost::system)

if (WIN32)
  target_compile_definitions(image-thumbnail PRIVATE _WIN32_WINNT=0x0A00 WIN32_LEAN_AND_MEAN)
endif()