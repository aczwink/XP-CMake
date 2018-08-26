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

macro(XPC_AutoBuildType)
	#debug or release
	if(CMAKE_BUILD_TYPE MATCHES Debug)
		add_definitions(-D_DEBUG)

		set(CMAKE_DEBUG_POSTFIX "_d")
	elseif(CMAKE_BUILD_TYPE MATCHES Release)
		#ok
	else()
		message(FATAL_ERROR "Unknown build type. Must be either 'Debug' or 'Release'")
	endif()
endmacro()


macro(XPC_OptForHost)
	#reset to host in case this was changed
	set(CMAKE_SYSTEM_PROCESSOR "${CMAKE_HOST_SYSTEM_PROCESSOR}")
	set(CMAKE_SYSTEM_NAME "${CMAKE_HOST_SYSTEM_NAME}")
	set(CMAKE_SYSTEM_VERSION "${CMAKE_HOST_SYSTEM_VERSION}")

	Compiler_OptForHost()
	CPU_OptForHost()
endmacro()


macro(XPC_SetCompileDefinitions)
	Compiler_SetCompileDefinitions()
	CPU_SetCompileDefinitions()
	OS_SetCompileDefinitions()
endmacro()
