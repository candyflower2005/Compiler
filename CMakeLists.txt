cmake_minimum_required(VERSION 3.17)
project(Latte)

set(CMAKE_CXX_STANDARD 14)

include_directories(src/backend)
include_directories(src/frontend)
include_directories(src/general)
include_directories(src/grammar)

add_executable(Latte
        src/backend/QuadrupleGenerator.cpp
        src/backend/QuadrupleGenerator.h
        src/frontend/DeclFrontend.cpp
        src/frontend/DeclFrontend.h
        src/frontend/ExprFrontend.cpp
        src/frontend/ExprFrontend.h
        src/frontend/Frontend.cpp
        src/frontend/Frontend.h
        src/frontend/TopDefFrontend.cpp
        src/frontend/TopDefFrontend.h
        src/general/environment.cpp
        src/general/environment.h
        src/general/function_def.cpp
        src/general/function_def.h
        src/general/latc.cpp
        src/general/logger.cpp
        src/general/logger.h
        src/general/types.cpp
        src/general/types.h
        src/grammar/Absyn.C
        src/grammar/Absyn.H
        src/grammar/Lexer.C
        src/grammar/Parser.C
        src/grammar/Parser.H
        src/grammar/Printer.C
        src/grammar/Printer.H
        src/general/quadruple_environment.cpp
        src/general/quadruple_environment.h
        src/backend/Optimizer.cpp
        src/backend/Optimizer.h)
