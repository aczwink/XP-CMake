cmake_minimum_required(VERSION 3.6)
project(XP-CMake)

file(GLOB_RECURSE SRC_FILES "modules/*.cmake")

install(FILES ${SRC_FILES} DESTINATION share/XP-CMake/cmake/modules)
install(FILES XP-CMakeConfig.cmake DESTINATION share/XP-CMake/cmake)
