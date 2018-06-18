cmake_minimum_required(VERSION 3.6)
project(XP-CMake)

file(GLOB_RECURSE SRC_FILES "modules/*.cmake")
file(GLOB_RECURSE SCRIPT_FILES "scripts/*.c")

install(FILES ${SRC_FILES} DESTINATION share/XP-CMake/cmake/modules)
install(FILES ${SCRIPT_FILES} DESTINATION share/XP-CMake/cmake/scripts)
install(FILES XP-CMakeConfig.cmake DESTINATION share/XP-CMake/cmake)
