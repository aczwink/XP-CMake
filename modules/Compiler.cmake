macro(Compiler_OptForHost)
	if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU") #gcc
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native")
	else()
		message(FATAL_ERROR "NOT IMPLEMENTED")
	endif()
endmacro()
