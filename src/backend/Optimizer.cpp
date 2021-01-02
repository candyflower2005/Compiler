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
                Ident label1 = phiArgs[0].getVal(), temp1 = phiArgs[1].getVal(), label2 = phiArgs[2].getVal(), temp2 = phiArgs[3].getVal();
                auto instr1 = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, res, argsType{temp1});
                auto instr2 = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, res, argsType{temp2});
                (*blocksMap)[label1]->addInstrBeforeJump(instr1);
                (*blocksMap)[label2]->addInstrBeforeJump(instr2);
            }
        }
        std::vector<General::Instr> &curr = *(b->listInstr());
        std::vector<General::Instr>(curr.begin() + phiCnt, curr.end()).swap(curr);
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
                std::cerr << "(" << blockLabel << ", " << nextBlockLabel << ")" << std::endl;
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
            std::cerr << "(" << blockLabel << ", " << jumpTarget << ")" << std::endl;
            edges_out[blockLabel].push_back(jumpTarget);
            edges_in[jumpTarget].push_back(blockLabel);
        } else if (instrName == INSTR_IF_NOT_JUMP) {
            auto jumpTarget = (*lastInstr->getArgs())[1].getVal();
            edges_out[blockLabel].push_back(jumpTarget);
            edges_in[jumpTarget].push_back(blockLabel);
            std::cerr << "(" << blockLabel << ", " << jumpTarget << ")" << std::endl;

            auto nextBlockLabel = (*nextBlock)->getLabel();
            edges_out[blockLabel].push_back(nextBlockLabel);
            edges_in[nextBlockLabel].push_back(blockLabel);
            std::cerr << "(" << blockLabel << ", " << nextBlockLabel << ")" << std::endl;
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
                std::cerr << "(" << blockLabel << ", " << nextBlockLabel << ")" << std::endl;
            }
        }
    }
}

void Optimizer::concatBlocks() {
    // TODO
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
    }

    while (true) {
        std::cerr << "iteration!" << std::endl;
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
            int numInstr = b.second->listInstr()->size();
            for (int i = numInstr - 1; i >= 0; --i) {
                General::Instr &currInstr = (*b.second->listInstr())[i];
                std::unordered_set<Ident> kill_i{};
                std::unordered_set<Ident> use_i{};

                if (currInstr.getRes()->print() == "register") {
                    kill_i.insert(currInstr.getRes()->getVal());
                }

                for (auto &arg: *currInstr.getArgs()) {
                    if (arg.print() == "register") {
                        use_i.insert(arg.getVal());
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
                    outs[blockName][i-1] = in_i;
                }
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
    // out[B_i] = sum_(B_j=succ)(in[B_j])
}

Optimizer::Optimizer(General::QuadrupleEnvironment &env) : blocks(env.getBlocks()), blocksMap(env.getBlocksMap()),
                                                           funDefs(env.getFunDefs()), edges_in(), edges_out() {
    for (auto &b: *blocksMap) {
        edges_in[b.first] = std::vector<Ident>();
        edges_out[b.first] = std::vector<Ident>();
    }

}

void Optimizer::print() {
    for (auto &b: *blocks) {
        b->print();
        std::cerr << std::endl;
    }
}

void Optimizer::optimize() {
    std::cerr << "\n\n\n\n\nOptimizer:\n" << std::endl;

    std::cerr << "\ncreating graph" << std::endl;
    createGraph();
    std::cerr << "\neliminating phis" << std::endl;
    eliminatePhi();
    std::cerr << "\nconcating blocks" << std::endl;
    concatBlocks();

    std::cerr << "\ncurrent code:" << std::endl;
    print();

    computeDataFlow();
}
