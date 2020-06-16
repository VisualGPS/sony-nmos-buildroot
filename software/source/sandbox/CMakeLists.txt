cmake_minimum_required(VERSION 3.0)

#
# About the project
#
project(sandbox)

# If no CXX flags, then define our own
if( NOT ${CMAKE_CXX_FLAGS})
    SET(CMAKE_CXX_FLAGS "-std=c++11 -Wall -Werror")
endif()

# The default nmos-cpp root directory
set(NMOS_CPP_DIR ${PROJECT_SOURCE_DIR}/../libs-ext/nmos-cpp/Development)

# We need boost for nmos-cpp.
find_package(Boost 1.45.0 COMPONENTS system date_time filesystem regex)

# since std::shared_mutex is not available until C++17
list(APPEND FIND_BOOST_COMPONENTS thread)
add_definitions(/DBST_SHARED_MUTEX_BOOST)

#
# Include directories
#
include_directories(
	../
	${NMOS_CPP_DIR}
)

#
# Add executable name and project files
#
add_executable(sandbox
	main.cpp
	node_implementation.cpp node_implementation.h
	config.json	
)

#
# Add additional libraries
#
target_link_libraries(sandbox 
    nmos-cpp_static
    ${Boost_LIBRARIES}
)
