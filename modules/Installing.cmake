function(Install_ExportAndRegisterPackage exportName packageName)
	if(WIN32)
		install(EXPORT ${exportName} DESTINATION cmake)
		#add it to the package registry
		install(CODE
			"execute_process(COMMAND reg add \"HKCU\\\\Software\\\\Kitware\\\\CMake\\\\Packages\\\\${packageName}\" /v Path /t REG_SZ /f /d \"${CMAKE_INSTALL_PREFIX}\")"
		)
	else()
		install(EXPORT ${exportName} DESTINATION "share/${packageName}/cmake")
		#file(WRITE "${PROJECT_BINARY_DIR}/_installRegFile" "${CMAKE_INSTALL_PREFIX}/share/${packageName}/cmake")
		#install (
			#FILES "${PROJECT_BINARY_DIR}/_installRegFile"
			#DESTINATION "$ENV{HOME}/.cmake/packages/${packageName}"
			#RENAME "${PKGUID}"
		#)
	endif()
endfunction()
