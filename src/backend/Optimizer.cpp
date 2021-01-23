#include <unordered_set>
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
                        constVals[name2] ="-1";
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
            }
            else {
                auto &args = *instr.getArgs();
                for (auto &arg: args) {
                    if (arg.print() == "register" && constVals.find(arg.getVal()) != constVals.end()) {
                        auto res = constVals[arg.getVal()];
                        if (res != "-1") {
                            std::cerr << arg.getVal() << " -> " << res << std::endl;
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
    return false;
}

bool Optimizer::commonSubexpressionElimination() {
    return false;
}

void Optimizer::optimize() {
    std::cerr << "\n\n\n\n\nOptimizer:\n" << std::endl;
    print();

    bool changed = true;
    while (changed) {
        changed = false;
        changed |= copyPropagation();
        changed |= constPropagation();
        changed |= commonSubexpressionElimination();
    }

    print();

    //std::cerr << "\ncreating graph" << std::endl;
    createGraph();
    //print();
    //std::cerr << "\neliminating phis" << std::endl;
    eliminatePhi();
    //print();

    //std::cerr << "\ncurrent code:" << std::endl;

    //std::cerr << "\n\n\nconcating blocks" << std::endl;
    concatBlocks();

    //std::cerr << "\n\n\n\nafter concat:" << std::endl;
    //print();
    computeDataFlow();
}
