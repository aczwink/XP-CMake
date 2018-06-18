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
