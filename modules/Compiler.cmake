#
# Copyright (c) 2018 Amir Czwink (amir130@hotmail.de)
#
# This file is part of XP-CMake.
#
# XP-CMake is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# XP-CMake is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with XP-CMake.  If not, see <http://www.gnu.org/licenses/>.
#

# Instructs the compiler to generate optimized code for the host CPU (if compiler supports this).
macro(Compiler_OptForHost)
	#TODO: currently only CXX
	if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU") #gcc
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native")
	elseif(("${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang") OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native")
	endif()
endmacro()

macro(Compiler_SetCompileDefinitions)
	#TODO: currently evaluating only CXX compiler
	if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU") #gcc
		add_definitions(-DXPC_COMPILER_GCC)
	elseif(MSVC)
		add_definitions(-DXPC_COMPILER_MSVC)
	elseif(("${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang") OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
		add_definitions(-DXPC_COMPILER_CLANG)
	else()
		message(FATAL_ERROR "unknown compiler: ${CMAKE_CXX_COMPILER_ID}")
	endif()
endmacro()
