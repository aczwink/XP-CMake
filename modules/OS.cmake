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

function(dec2hex dec result)
	if (${dec} LESS 10)
		set(${result} "0${dec}" PARENT_SCOPE)
	elseif(${dec} EQUAL 10)
		set(${result} "0A" PARENT_SCOPE)
	elseif(${dec} EQUAL 11)
		set(${result} "0B" PARENT_SCOPE)
	elseif(${dec} EQUAL 12)
		set(${result} "0C" PARENT_SCOPE)
	elseif(${dec} EQUAL 13)
		set(${result} "0D" PARENT_SCOPE)
	elseif(${dec} EQUAL 14)
		set(${result} "0E" PARENT_SCOPE)
	elseif(${dec} EQUAL 15)
		set(${result} "0F" PARENT_SCOPE)
	else()
		message(fatal_error "Invalid input.")
	endif()
endfunction()

macro(OS_SetCompileDefinitions)
	if(WIN32)
		add_definitions(-DXPC_OS_WINDOWS)
		
		set(version ${CMAKE_SYSTEM_VERSION})
        string(REGEX REPLACE "^([0-9]+)[.]([0-9]+).*" "\\1" versionMajor ${version})
		string(REGEX REPLACE "^([0-9]+)[.]([0-9]+).*" "\\2" versionMinor ${version})
		
		dec2hex(${versionMajor} versionMajor)
		dec2hex(${versionMinor} versionMinor)
		
		set(version "0x${versionMajor}${versionMinor}")
		add_definitions(-D_WIN32_WINNT=${version})
	elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
		add_definitions(-DXPC_OS_LINUX)
	elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
		add_definitions(-DXPC_OS_DARWIN)
	else()
		message(FATAL_ERROR "unknown operating system: ${CMAKE_SYSTEM_NAME}")
	endif()
endmacro()
