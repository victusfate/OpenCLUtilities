# - Try to find OpenCL
# Once done this will define
#  
#  OPENCL_FOUND        - system has OpenCL
#  OPENCL_INCLUDE_DIR  - the OpenCL include directory
#  OPENCL_LIBRARIES    - link these to use OpenCL
#
# WIN32 should work, but is untested

IF (WIN32)

    FIND_PATH(OPENCL_INCLUDE_DIR CL/cl.h )

    # TODO this is only a hack assuming the 64 bit library will
    # not be found on 32 bit system
    FIND_LIBRARY(OPENCL_LIBRARIES opencl ) #used to say opencl64
    IF( OPENCL_LIBRARIES )
        FIND_LIBRARY(OPENCL_LIBRARIES opencl ) #used to say opencl32
    ENDIF( OPENCL_LIBRARIES )

ELSE (WIN32)

    # Unix style platforms
    # We also search for OpenCL in the NVIDIA GPU SDK default location
    #SET(OPENCL_INCLUDE_DIR  "$ENV{OPENCL_HOME}/common/inc"
    #   CACHE PATH "path to Opencl Include files")

    FIND_PATH(OPENCL_INCLUDE_DIR CL/cl.hpp PATHS /usr/local/cuda/include )
    FIND_PATH(OPENCL_INCLUDE_DIR CL/cl.hpp PATHS $ENV{AMDAPPSDKROOT}/include )

    FIND_LIBRARY(OPENCL_LIBRARIES OpenCL /usr/local/cuda/lib)
    FIND_LIBRARY(OPENCL_LIBRARIES OpenCL $ENV{AMDAPPSDKROOT}/lib/x86_64)
    message("opencl_libraries: ${OPENCL_LIBRARIES}")

ENDIF (WIN32)

SET( OPENCL_FOUND "NO" )
IF(OPENCL_LIBRARIES )
    SET( OPENCL_FOUND "YES" )
ENDIF(OPENCL_LIBRARIES)

MARK_AS_ADVANCED(
  OPENCL_INCLUDE_DIR
)
