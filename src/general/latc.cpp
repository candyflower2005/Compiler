#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "../frontend/Frontend.h"
#include "../grammar/Parser.H"
#include "../backend/QuadrupleGenerator.h"
#include "../backend/Optimizer.h"
#include "environment.h"
#include "logger.h"

int General::QuadrupleEnvironment::locCnt = -1;
int General::QuadrupleEnvironment::blockCnt = -1;
int General::QuadrupleEnvironment::tempCnt = -1;

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

    return 0;
}