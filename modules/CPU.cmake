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

function(CPU_DetectArchitecture archResult)
	try_run(runResult compileResult "${CMAKE_BINARY_DIR}" "${_XPC_DIR}/scripts/CPU_DetectArchitecture.c" COMPILE_OUTPUT_VARIABLE compileOut RUN_OUTPUT_VARIABLE runOut)
	
	ASSERT( ${compileResult} TRUE "Compilation of CPU_DetectArchitecture failed")
	ASSERT( ${runResult} 0 "Running CPU_DetectArchitecture failed")
	
	set(${archResult} ${runOut} PARENT_SCOPE)
endfunction()

function(CPU_IsLittleEndian result)
	CPU_DetectArchitecture(arch)
	if(${arch} STREQUAL "x86_64")
		set(${result} TRUE PARENT_SCOPE)
	else()
		message(FATAL_ERROR "Unknown architecture")
	endif()
endfunction()

macro(CPU_SetDefinitions)
	#architecture
	CPU_DetectArchitecture(arch)
	if(${arch} STREQUAL "x86_64")
		add_definitions(-DXPC_ARCH_X86_64)
	else()
		message(FATAL_ERROR "Unknown architecture")
	endif()
	
	#endianness
	CPU_IsLittleEndian(isLittleEndian)
	if(${isLittleEndian} STREQUAL TRUE)
		add_definitions(-DXPC_ENDIANNESS_LITTLE)
	else()
		add_definitions(-DXPC_ENDIANNESS_BIG)
	endif()
endmacro()
