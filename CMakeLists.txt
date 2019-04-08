cmake_minimum_required(VERSION 3.1)
project(apriltag)

if (APPLE)
    set(CMAKE_CXX_STANDARD 11)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

find_package(Threads REQUIRED)
find_package(OpenCV QUIET)

include_directories(.)
aux_source_directory(common COMMON_SRC)
aux_source_directory(. APRILTAG_SRCS)

execute_process(
    COMMAND git describe --dirty
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_TAG
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )

# # Library
# add_library(${PROJECT_NAME} SHARED ${APRILTAG_SRCS} ${COMMON_SRC})
# target_link_libraries(${PROJECT_NAME} Threads::Threads m)

# set_target_properties(${PROJECT_NAME} PROPERTIES SOVERSION 3 VERSION 3.0.0)

 if(APPLE)
    add_library(${PROJECT_NAME} SHARED ${APRILTAG_SRCS} apriltag.h ${COMMON_SRC})
    set_target_properties(${PROJECT_NAME} PROPERTIES
        FRAMEWORK TRUE
        FRAMEWORK_VERSION C
        MACOSX_FRAMEWORK_IDENTIFIER com.vantagerobortics.apriltags
        VERSION 3.0.0
        SOVERSION 3 
        MACOSX_FRAMEWORK_BUNDLE_VERSION 1
        MACOSX_FRAMEWORK_SHORT_VERSION_STRING ${GIT_TAG}
        PUBLIC_HEADER apriltag.h
        XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
        )
    # target_compile_definitions (rdbfwlib PRIVATE RDB_USE_STD_TUNE )
    target_link_libraries(${PROJECT_NAME} Threads::Threads m)

    include(GNUInstallDirs)
    target_include_directories(${PROJECT_NAME} PUBLIC
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>"
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/common>"
        "$<INSTALL_INTERFACE:$<INSTALL_PREFIX>/${CMAKE_INSTALL_INCLUDEDIR}>/apriltag")

    set_target_properties(${PROJECT_NAME} PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_INSTALL_LIBDIR}
        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_INSTALL_LIBDIR}
)
endif()

# # install library
# install(TARGETS ${PROJECT_NAME} EXPORT apriltag
#     LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#     ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
# )

# # install header file hierarchy
# file(GLOB_RECURSE HEADER_FILES RELATIVE ${CMAKE_SOURCE_DIR} *.h)
# foreach(HEADER ${HEADER_FILES})
#     string(REGEX MATCH "(.*)[/\\]" DIR ${HEADER})
#     install(FILES ${HEADER} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}/${DIR})
# endforeach()

# # export library
# install(EXPORT apriltag
#     DESTINATION share/apriltag/cmake
#     FILE apriltagConfig.cmake
# )

# FILE(READ apriltag.pc.in PKGC)
# STRING(REGEX REPLACE "^prefix=" "prefix=${CMAKE_INSTALL_PREFIX}" PKGC_CONF "${PKGC}" )
# FILE(WRITE ${PROJECT_BINARY_DIR}/apriltag.pc ${PKGC_CONF})
# install(FILES "${PROJECT_BINARY_DIR}/apriltag.pc" DESTINATION "lib/pkgconfig/")

# # Examples
# # apriltag_demo
# add_executable(apriltag_demo example/apriltag_demo.c)
# target_link_libraries(apriltag_demo apriltag)

# # opencv_demo
# if(OpenCV_FOUND)
#     add_executable(opencv_demo example/opencv_demo.cc)
#     target_link_libraries(opencv_demo apriltag ${OpenCV_LIBRARIES})
#     install(TARGETS opencv_demo RUNTIME DESTINATION bin)
# endif(OpenCV_FOUND)

# # install example programs
# install(TARGETS apriltag_demo RUNTIME DESTINATION bin)













