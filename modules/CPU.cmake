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

macro(CPU_EnableFeature feature)
	get_property(enabledFeatures GLOBAL PROPERTY XPC_CPU_ENABLED_FEATURES)
	LIST(APPEND enabledFeatures ${feature})
	set_property(GLOBAL PROPERTY XPC_CPU_ENABLED_FEATURES "${enabledFeatures}")
endmacro()

function(CPU_GetArchitecture result)
	set(${result} "unknown" PARENT_SCOPE)

	if("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
		set(${result} "x86_64" PARENT_SCOPE)
	elseif("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "AMD64") #windows
		set(${result} "x86_64" PARENT_SCOPE)
	endif()
endfunction()

function(CPU_GetArchitectureFeatures result)
	CPU_GetArchitecture(arch)
	if(${arch} STREQUAL "x86_64")
		set(${result} "sse2" "sse3" "sse4.1" PARENT_SCOPE)
	else()
		message(FATAL_ERROR "Unknown architecture: ${CMAKE_SYSTEM_PROCESSOR}")
	endif()
endfunction()

function(CPU_GetHostFeatures result)
	if(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
		execute_process(COMMAND sysctl -n machdep.cpu.features WORKING_DIRECTORY "/usr/sbin" OUTPUT_STRIP_TRAILING_WHITESPACE OUTPUT_VARIABLE cpuinfo)
		string(TOLOWER "${cpuinfo}" cpuinfolower)
		separate_arguments(cpuinfolower)
		set(${result} ${cpuinfolower} PARENT_SCOPE)
	elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
		file(READ "/proc/cpuinfo" cpuinfo)
		string(REGEX REPLACE ".*[\r\n][ \t]*flags[ \t]*:[ \t]*([a-zA-Z0-9_ ]+).*" "\\1" cpuinfoflags ${cpuinfo})
		string(TOLOWER "${cpuinfoflags}" cpuinfolower)
		separate_arguments(cpuinfolower)
		
		#sse4_1 is special
		LIST_REPLACE(cpuinfolower "sse4_1" "sse4.1")
		
		set(${result} ${cpuinfolower} PARENT_SCOPE)
	elseif(WIN32)
		try_run(runResult compileResult "${CMAKE_BINARY_DIR}" "${_XPC_DIR}/scripts/CPU_DetectHostFeatures_x86_windows.c" COMPILE_OUTPUT_VARIABLE compileOut RUN_OUTPUT_VARIABLE runOut)
		
		ASSERT( ${compileResult} TRUE "Compilation of CPU_DetectHostFeatures_x86_windows failed: ${compileOut}")
		ASSERT( ${runResult} 0 "Running CPU_DetectHostFeatures_x86_windows failed")
		
		separate_arguments(runOut)		
		set(${result} ${runOut} PARENT_SCOPE)
	else()
		message(FATAL_ERROR "unknown operating system: ${CMAKE_SYSTEM_NAME}")
	endif()
endfunction()

function(CPU_IsArchitectureLittleEndian arch result)
	if(${arch} STREQUAL "x86_64")
		set(${result} TRUE PARENT_SCOPE)
	else()
		message(FATAL_ERROR "Unknown architecture: ${arch}")
	endif()
endfunction()

function(CPU_IsFeatureEnabled result feature)
	get_property(enabledFeatures GLOBAL PROPERTY XPC_CPU_ENABLED_FEATURES)
	IF(${feature} IN_LIST enabledFeatures)
		set(${result} TRUE PARENT_SCOPE)
	else()
		set(${result} FALSE PARENT_SCOPE)
	endif()
endfunction()

function(CPU_IsFeatureSupportedByHost result feature)
	CPU_GetArchitecture(arch)
	CPU_GetHostFeatures(hostFeatures)
	IF("${feature}" IN_LIST hostFeatures)
		set(${result} TRUE PARENT_SCOPE)
	else()
		set(${result} FALSE PARENT_SCOPE)
	endif()
endfunction()

macro(CPU_OptForHost)
	CPU_GetArchitectureFeatures(features)
	foreach(feature IN LISTS features)
		CPU_IsFeatureSupportedByHost(supported "${feature}")
		IF(${supported})
			CPU_EnableFeature(${feature})
		endif()
	endforeach()
endmacro()

macro(CPU_SetCompileDefinitions)
	#architecture
	CPU_GetArchitecture(arch)
	if(${arch} STREQUAL "x86_64")
		add_definitions(-DXPC_ARCH_X86_64)

		CPU_IsFeatureEnabled(enabled "sse2")
		if(${enabled})
			add_definitions(-DXPC_FEATURE_SSE2)
		endif()

		CPU_IsFeatureEnabled(enabled "sse3")
		if(${enabled})
			add_definitions(-DXPC_FEATURE_SSE3)
		endif()

		CPU_IsFeatureEnabled(enabled "sse4.1")
		if(${enabled})
			add_definitions(-DXPC_FEATURE_SSE4_1)
		endif()
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





#internal
macro(LIST_REPLACE list find replace)
	list(FIND ${list} ${find} find_idx)
	if(find_idx GREATER -1)
		list(INSERT ${list} ${find_idx} ${replace})
		MATH(EXPR __INDEX "${find_idx} + 1")
		list(REMOVE_AT ${list} ${__INDEX})
	endif()
endmacro()
