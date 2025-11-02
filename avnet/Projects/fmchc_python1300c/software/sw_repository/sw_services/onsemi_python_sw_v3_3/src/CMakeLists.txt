# Copyright (C) 2023 Advanced Micro Devices, Inc.  All rights reserved.
# SPDX-License-Identifier: MIT
cmake_minimum_required(VERSION 3.14.7)

project(onsemi_python_sw)

find_package(common)
collector_create (PROJECT_LIB_HEADERS "${CMAKE_CURRENT_SOURCE_DIR}")
collector_create (PROJECT_LIB_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}")
include_directories(${CMAKE_BINARY_DIR}/include)
#add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/vdma)
collect (PROJECT_LIB_SOURCES onsemi_python_sw.c)
collect (PROJECT_LIB_HEADERS include/onsemi_python_sw.h)
collector_list (_sources PROJECT_LIB_SOURCES)
collector_list (_headers PROJECT_LIB_HEADERS)
file(COPY ${_headers} DESTINATION ${CMAKE_BINARY_DIR}/include)
add_library(onsemi_python_sw STATIC ${_sources})
set_target_properties(onsemi_python_sw PROPERTIES LINKER_LANGUAGE C)
install(TARGETS onsemi_python_sw LIBRARY DESTINATION ${CMAKE_LIBRARY_PATH} ARCHIVE DESTINATION ${CMAKE_LIBRARY_PATH})
install(DIRECTORY ${CMAKE_BINARY_DIR}/include DESTINATION ${CMAKE_INCLUDE_PATH}/..)
