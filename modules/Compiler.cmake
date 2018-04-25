macro(Compiler_AutoBuildType)
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

macro(Compiler_OptForHost)
	if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU") #gcc
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native")
	elseif(MSVC)
		#TODO: msvc does not have such an option
		#need to query cpu features and set them
	else()
		message(FATAL_ERROR "NOT IMPLEMENTED")
	endif()
endmacro()
