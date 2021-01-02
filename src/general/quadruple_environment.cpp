#include <iostream>
#include <utility>
#include "quadruple_environment.h"


Ident General::QuadrupleEnvironment::getFunBlockLabel(Ident funName) {
    return "fun_" + funName;
}

Ident General::QuadrupleEnvironment::getFreshTemp() {
    tempCnt++;
    recentReg = "t" + std::to_string(tempCnt);
    return recentReg;
}

Ident General::QuadrupleEnvironment::getFreshLabel(const std::string &prefix) {
    blockCnt++;
    if (prefix.empty()) {
        return "block" + std::to_string(blockCnt);
    }
    return prefix + "_block" + std::to_string(blockCnt);
}

void General::QuadrupleEnvironment::addNewBlock(Ident label, General::QuadrupleBlock *newBlock) {
    (*blocks).push_back(newBlock);
    (*blocksMap)[label] = newBlock;
}

void General::QuadrupleEnvironment::addTempVarType(General::Type type) {
    tempVarType = std::move(type);
}

General::Type General::QuadrupleEnvironment::getTempVarType() {
    return tempVarType;
}

General::Type General::QuadrupleEnvironment::getRecentRegister() {
    return General::Register(recentReg);
}

const std::string &General::QuadrupleEnvironment::getRecentOp() {
    return recentOp;
}

void General::QuadrupleEnvironment::addNewOp(Ident opName) {
    recentOp = std::move(opName);
}

FunctionDef *General::QuadrupleEnvironment::getFunctionDef(Ident funName) {
    return funDefs[funName];
}

void General::QuadrupleEnvironment::setNewVarAddress(Ident varName, Loc loc) {
    (*varAddesses)[varName] = loc;
}

void General::QuadrupleEnvironment::setNewVarValue(Loc loc, Ident tempName) {
    (*varValues)[loc] = std::move(tempName);
}

Loc General::QuadrupleEnvironment::getVarAddress(Ident varName) {
    return (*varAddesses)[varName];
}

Ident General::QuadrupleEnvironment::getVarValue(Loc loc) {
    return (*varValues)[loc];
}

std::vector<General::QuadrupleBlock *> *General::QuadrupleEnvironment::getBlocks() {
    return blocks;
}

std::unordered_map<Ident, General::QuadrupleBlock *> *General::QuadrupleEnvironment::getBlocksMap() {
    return blocksMap;
}

std::map<Ident, FunctionDef *> General::QuadrupleEnvironment::getFunDefs() {
    return funDefs;
}

void General::QuadrupleEnvironment::generatePhiInstr(Ident currBlock, General::QuadrupleEnvironment &env1, Ident label1,
                                                     General::QuadrupleEnvironment &env2, Ident label2) {
    for (auto &it: *varValues) {
        Ident currTemp = it.second;
        Ident env1Temp = env1.getVarValue(it.first);
        Ident env2Temp = env2.getVarValue(it.first);

        if (env1Temp == env2Temp) {
            (*varValues)[it.first] = env1Temp;
        } else {
            Ident newTemp = getFreshTemp();
            auto res = General::Register(newTemp);
            auto instr = General::Instr(INSTR_PHI, OP_NULL, res, argsType{label1, env1Temp, label2, env2Temp});
            (*blocksMap)[currBlock]->addInstr(instr);
            (*varValues)[it.first] = newTemp;
        }
    }
}

void General::QuadrupleEnvironment::print() {
    std::cerr << "wchodze, liczba bloków wynosi " << blocks->size() << std::endl;
    for (auto &b: *blocks) {
        b->print();
        std::cerr << std::endl;
    }
}
