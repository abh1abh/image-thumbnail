cmake_minimum_required(VERSION 3.25)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)   # error if the compiler can’t do C++20
set(CMAKE_CXX_EXTENSIONS OFF)         # use -std=c++20, not -std=gnu++20


project(image-thumbnail LANGUAGES CXX)

add_executable(image-thumbnail main.cpp)
