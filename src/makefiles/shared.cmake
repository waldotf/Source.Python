# ------------------------------------------------------------------
# File: src/makefiles/shared.cmake
# Purpose: This is the base Win32 CMake file which sets a bunch of
#    shared flags across all Win32 builds.
# ------------------------------------------------------------------

# ------------------------------------------------------------------
# We only need a release and debug configuration.
# ------------------------------------------------------------------
Set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING
	"Only do Release and Debug"
	FORCE
)

# ------------------------------------------------------------------
# Setup include paths.
# ------------------------------------------------------------------
Set(SOURCESDK_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/hl2sdk)
Set(THIRDPARTY_DIR       ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty)

# ------------------------------------------------------------------
# SDK Directories.
# ------------------------------------------------------------------
Set(SOURCESDK            ${SOURCESDK_DIR}/${BRANCH})
Set(SOURCESDK_LIB        ${SOURCESDK}/lib)

# ------------------------------------------------------------------
# Thirdparty libraries.
# ------------------------------------------------------------------
Set(THIRDPARTY_INCLUDE   ${THIRDPARTY_DIR}/include)
Set(THIRDPARTY_LIB       ${THIRDPARTY_DIR}/libs)

# ------------------------------------------------------------------
# Boost specific.
# ------------------------------------------------------------------
Set(BOOSTSDK_INCLUDE     ${THIRDPARTY_INCLUDE}/boost) # ..needed to allow #include <boost/xx.hpp>
Set(BOOSTSDK_LIB         ${THIRDPARTY_LIB}/boost)

# ------------------------------------------------------------------
# Dyncall specific.
# ------------------------------------------------------------------
Set(DYNCALLSDK_INCLUDE     ${THIRDPARTY_INCLUDE}/dyncall)
Set(DYNCALLSDK_LIB         ${THIRDPARTY_LIB}/dyncall)

# ------------------------------------------------------------------
# AsmJit specific.
# ------------------------------------------------------------------
Set(ASMJITSDK_INCLUDE     ${THIRDPARTY_INCLUDE}/AsmJit)
Set(ASMJITSDK_LIB         ${THIRDPARTY_LIB}/AsmJit)

# ------------------------------------------------------------------
# DynamicHooks specific.
# ------------------------------------------------------------------
Set(DYNAMICHOOKSSDK_INCLUDE     ${THIRDPARTY_INCLUDE}/dynamichooks)
Set(DYNAMICHOOKSSDK_LIB         ${THIRDPARTY_LIB}/dynamichooks)

# ------------------------------------------------------------------
# Include directories
# ------------------------------------------------------------------
Include_Directories(
    ${SOURCESDK}
    ${SOURCESDK}/common
    ${SOURCESDK}/common/protobuf-2.5.0/src
    ${SOURCESDK}/game/shared
    ${SOURCESDK}/game/server
    ${SOURCESDK}/public
    ${SOURCESDK}/public/tier0
    ${SOURCESDK}/public/tier1
    ${SOURCESDK}/public/engine/protobuf
    ${DYNCALLSDK_INCLUDE}
    ${BOOSTSDK_INCLUDE}
    ${ASMJITSDK_INCLUDE}
    ${DYNAMICHOOKSSDK_INCLUDE}
    ${CMAKE_CURRENT_SOURCE_DIR}/core # Hack but required.
)

# ------------------------------------------------------------------
# This is required to get boost to statically link.
# ------------------------------------------------------------------
Add_Definitions(
    -DBOOST_PYTHON_STATIC_LIB
    -DBOOST_PYTHON_SOURCE
    -DBOOST_PYTHON_NO_LIB
    -DASMJIT_STATIC # https://asmjit.com/doc/group__asmjit__build.html
)

# ------------------------------------------------------------------
# The project.
# ------------------------------------------------------------------
Project(source-python C CXX)
