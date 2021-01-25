#include <unordered_set>
#include <queue>
#include "Optimizer.h"

void Optimizer::eliminatePhi() {
    for (auto &b: *blocks) {
        int phiCnt = 0;
        for (auto &instr: *(b->listInstr())) {
            if (instr.getInstrName() == INSTR_PHI) {
                phiCnt++;
                std::vector<General::Type> &phiArgs = *(instr.getArgs());
                auto res = *(instr.getRes());
                Ident label1 = phiArgs[0].getVal(), label2 = phiArgs[2].getVal();
                auto temp1 = phiArgs[1], temp2 = phiArgs[3];
                auto instr1 = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, res, argsType{temp1});
                auto instr2 = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, res, argsType{temp2});
                (*blocksMap)[label1]->addInstrBeforeJump(instr1);
                (*blocksMap)[label2]->addInstrBeforeJump(instr2);
            }
        }
        std::list<General::Instr> &curr = *(b->listInstr());
        auto endIt = curr.begin();
        for (int i = 0; i < phiCnt; i++) {
            endIt++;
        }
        curr.erase(curr.begin(), endIt);
        //std::list<General::Instr>(curr.begin() + phiCnt, curr.end()).swap(curr);
    }
}

void Optimizer::createGraph() {
    edges_in = std::unordered_map<Ident, std::vector<Ident>>();
    edges_out = std::unordered_map<Ident, std::vector<Ident>>();
    Ident currFun;
    for (auto b = blocks->begin(); b != blocks->end(); ++b) {
        if ((*b)->getLabel().rfind("fun", 0) == 0) { // functions start with "fun_"
            Ident label = (*b)->getLabel();
            currFun = std::string(label.begin() + 4, label.end());
        }
        auto blockLabel = (*b)->getLabel();
        auto nextBlock = std::next(b);

        if ((*b)->listInstr()->empty()) {
            if (nextBlock == blocks->end() || (*nextBlock)->getLabel().rfind("fun", 0) == 0) {
                if (funDefs[currFun]->getFunType().print() == "void") {
                    auto instr = General::Instr(INSTR_RETURN, OP_NULL, General::Type(""), argsType{});
                    (*b)->addInstr(instr);
                } else {
                    auto funArgs = argsType{General::String(RUN_TIME_ERROR),
                                            General::String("No return in a non-void function")};
                    auto newInstr = General::Instr(INSTR_CALL_NO_RET, OP_NULL, General::Type(""), funArgs);
                    (*b)->addInstr(newInstr);
                }
            } else {
                auto nextBlockLabel = (*nextBlock)->getLabel();
                edges_out[blockLabel].push_back(nextBlockLabel);
                edges_in[nextBlockLabel].push_back(blockLabel);
            }
            continue;
        }

        auto lastInstr = std::prev((*b)->listInstr()->end());
        auto instrName = lastInstr->getInstrName();
        if (instrName == INSTR_RETURN) {
            continue;
        } else if (instrName == INSTR_JUMP) {
            auto jumpTarget = (*lastInstr->getArgs())[0].getVal();
            edges_out[blockLabel].push_back(jumpTarget);
            edges_in[jumpTarget].push_back(blockLabel);
        } else if (instrName == INSTR_IF_NOT_JUMP || instrName == INSTR_IF_JUMP) {
            auto jumpTarget = (*lastInstr->getArgs())[1].getVal();
            edges_out[blockLabel].push_back(jumpTarget);
            edges_in[jumpTarget].push_back(blockLabel);

            auto nextBlockLabel = (*nextBlock)->getLabel();
            edges_out[blockLabel].push_back(nextBlockLabel);
            edges_in[nextBlockLabel].push_back(blockLabel);
        } else if (instrName == INSTR_CALL_NO_RET && (*lastInstr->getArgs())[0].getVal() == RUN_TIME_ERROR) {
            continue;
        } else {
            if (nextBlock == blocks->end() || (*nextBlock)->getLabel().rfind("fun", 0) == 0) {
                if (funDefs[currFun]->getFunType().print() == "void") {
                    auto instr = General::Instr(INSTR_RETURN, OP_NULL, General::Type(""), argsType{});
                    (*b)->addInstr(instr);
                } else {
                    auto funArgs = argsType{General::String(RUN_TIME_ERROR),
                                            General::String("No return in a non-void function")};
                    auto newInstr = General::Instr(INSTR_CALL_NO_RET, OP_NULL, General::Type(""), funArgs);
                    (*b)->addInstr(newInstr);
                }
            } else {
                auto nextBlockLabel = (*nextBlock)->getLabel();
                edges_out[blockLabel].push_back(nextBlockLabel);
                edges_in[nextBlockLabel].push_back(blockLabel);
            }
        }
    }
}

void Optimizer::concatBlocks() {
    bool changed = true;
    while (changed) {
        changed = false;
        for (auto &b: *blocksMap) {
            if (b.second->listInstr()->empty()) {
                Ident label = b.first;
                if (label.rfind("fun", 0) == 0) {
                    continue;
                }
                blocksMap->erase(label);
                auto blockIt = blocks->begin();
                while ((*blockIt)->getLabel() != label) {
                    blockIt++;
                }
                Ident nextBlockLabel = (*(blockIt + 1))->getLabel();
                blocks->erase(blockIt);

                for (auto &bl: *blocks) {
                    for (auto &instr: *bl->listInstr()) {
                        if (instr.getInstrName() == INSTR_IF_NOT_JUMP || instr.getInstrName() == INSTR_IF_JUMP) {
                            auto &targetArg = (*instr.getArgs())[1];
                            if (targetArg.getVal() == label) {
                                targetArg.changeVal(nextBlockLabel);
                            }
                        }
                        if (instr.getInstrName() == INSTR_JUMP) {
                            auto &targetArg = (*instr.getArgs())[0];
                            if (targetArg.getVal() == label) {
                                targetArg.changeVal(nextBlockLabel);
                            }
                        }
                    }
                }

                auto &blockIn = edges_in[label];
                for (int i = 0; i < blockIn.size(); i++) {
                    std::string inBlockLabel = blockIn[i];
                    auto blockIt = edges_out[inBlockLabel].begin();
                    while (*blockIt != label) {
                        blockIt++;
                    }
                    edges_out[inBlockLabel].erase(blockIt);
                    edges_out[inBlockLabel].push_back(nextBlockLabel);
                    edges_in[nextBlockLabel].push_back(inBlockLabel);
                }

                auto &blockOut = edges_out[label];
                for (int i = 0; i < blockOut.size(); i++) {
                    std::string outBlockLabel = blockOut[i];
                    auto blockIt = edges_in[outBlockLabel].begin();
                    while (*blockIt != label) {
                        blockIt++;
                    }
                    edges_in[outBlockLabel].erase(blockIt);
                    edges_in[outBlockLabel].push_back(nextBlockLabel);
                    edges_out[nextBlockLabel].push_back(outBlockLabel);
                }

                changed = true;
                break;
            }
        }
    }
}

void Optimizer::computeDataFlow() {
    // Initialization
    for (auto &b: *blocksMap) {
        Ident blockName = b.first;
        ins[blockName] = std::vector<std::unordered_set<Ident>>();
        outs[blockName] = std::vector<std::unordered_set<Ident>>();
        for (int i = 0; i < b.second->listInstr()->size(); i++) {
            ins[blockName].push_back(std::unordered_set<Ident>());
            outs[blockName].push_back(std::unordered_set<Ident>());
        }
        if (b.second->listInstr()->empty()) {
            ins[blockName].push_back(std::unordered_set<Ident>());
            outs[blockName].push_back(std::unordered_set<Ident>());
        }
    }

    while (true) {
        // Store state from the last iteration
        auto curr_ins = std::vector<std::unordered_set<Ident>>();
        auto curr_outs = std::vector<std::unordered_set<Ident>>();
        for (auto &b: *blocksMap) {
            curr_ins.push_back(ins[b.first][0]);
            curr_outs.push_back(outs[b.first][outs[b.first].size() - 1]);
        }

        // Compute ins
        for (auto &b: *blocksMap) {
            Ident blockName = b.first;
            //std::cerr << "Block " << blockName  << std::endl;
            int numInstr = b.second->listInstr()->size();
            auto currIt = std::prev((*b.second->listInstr()).end());
            for (int i = numInstr - 1; i >= 0; --i) {
                //std::cerr << "\tInstr " << i << std::endl;
                General::Instr &currInstr = *currIt;
                std::unordered_set<Ident> kill_i{};
                std::unordered_set<Ident> use_i{};

                if (currInstr.getRes()->print() == "register") {
                    kill_i.insert(currInstr.getRes()->getVal());
                    //std::cerr << "\t\tkill_i: wrzucam " << currInstr.getRes()->getVal() << std::endl;
                }

                for (auto &arg: *currInstr.getArgs()) {
                    if (arg.print() == "register") {
                        use_i.insert(arg.getVal());
                        //std::cerr << "\t\tuse_i: wrzuczam " << arg.getVal() << std::endl;
                    }
                }

                std::unordered_set<Ident> in_i{};
                in_i.insert(outs[blockName][i].begin(), outs[blockName][i].end()); // out[S]
                for (auto &killed: kill_i) { // out[S] - kill[S]
                    if (in_i.find(killed) != in_i.end()) {
                        in_i.erase(killed);
                    }
                }
                in_i.insert(use_i.begin(), use_i.end()); // (out[S] - kill[S]) + use[S]

                ins[blockName][i] = in_i;
                if (i > 0) {
                    outs[blockName][i - 1] = in_i;
                }
                currIt--;
            }
        }

        // Compute outs
        for (auto &b: *blocksMap) {
            Ident blockName = b.first;
            std::unordered_set<Ident> &blockOuts = outs[blockName][outs[blockName].size() - 1];
            blockOuts = std::unordered_set<Ident>();
            for (auto &neigh:  edges_out[blockName]) {
                blockOuts.insert(ins[neigh][0].begin(), ins[neigh][0].end());
            }
        }

        // Check if two consecutive states are different
        bool diff = false;
        int cnt = 0;
        for (auto &b: *blocksMap) {
            Ident blockName = b.first;
            if (ins[blockName][0] != curr_ins[cnt] || outs[blockName][outs[blockName].size() - 1] != curr_outs[cnt]) {
                diff = true;
            }
            cnt++;
        }
        if (!diff) {
            break;
        }
    }
}

Optimizer::Optimizer(General::QuadrupleEnvironment &env) : blocks(env.getBlocks()), blocksMap(env.getBlocksMap()),
                                                           funDefs(env.getFunDefs()), edges_in(), edges_out() {
    for (auto &b: *blocksMap) {
        edges_in[b.first] = std::vector<Ident>();
        edges_out[b.first] = std::vector<Ident>();
    }
}

std::vector<General::QuadrupleBlock *> *Optimizer::getBlocks() {
    return blocks;
}

std::unordered_map<Ident, General::QuadrupleBlock *> *Optimizer::getBlocksMap() {
    return blocksMap;
}

void Optimizer::print() {
    for (auto &b: *blocks) {
        b->print();
        std::cout << std::endl;
    }
}

void Optimizer::setUsedInJump() {
    for (auto &b: *blocks) {
        auto currInstr = std::prev(b->listInstr()->end());
        if (currInstr->getInstrName() == INSTR_IF_NOT_JUMP || currInstr->getInstrName() == INSTR_IF_JUMP) {
            auto lastInstr = currInstr;
            auto condTemp = (*lastInstr->getArgs())[0];
            if (condTemp.print() == "register") {
                bool notFound = false;
                while (lastInstr->getRes()->getVal() != condTemp.getVal()) {
                    if (lastInstr == b->listInstr()->begin()) {
                        notFound = true;
                        break;
                    }
                    lastInstr--;
                }
                if (lastInstr->getInstrName() == INSTR_CALL_RET || lastInstr->getInstrName() == INSTR_PHI ||
                    lastInstr->getOpName() == OP_PARAM || notFound) {
                    continue;
                }
                lastInstr->setUsedInJump();
                currInstr->setSearchForUsedInJump();
            }
        }
    }
}

Ident findVal(Ident tempName, std::unordered_map<Ident, Ident> &constVals) {
    if (constVals[tempName] == "-1") {
        return tempName;
    }
    constVals[tempName] = findVal(constVals[tempName], constVals);
    return constVals[tempName];
}

Ident unionVals(Ident temp1Name, Ident temp2Name, std::unordered_map<Ident, Ident> &constVals) {
    constVals[temp1Name] = temp2Name;
}

bool Optimizer::copyPropagation() {
    std::unordered_map<Ident, Ident> constVals;
    for (auto &b: *blocks) {
        for (auto &instr: *b->listInstr()) {
            if (instr.getOpName() == OP_ASSIGNMENT) {
                auto arg0 = (*instr.getArgs())[0];
                if (arg0.print() == "register") {
                    Ident name1 = instr.getRes()->getVal(), name2 = arg0.getVal();
                    if (constVals.find(name1) == constVals.end()) {
                        constVals[name1] = "-1";
                    }
                    if (constVals.find(name2) == constVals.end()) {
                        constVals[name2] = "-1";
                    }
                    auto par1 = findVal(name1, constVals);
                    auto par2 = findVal(name2, constVals);
                    unionVals(par1, par2, constVals);
                }
            }
        }
    }

    bool changed = false;
    for (auto &b: *blocks) {
        auto currIt = b->listInstr()->begin();
        while (currIt != b->listInstr()->end()) {
            auto &instr = *currIt;
            if (instr.getOpName() == OP_ASSIGNMENT) {
                auto arg0 = (*instr.getArgs())[0];
                if (arg0.print() == "register") {
                    currIt++;
                    b->listInstr()->erase(std::prev(currIt));
                    continue;
                }
            } else {
                auto &args = *instr.getArgs();
                for (auto &arg: args) {
                    if (arg.print() == "register" && constVals.find(arg.getVal()) != constVals.end()) {
                        auto res = constVals[arg.getVal()];
                        if (res != "-1") {
                            arg.changeVal(res);
                            changed = true;
                        }
                    }
                }
            }
            currIt++;
        }
    }
    return changed;
}

bool Optimizer::constPropagation() {
    std::unordered_map<Ident, std::pair<std::string, std::string>> constVals; // (val, className)
    bool changed = false;
    for (auto &b: *blocks) {
        auto instrIt = b->listInstr()->begin();
        while (instrIt != b->listInstr()->end()) {
            auto &instr = *instrIt;
            if (instr.getInstrName() == INSTR_ASSIGNMENT) {
                bool allConst = true;
                for (auto &arg: (*instr.getArgs())) {
                    if (!arg.getIsConst()) {
                        auto argName = arg.getVal();
                        if (constVals.find(argName) != constVals.end()) {
                            auto newVal = constVals[argName];
                            arg.changeVal(newVal.first);
                            arg.changeClassName(newVal.second);
                            arg.setIsConst(true);
                            changed = true;
                        } else {
                            allConst = false;
                        }
                    }
                }

                // If all arguments are const exprs then we can compute output in the compilation phase
                if (allConst) {
                    auto &args = *instr.getArgs();
                    auto opName = instr.getOpName();
                    auto resName = instr.getRes()->getVal();
                    if (opName == OP_ASSIGNMENT) {
                        constVals[resName] = std::make_pair(args[0].getVal(), args[0].print());
                    } else if (opName == OP_TIMES || opName == OP_MINUS || opName == OP_PLUS || opName == OP_DIV ||
                               opName == OP_MOD) {
                        if (opName == OP_PLUS && args[0].print() == "string") {
                            auto val0 = args[0].getVal(), val1 = args[1].getVal();
                            auto res = val0 + val1;
                            constVals[resName] = std::make_pair(General::String(res).getVal(), "string");
                        } else {
                            auto val0 = std::stoi(args[0].getVal()), val1 = std::stoi(args[1].getVal());
                            int res;
                            if (opName == OP_TIMES) {
                                res = val0 * val1;
                            } else if (opName == OP_MINUS) {
                                res = val0 - val1;
                            } else if (opName == OP_PLUS) {
                                res = val0 + val1;
                            } else if (opName == OP_DIV) {
                                res = val0 / val1;
                            } else if (opName == OP_MOD) {
                                res = val0 % val1;
                            }
                            constVals[resName] = std::make_pair(General::Int(res).getVal(), "int");
                        }
                    } else if (opName == OP_NEG) {
                        auto val0 = std::stoi(args[0].getVal());
                        auto res = -val0;
                        constVals[resName] = std::make_pair(General::Int(res).getVal(), "int");
                    } else if (opName == OP_LTH || opName == OP_LE || opName == OP_GTH || opName == OP_GE ||
                               opName == OP_EQU || opName == OP_NE) {
                        auto val0 = std::stoi(args[0].getVal()), val1 = std::stoi(args[1].getVal());
                        bool res;
                        if (opName == OP_LTH) {
                            res = val0 < val1;
                        } else if (opName == OP_LE) {
                            res = val0 <= val1;
                        } else if (opName == OP_GTH) {
                            res = val0 > val1;
                        } else if (opName == OP_GE) {
                            res = val0 >= val1;
                        } else if (opName == OP_EQU) {
                            res = val0 == val1;
                        } else if (opName == OP_NE) {
                            res = val0 != val1;
                        }
                        constVals[resName] = std::make_pair(General::Bool(res).getVal(), "bool");
                    } else if (opName == OP_NOT) {
                        auto val0 = bool(std::stoi(args[0].getVal()));
                        bool res = !val0;
                        constVals[resName] = std::make_pair(General::Bool(res).getVal(), "bool");
                    } else {
                        instrIt++;
                        continue;
                    }
                    instrIt++;
                    b->listInstr()->erase(std::prev(instrIt));
                } else {
                    instrIt++;
                }
            } else {
                instrIt++;
            }
        }
    }

    for (auto &b: *blocks) {
        for (auto &instr: *b->listInstr()) {
            for (auto &arg: (*instr.getArgs())) {
                if (!arg.getIsConst()) {
                    auto argName = arg.getVal();
                    if (constVals.find(argName) != constVals.end()) {
                        auto newVal = constVals[argName];
                        arg.changeVal(newVal.first);
                        arg.changeClassName(newVal.second);
                        arg.setIsConst(true);
                        changed = true;
                    }
                }
            }

            // Remove conditional jump condition's value can be computed in the compilation phase
            if (instr.getInstrName() == INSTR_IF_JUMP || instr.getInstrName() == INSTR_IF_NOT_JUMP) {
                if (!(*instr.getArgs())[0].getIsConst()) {
                    continue;
                }
                auto target = General::String((*instr.getArgs())[1].getVal());
                bool argVal = bool(std::stoi((*instr.getArgs())[0].getVal()));

                bool change = (instr.getInstrName() == INSTR_IF_JUMP && argVal) ||
                              (instr.getInstrName() == INSTR_IF_NOT_JUMP && !argVal);
                b->listInstr()->pop_back();
                if (change) {
                    auto newInstr = General::Instr(INSTR_JUMP, OP_NULL, General::Type(""), argsType{target});
                    b->listInstr()->push_back(newInstr);
                }
                break;
            }
        }
    }
    return changed;
}

std::string getExprHash(General::Instr &instr) {
    // Hash: {op}_{arg0}_{arg1}_..._{argn}
    std::string exprHash = instr.getOpName();
    for (auto &arg: *instr.getArgs()) {
        exprHash += "_" + arg.getVal();
    }
    return exprHash;
}

bool Optimizer::commonSubexpressionElimination() { // both local and global
    std::unordered_map<Ident, std::unordered_map<std::string, int>> blockToExprs; // key = {tempName}_{exprAsString}
    std::unordered_map<Ident, std::unordered_map<Ident, Ident>> tempsToReplace;
    std::unordered_set<Ident> blocksParsed;
    std::unordered_map<Ident, int> blocksInVisited;
    std::queue<Ident> blocksQueue;
    for (auto &block: *blocks) {
        blocksInVisited[block->getLabel()] = 0;
    }

    bool changed = false;
    for (auto &block: *blocks) {
        auto blockLabel = block->getLabel();
        if (blocksParsed.find(blockLabel) == blocksParsed.end()) {
            // Check if all previous blocks have been already visited (or whether it's a loop)
            if ((blocksInVisited[blockLabel] == edges_in[blockLabel].size() ||
                 blockLabel.rfind(".loop_cond_", 0) == 0) &&
                blocksParsed.find(blockLabel) == blocksParsed.end()) {
                blocksQueue.push(blockLabel);
                while (!blocksQueue.empty()) {
                    auto currBlock = blocksQueue.front();
                    blockLabel = currBlock;
                    blocksQueue.pop();
                    if (blocksParsed.find(blockLabel) != blocksParsed.end()) {
                        continue;
                    }
                    blocksParsed.insert(blockLabel);
                    auto edgesIn = edges_in[blockLabel];
                    std::unordered_map<std::string, int> currTempToExpr;
                    std::unordered_map<Ident, Ident> currTempsToReplace;

                    // Collect availables expr from all incoming edges (GCSE)
                    for (auto &blockIn: edgesIn) {
                        auto &blockInExprs = blockToExprs[blockIn];
                        for (auto &tempToExpr: blockInExprs) {
                            currTempToExpr[tempToExpr.first]++;
                        }

                        auto &blockInTempToReplace = tempsToReplace[blockIn];
                        for (auto &tempToTemp: blockInTempToReplace) {
                            currTempsToReplace.insert(tempToTemp);
                        }
                    }

                    // Check if every expression is contained in each branch (GCSE) (or whether it's a loop)
                    auto targetSize = edgesIn.size();
                    std::unordered_map<std::string, int> newMap;
                    std::unordered_map<std::string, Ident> exprToTemp;
                    for (auto &availExpr: currTempToExpr) {
                        if (availExpr.second == targetSize || (blockLabel.rfind(".loop_cond_", 0) == 0) &&
                                                              availExpr.second == targetSize - 1) {
                            newMap.insert(availExpr);
                            auto hash = availExpr.first;
                            size_t identExprSeparator = hash.find('_');
                            auto ident = std::string(hash.begin(), hash.begin() + identExprSeparator);
                            auto expr = std::string(hash.begin() + identExprSeparator + 1, hash.end());
                            exprToTemp[expr] = ident;
                        }
                    }

                    // Iterate over all instructions (LCSE & GCSE)
                    auto &currBlockRef = (*blocksMap)[currBlock];
                    auto instrIt = currBlockRef->listInstr()->begin();
                    while (instrIt != currBlockRef->listInstr()->end()) {
                        auto &instr = *instrIt;

                        // Check if any arg was changed in previous CSE iterations and replace it
                        for (auto &arg: *instr.getArgs()) {
                            if (arg.print() == "register" &&
                                currTempsToReplace.find(arg.getVal()) != currTempsToReplace.end()) {
                                arg.changeVal(currTempsToReplace[arg.getVal()]);
                            }
                        }

                        // Check if expr can be replaced by computing its hash and remove it's instruction
                        if (instr.getInstrName() == INSTR_ASSIGNMENT && instr.getOpName() != OP_PARAM) {
                            auto exprHash = getExprHash(instr);
                            if (exprToTemp.find(exprHash) != exprToTemp.end()) {
                                currTempsToReplace[instr.getRes()->getVal()] = exprToTemp[exprHash];
                                instrIt++;
                                currBlockRef->listInstr()->erase(std::prev(instrIt));
                                changed = true;
                                continue;
                            }
                            if (!instr.isUsedInJump()) {
                                exprToTemp[exprHash] = instr.getRes()->getVal();
                                auto instrHash = instr.getRes()->getVal() + '_' + exprHash;
                                newMap[instrHash] = 1;
                            }
                        }
                        instrIt++;
                    }

                    blockToExprs[currBlock] = newMap;
                    tempsToReplace[currBlock] = currTempsToReplace;

                    for (auto &blockOut: edges_out[blockLabel]) {
                        blocksInVisited[blockOut]++;
                        if (blocksInVisited[blockOut] == edges_in[blockOut].size()) {
                            blocksQueue.push(blockOut);
                        }
                    }
                }
            }
        }
    }
    return changed;
}

void Optimizer::eliminateDeadCode() {

}

void Optimizer::optimize(bool debug) {
    if (debug) {
        std::cout << "Code before optimizations:\n";
        print();
    }

    bool changed = true;
    while (changed) {
        while (changed) {
            changed = false;
            changed |= copyPropagation();
            changed |= constPropagation();
        }
        createGraph();
        setUsedInJump();
        changed |= commonSubexpressionElimination();
    }

    createGraph();

    setUsedInJump();

    eliminatePhi();

    concatBlocks();

    computeDataFlow(); // useless without register allocation

    if (debug) {
        std::cout << "\n\n\n\nCode after optimizations:\n";
        print();
    }
}
