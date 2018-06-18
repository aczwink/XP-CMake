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

function(CPU_GetArchitecture result)
	set(${result} "unknown" PARENT_SCOPE)
	
	if("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "AMD64") #windows
		set(${result} "x86_64" PARENT_SCOPE)
	endif()
endfunction()

function(CPU_IsArchitectureLittleEndian arch result)
	if(${arch} STREQUAL "x86_64")
		set(${result} TRUE PARENT_SCOPE)
	else()
		message(FATAL_ERROR "Unknown architecture: ${arch}")
	endif()
endfunction()

macro(CPU_SetCompileDefinitions)
	#architecture
	CPU_GetArchitecture(arch)
	if(${arch} STREQUAL "x86_64")
		add_definitions(-DXPC_ARCH_X86_64)
	else()
		message(FATAL_ERROR "Unknown architecture: ${CMAKE_SYSTEM_PROCESSOR}")
	endif()
	
	#endianness
	CPU_IsArchitectureLittleEndian(${arch} isLittleEndian)
	if(${isLittleEndian} STREQUAL TRUE)
		add_definitions(-DXPC_ENDIANNESS_LITTLE)
	else()
		add_definitions(-DXPC_ENDIANNESS_BIG)
	endif()
endmacro()











function(CPU_DetectHostArchitecture archResult)
	try_run(runResult compileResult "${CMAKE_BINARY_DIR}" "${_XPC_DIR}/scripts/CPU_DetectHostArchitecture.c" COMPILE_OUTPUT_VARIABLE compileOut RUN_OUTPUT_VARIABLE runOut)
	
	ASSERT( ${compileResult} TRUE "Compilation of CPU_DetectHostArchitecture failed")
	ASSERT( ${runResult} 0 "Running CPU_DetectHostArchitecture failed")
	
	set(${archResult} ${runOut} PARENT_SCOPE)
endfunction()