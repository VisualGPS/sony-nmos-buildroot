cmake_minimum_required (VERSION 3.14)

project(nmos-test)

# Add libraries
add_subdirectory(libs)

# Add external libraries
add_subdirectory(libs-ext)

# Add individual projects
add_subdirectory(sandbox)
