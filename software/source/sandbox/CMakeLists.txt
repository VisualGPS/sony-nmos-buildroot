cmake_minimum_required(VERSION 3.0)

#
# About the project
#
project(sandbox)

# If no CXX flags, then define our own
if( NOT ${CMAKE_CXX_FLAGS})
    SET(CMAKE_CXX_FLAGS "-std=c++11 -Wall -Werror")
endif()

#
# Include directories
#
include_directories(
	../
)

#
# Add executable name and project files
#
add_executable(sandbox
	main.cpp
)

#
# Add additional libraries
#
target_link_libraries(sandbox avahi-client avahi-common)


