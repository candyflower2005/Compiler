#ifndef LATTE_ASSEMBLYCODEGENERATOR_H
#define LATTE_ASSEMBLYCODEGENERATOR_H

#include <vector>
#include <string>
#include "Optimizer.h"


class AssemblyCodeGenerator {
    int strCount = 0;
    std::vector<General::QuadrupleBlock *> *blocks;
    std::unordered_map<Ident, General::QuadrupleBlock *> *blocksMap;
    std::unordered_map<Ident, Ident> tempToStack;
    std::unordered_map<Ident, std::string> tempToString;
    std::unordered_set<Ident> stringRegs;
    std::map<Ident, FunctionDef *> funDefs;
    // ins[blockame] = [in[instr_i]]
    std::unordered_map<Ident, std::vector<std::unordered_set<Ident>>> ins;
    std::unordered_map<Ident, std::vector<std::unordered_set<Ident>>> outs;

    std::vector<std::string>
    generateFunCode(std::vector<General::QuadrupleBlock *>::iterator &blockIt,
                    std::vector<General::QuadrupleBlock *>::iterator endIt);

    void handleRet(General::Instr &currInstr, std::vector<std::string> &assInstr, int &firstFree);

    void handleCall(General::Instr &currInstr, std::vector<std::string> &assInstr, int &firstFree);

    void handleJump(General::Instr &currInstr, General::Instr &lastInstr, std::vector<std::string> &assInstr,
                    int &firstFree);

    void handleAss(General::Instr &currInstr, std::vector<std::string> &assInstr, int &firstFree);

public:
    AssemblyCodeGenerator(Optimizer opt) : blocks(opt.getBlocks()), blocksMap(opt.getBlocksMap()),
                                           funDefs(opt.funDefs), ins(opt.ins), outs(opt.outs) {}

    std::string generateCode();
};


#endif //LATTE_ASSEMBLYCODEGENERATOR_H
