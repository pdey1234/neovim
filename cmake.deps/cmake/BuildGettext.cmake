if(MSVC)
  if(USE_EXISTING_SRC_DIR)
    unset(GETTEXT_URL)
  endif()
  ExternalProject_Add(gettext
    URL ${GETTEXT_URL}
    URL_HASH SHA256=${GETTEXT_SHA256}
    DOWNLOAD_NO_PROGRESS TRUE
    DOWNLOAD_DIR ${DEPS_DOWNLOAD_DIR}/gettext
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy
      ${CMAKE_CURRENT_SOURCE_DIR}/cmake/GettextCMakeLists.txt
      ${DEPS_BUILD_DIR}/src/gettext/CMakeLists.txt
    CMAKE_ARGS ${DEPS_CMAKE_ARGS}
      -D LIBICONV_INCLUDE_DIRS=${DEPS_INSTALL_DIR}/include
      -D LIBICONV_LIBRARIES=${DEPS_LIB_DIR}/${CMAKE_STATIC_LIBRARY_PREFIX}libcharset${CMAKE_STATIC_LIBRARY_SUFFIX}$<SEMICOLON>${DEPS_LIB_DIR}/${CMAKE_STATIC_LIBRARY_PREFIX}libiconv${CMAKE_STATIC_LIBRARY_SUFFIX}
    CMAKE_CACHE_ARGS ${DEPS_CMAKE_CACHE_ARGS})
else()
  message(FATAL_ERROR "Trying to build gettext in an unsupported system ${CMAKE_SYSTEM_NAME}/${CMAKE_C_COMPILER_ID}")
endif()

list(APPEND THIRD_PARTY_DEPS gettext)
if(USE_BUNDLED_LIBICONV)
  add_dependencies(gettext libiconv)
endif()
