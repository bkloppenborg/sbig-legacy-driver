# - Find SBIG Universal Drivers

# Defines the following variables:
# SBIGUDRV_INCLUDE_DIRS    - Location of SBIGUDRV's include directories
# SBIGUDRV_LIBRARIES       - Location of SBIGUDRV's libraries
# SBIGUDRV_FOUND           - True if SBIGUDRV has been located
# SBIGUDRV_MODULES         - Location of SBIGUDRV's Fortran modules
#
# You may provide a hint to where SBIGUDRV's root directory may be located
# by setting SBIGUDRV_ROOT before calling this script.
#
# Variables used by this module, they can change the default behaviour and
# need to be set before calling find_package:
#
#=============================================================================
# Copyright 2021 Brian Kloppenborg
#
#  This code is licensed under the MIT License.  See the FindSBIGUDRV.cmake script
#  for the text of the license.
#
# The MIT License
#
# License for the specific language governing rights and limitations under
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#=============================================================================

IF(SBIGUDRV_INCLUDES)
  # Already in cache, be silent
  set (SBIGUDRV_FIND_QUIETLY TRUE)
ENDIF (SBIGUDRV_INCLUDES)

find_path(SBIGUDRV_INCLUDE_DIR
  NAMES "sbigudrv.h"
  PATHS ${SBIGUDRV_ROOT}
        ${CMAKE_SYSTEM_INCLUDE_PATH}
        ${CMAKE_SYSTEM_PREFIX_PATH}
  PATH_SUFFIXES "include"
  DOC "Root directory for SBIG USB driver header file."
)

find_library(SBIGUDRV_LIBRARY
  NAMES "sbigudrv"
  PATHS ${SBIGUDRV_ROOT}
        ${CMAKE_SYSTEM_PREFIX_PATH}
  PATH_SUFFIXES "lib"
  DOC "SBIG USB Library"
)

mark_as_advanced(SBIG_INCLUDE_DIR SBIGUDRV_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SBIGUDRV DEFAULT_MSG
  SBIGUDRV_INCLUDE_DIR SBIGUDRV_LIBRARY)

if (SBIGUDRV_FOUND)
  add_library(SBIGUDRV::SBIGUDRV UNKNOWN IMPORTED)
  set_target_properties(SBIGUDRV::SBIGUDRV PROPERTIES
    IMPORTED_LINK_INTERFACE_LANGUAGE "C"
    IMPORTED_LOCATION "${SBIGUDRV_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${SBIGUDRV_INCLUDE_DIRS}")
endif (SBIGUDRV_FOUND)
