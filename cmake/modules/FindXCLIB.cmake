# - Try to find EPIX XCLIB
# Once done this will define
#
#  XCLIB_FOUND - system has EPIX XCLIB
#  XCLIB_INCLUDE_DIR - the EPIX XCLIB include directory
#  XCLIB_LIBRARIES - the libraries needed to use EPIX XCLIB
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

# TODO: properly handle 32-/64-bit differences, and Linux

IF (XCLIB_INCLUDE_DIR AND XCLIB_LIBRARIES)
   # in cache already
   SET(XCLIB_FIND_QUIETLY TRUE)
ELSE (XCLIB_INCLUDE_DIR AND XCLIB_LIBRARIES)
   SET(XCLIB_FIND_QUIETLY FALSE)
ENDIF (XCLIB_INCLUDE_DIR AND XCLIB_LIBRARIES)

IF (NOT XCLIB_DIR)
    file(TO_CMAKE_PATH "$ENV{ProgramFiles}" _PROG_FILES)
    file(TO_CMAKE_PATH "$ENV{ProgramFiles(x86)}" _PROG_FILES_X86)
    if (_PROG_FILES_X86)
        set(_PROGFILESDIR "${_PROG_FILES_X86}")
    else ()
        set(_PROGFILESDIR "${_PROG_FILES}")
    endif ()

    set (XCLIB_DIR "${_PROGFILESDIR}/EPIX/XCLIB" CACHE PATH "Directory containing EPIX PIXCI XCLIB includes and libraries")
ENDIF (NOT XCLIB_DIR)

FIND_PATH (XCLIB_INCLUDE_DIR xcliball.h
    PATHS
    "${XCLIB_DIR}"
    DOC "Directory containing xcliball.h include file")

FIND_LIBRARY (XCLIB_LIBRARIES NAMES XCLIBWNT
    PATHS
    "${XCLIB_DIR}"
    DOC "XCLIB library to link with")

IF (XCLIB_INCLUDE_DIR)
   #MESSAGE(STATUS "DEBUG: Found EPIX XCLIB include dir: ${XCLIB_INCLUDE_DIR}")
ELSE (XCLIB_INCLUDE_DIR)
   MESSAGE(STATUS "XCLIB: WARNING: include dir not found")
ENDIF (XCLIB_INCLUDE_DIR)

IF (XCLIB_LIBRARIES)
   #MESSAGE(STATUS "DEBUG: Found EPIX XCLIB library: ${XCLIB_LIBRARIES}")
ELSE (XCLIB_LIBRARIES)
   MESSAGE(STATUS "XCLIB: WARNING: library not found")
ENDIF (XCLIB_LIBRARIES)

INCLUDE (FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS (XCLIB  DEFAULT_MSG  XCLIB_INCLUDE_DIR XCLIB_LIBRARIES)

MARK_AS_ADVANCED(XCLIB_INCLUDE_DIR XCLIB_LIBRARIES)
