#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>

#include "../frontend/Frontend.h"
#include "../grammar/Parser.H"
#include "../backend/QuadrupleGenerator.h"
#include "../backend/Optimizer.h"
#include "../backend/AssemblyCodeGenerator.h"
#include "environment.h"
#include "logger.h"

int General::QuadrupleEnvironment::locCnt = -1;
int General::QuadrupleEnvironment::blockCnt = -1;
int General::QuadrupleEnvironment::tempCnt = -1;


std::string dir(const std::string &fname) {
    size_t pos = fname.find_last_of("\\/");
    return (std::string::npos == pos)
           ? "."
           : fname.substr(0, pos);
}

int main(int argc, char **argv) {
    FILE *input;

    input = fopen(argv[1], "r");
    if (!input) {
        std::cerr << "can't open the input file";
        return 1;
    }

    auto ast = Latte::pProgram(input);
    if (!ast) {
        return 1;
    }

    auto env = General::Environment();
    auto logger = General::Logger();
    try {
        Frontend frontend(ast, env, logger, "####");
    } catch (General::CompilerError &e) {
        std::cerr << "ERROR\n";
        logger.print();
        return 1;
    } catch (std::exception &e) {
        std::cerr << "ERROR\n";
        std::cerr << "compiler error\n";
        return 1;
    }

    std::cout << "OK\n";
    logger.print();

    General::QuadrupleEnvironment newEnv(env);
    QuadrupleGenerator qGen(ast, newEnv);
    std::cerr << "env przed optymalizacjami:" << std::endl;
    newEnv.print();

    Optimizer opt(newEnv);
    opt.optimize();

    AssemblyCodeGenerator assCodeGen(opt);
    std::string out_code = assCodeGen.generateCode();

    std::string string_path = std::string(argv[1]);
    std::string directory = dir(string_path);
    std::string filename_with_ext = string_path.substr(string_path.find_last_of("/\\") + 1);
    size_t ext = filename_with_ext.find_last_of(".");
    std::string filename = filename_with_ext.substr(0, ext);

    std::string ass_file_name = directory + "/" + filename + ".s";
    std::ofstream ass_file(ass_file_name);
    ass_file << out_code << std::endl;

    std::cout << "\n\n\n" << out_code << std::endl;

    std::string out_file_name = directory + "/" + filename + ".o";
    std::string ex_file_name = directory + "/" + filename;

    std::string instr = "gcc -m32 lib/runtime.o " + ass_file_name + " -o " + ex_file_name;
    std::system(instr.c_str());

    return 0;
}