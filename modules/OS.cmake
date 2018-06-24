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
	elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
		add_definitions(-DXPC_OS_LINUX)
	else()
		message(FATAL_ERROR "unknown operating system: ${CMAKE_SYSTEM_NAME}")
	endif()
endmacro()
