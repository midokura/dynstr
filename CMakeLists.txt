# Copyright 2020 Xavier Del Campo Romero
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
cmake_minimum_required(VERSION 3.0)
project(dynstr C)
add_library(${PROJECT_NAME} STATIC "dynstr.c")
target_include_directories(${PROJECT_NAME} PUBLIC "include")
install(TARGETS ${PROJECT_NAME})
install(DIRECTORY include/ TYPE INCLUDE)
file(READ ${CMAKE_CURRENT_LIST_DIR}/dynstr.pc dynstr_pc)
string(REPLACE /usr/local ${CMAKE_INSTALL_PREFIX} dynstr_repl_pc ${dynstr_pc})
file(WRITE ${CMAKE_BINARY_DIR}/dynstr.pc ${dynstr_repl_pc})
include(GNUInstallDirs)
install(FILES ${CMAKE_BINARY_DIR}/dynstr.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)
