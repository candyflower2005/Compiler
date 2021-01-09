#ifndef LATTE_QUADRUPLE_ENVIRONMENT_H
#define LATTE_QUADRUPLE_ENVIRONMENT_H

#include "types.h"
#include "function_def.h"
#include "environment.h"
#include<map>
#include <utility>
#include<vector>
#include<string>
#include <unordered_map>
#include<iostream>

typedef int Loc;
typedef std::unordered_map<Ident, Loc> varAddressesType; // (var name, loc)
typedef std::unordered_map<Loc, Ident> varValuesType; // (loc, temp name)


namespace General {
    class QuadrupleEnvironment {
        Ident recentReg, recentOp;
        General::Type tempVarType;

        std::vector<General::QuadrupleBlock *> *blocks;
        std::unordered_map<Ident, General::QuadrupleBlock *> *blocksMap;
        std::map<Ident, FunctionDef *> funDefs;

        std::shared_ptr<varAddressesType> varAddesses;
        std::shared_ptr<varValuesType> varValues;

        bool replaceOccurrence(Ident blockName, Ident oldTemp, Ident newTemp);

    public:
        static int locCnt, blockCnt, tempCnt;

        QuadrupleEnvironment() = default;

        QuadrupleEnvironment(General::Environment &env) : funDefs(env.getFunDefs()),
                                                          blocks(new std::vector<General::QuadrupleBlock *>),
                                                          blocksMap(
                                                                  new std::unordered_map<Ident, General::QuadrupleBlock *>),
                                                          varAddesses(new varAddressesType()),
                                                          varValues(new varValuesType()) {}

        QuadrupleEnvironment(QuadrupleEnvironment &env) : funDefs(env.funDefs),
                                                          blocks(env.blocks),
                                                          blocksMap(env.blocksMap),
                                                          varAddesses(new varAddressesType(*env.varAddesses)),
                                                          varValues(new varValuesType(*env.varValues)) {}

        static int getNewLoc() {
            locCnt++;
            return locCnt;
        }

        std::vector<General::QuadrupleBlock *> *getBlocks();

        std::unordered_map<Ident, General::QuadrupleBlock *> *getBlocksMap();

        std::map<Ident, FunctionDef *> getFunDefs();

        void setNewVarAddress(Ident varName, Loc loc);

        void setNewVarValue(Loc loc, Ident tempName);

        Loc getVarAddress(Ident varName);

        Ident getVarValue(Loc loc);

        void generatePhiInstr(Ident currBlock, QuadrupleEnvironment &env1, Ident label1, QuadrupleEnvironment &env2,
                              Ident label2, Ident endpoint);

        Ident getFunBlockLabel(Ident funName);

        Ident getFreshTemp();

        Ident getFreshLabel(const std::string &prefix = "");

        void addNewBlock(Ident label, QuadrupleBlock *newBlock);

        void addTempVarType(Type type);

        Type getTempVarType();

        Type getRecentRegister();

        const std::string &getRecentOp();

        void addNewOp(Ident opName);

        FunctionDef *getFunctionDef(Ident funName);

        void print();

        void setVarVal(Loc loc, Ident ident);
    };
}

#endif //LATTE_QUADRUPLE_ENVIRONMENT_H
