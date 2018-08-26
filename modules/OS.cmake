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

macro(OS_SetCompileDefinitions)
	if(WIN32)
		add_definitions(-DXPC_OS_WINDOWS)
		
		#this method works only for all the defined versions until Windows 10 (i.e. 0x0A00)
		#for later versions this will probably fail
		set(version ${CMAKE_SYSTEM_VERSION})
        string(REGEX REPLACE "^([0-9a-fA-F])[.]([0-9a-fA-F]).*" "0\\10\\2" version ${version})
		set(version "0x${version}")
		add_definitions(-D_WIN32_WINNT=${version})
	elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
		add_definitions(-DXPC_OS_LINUX)
	elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
		add_definitions(-DXPC_OS_DARWIN)
	else()
		message(FATAL_ERROR "unknown operating system: ${CMAKE_SYSTEM_NAME}")
	endif()
endmacro()
