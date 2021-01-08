#ifndef LATTE_OPTIMIZER_H
#define LATTE_OPTIMIZER_H

#include "../general/quadruple_environment.h"
#include "../general/types.h"
#include <unordered_set>


class Optimizer {
    std::unordered_map<Ident, General::QuadrupleBlock *> *blocksMap;
    std::vector<General::QuadrupleBlock *> *blocks;
    std::unordered_map<Ident, std::vector<Ident>> edges_out;
    std::unordered_map<Ident, std::vector<Ident>> edges_in;

    // ins[blockame] = [in[instr_i]]
    std::unordered_map<Ident, std::vector<std::unordered_set<Ident>>> ins;
    std::unordered_map<Ident, std::vector<std::unordered_set<Ident>>> outs;

    void createGraph();

    void eliminatePhi();

    void concatBlocks();

    void computeDataFlow();

    void print();

public:
    Optimizer(General::QuadrupleEnvironment &env);

    std::vector<General::QuadrupleBlock *> *getBlocks();

    std::unordered_map<Ident, General::QuadrupleBlock *> *getBlocksMap();

    void optimize();

    std::map<Ident, FunctionDef *> funDefs;
};


#endif //LATTE_OPTIMIZER_H
