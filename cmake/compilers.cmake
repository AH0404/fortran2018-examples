set(CMAKE_CONFIGURATION_TYPES "Release;Debug" CACHE STRING "Build type selections" FORCE)



if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  if(WIN32)
    string(APPEND CMAKE_Fortran_FLAGS " /traceback /warn /heap-arrays")
    string(APPEND CMAKE_Fortran_FLAGS_DEBUG " /stand:f18")
  else()
    string(APPEND CMAKE_Fortran_FLAGS " -traceback -warn -heap-arrays")
    string(APPEND CMAKE_Fortran_FLAGS_DEBUG " -stand f18")
  endif()

  if(WIN32)
    string(APPEND CMAKE_Fortran_FLAGS_DEBUG " /debug /check:all")
  else()
    string(APPEND CMAKE_Fortran_FLAGS_DEBUG " -debug extended -check all")
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(-march=native -Wall -Wextra)
  if(CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 8)
    string(APPEND CMAKE_Fortran_FLAGS " -std=f2018")
  endif()
  string(APPEND CMAKE_Fortran_FLAGS " -fimplicit-none")

  string(APPEND CMAKE_Fortran_FLAGS_DEBUG " -Werror=array-bounds -fcheck=all")
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  string(APPEND CMAKE_Fortran_FLAGS " -C -Mdclchk")
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL NAG)
  # https://www.nag.co.uk/nagware/np/r70_doc/manual/compiler_2_4.html#OPTIONS
  string(APPEND CMAKE_Fortran_FLAGS " -f2018 -C -colour -gline -nan -info -u")
endif()

include(CheckCSourceCompiles)
include(CheckCSourceRuns)
include(CheckFortranSourceCompiles)

include(${CMAKE_CURRENT_LIST_DIR}/f08block.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f08contig.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f18errorstop.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f18random.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f18assumed_rank.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f08kind.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f18prop.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f08command.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f03ieee.cmake)
