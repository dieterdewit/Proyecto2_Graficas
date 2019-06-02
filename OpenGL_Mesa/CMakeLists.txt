# CMake entry point
cmake_minimum_required (VERSION 3.0)
project (Proyecto2)

find_package(OpenGL REQUIRED)


if( CMAKE_BINARY_DIR STREQUAL CMAKE_SOURCE_DIR )
    message( FATAL_ERROR "Wrong Build directory" )
endif()
if( CMAKE_SOURCE_DIR MATCHES " " )
	message( "Source DIrectory contains spaces." )
endif()
if( CMAKE_BINARY_DIR MATCHES " " )
	message( "Source DIrectory contains spaces." )
endif()


# Compile external dependencies 
add_subdirectory (external)

# On Visual 2005 and above, this module can set the debug working directory
cmake_policy(SET CMP0026 OLD)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/external/rpavlik-cmake-modules-fe2273")
include(CreateLaunchers)
include(MSVCMultipleProcessCompile) # /MP

include_directories(
	external/AntTweakBar-1.16/include/
	external/glfw-3.1.2/include/
	external/glm-0.9.7.1/
	external/glew-1.13.0/include/
	external/assimp-3.0.1270/include/
	.
)

set(ALL_LIBS
	${OPENGL_LIBRARY}
	glfw
	GLEW_1130
)

add_definitions(
	-DTW_STATIC
	-DTW_NO_LIB_PRAGMA
	-DTW_NO_DIRECT3D
	-DGLEW_STATIC
	-D_CRT_SECURE_NO_WARNINGS
)

# Proyecto2
add_executable(proyecto2
	proyecto2/proyecto2.cpp
	common/shader.cpp
	common/shader.hpp
	common/controls.cpp
	common/controls.hpp
	common/texture.cpp
	common/texture.hpp
	common/objloader.cpp
	common/objloader.hpp
	common/vboindexer.cpp
	common/vboindexer.hpp
	
	proyecto2/StandardShading.vertexshader
	proyecto2/StandardShading.fragmentshader
)
target_link_libraries(proyecto2
	${ALL_LIBS}
)
# Xcode and Visual working directories
set_target_properties(proyecto2 PROPERTIES XCODE_ATTRIBUTE_CONFIGURATION_BUILD_DIR "${CMAKE_CURRENT_SOURCE_DIR}/proyecto2/")
create_target_launcher(proyecto2 WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/proyecto2/")

# Proyecto2 - Assimp
add_executable(proyecto2_assimp
	proyecto2/proyecto2_assimp.cpp
	common/shader.cpp
	common/shader.hpp
	common/controls.cpp
	common/controls.hpp
	common/texture.cpp
	common/texture.hpp
	common/objloader.cpp
	common/objloader.hpp
	
	proyecto2/StandardShading.vertexshader
	proyecto2/StandardShading.fragmentshader
)
target_link_libraries(proyecto2_assimp
	${ALL_LIBS}
	assimp
)
set_target_properties(proyecto2_assimp PROPERTIES COMPILE_DEFINITIONS "USE_ASSIMP")

# Xcode and Visual working directories
set_target_properties(proyecto2_assimp PROPERTIES XCODE_ATTRIBUTE_CONFIGURATION_BUILD_DIR "${CMAKE_CURRENT_SOURCE_DIR}/proyecto2/")
create_target_launcher(proyecto2_assimp WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/proyecto2/")


SOURCE_GROUP(common REGULAR_EXPRESSION ".*/common/.*" )
SOURCE_GROUP(shaders REGULAR_EXPRESSION ".*/.*shader$" )


if (NOT ${CMAKE_GENERATOR} MATCHES "Xcode" )

add_custom_command(
   TARGET proyecto2 POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/proyecto2${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/proyecto2/"
)
add_custom_command(
   TARGET proyecto2_assimp POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/proyecto2_assimp${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/proyecto2/"
)

elseif (${CMAKE_GENERATOR} MATCHES "Xcode" )

endif (NOT ${CMAKE_GENERATOR} MATCHES "Xcode" )

