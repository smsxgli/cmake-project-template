cmake_minimum_required(VERSION 3.18...3.25)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(
    template
    VERSION 0.1.0
    LANGUAGES C
    DESCRIPTION "template project for c with cmake"
)

include(${CMAKE_CURRENT_LIST_DIR}/cmake/common_opt.cmake)

set(
    SOURCE_LIST
    ${CMAKE_CURRENT_LIST_DIR}/src/main.c
)
set(
    INCDIR_LIST
    ${CMAKE_CURRENT_LIST_DIR}/include
)

add_executable(${PROJECT_NAME})

target_include_directories(${PROJECT_NAME} PRIVATE ${INCDIR_LIST})
target_sources(${PROJECT_NAME} PRIVATE ${SOURCE_LIST})
target_link_libraries(${PROJECT_NAME} PRIVATE common_opt)
set_target_properties(
    ${PROJECT_NAME}
    PROPERTIES
    C_STANDARD 11
    C_STANDARD_REQUIRED ON
    C_EXTENSIONS ON
    INTERPROCEDURAL_OPTIMIZATION ON
)
