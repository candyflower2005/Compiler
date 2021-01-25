#include "AssemblyCodeGenerator.h"

void allocateRegisters() {

}

void AssemblyCodeGenerator::handleRet(General::Instr &currInstr, std::vector<std::string> &assInstr, int &firstFree) {
    if (!currInstr.getArgs()->empty()) {
        if ((*currInstr.getArgs())[0].print() == "int" && (*currInstr.getArgs())[0].getVal() == "0") {
            assInstr.emplace_back("xor %eax, %eax");
        } else {
            if ((*currInstr.getArgs())[0].print() == "int") {
                assInstr.emplace_back("movl $" + (*currInstr.getArgs())[0].getVal() + ",  %eax");
            }
            if ((*currInstr.getArgs())[0].print() == "bool") {
                assInstr.emplace_back("movl $" + (*currInstr.getArgs())[0].getVal() + ",  %eax");
            }
            if ((*currInstr.getArgs())[0].print() == "string") {
                stringRegs.insert((*currInstr.getArgs())[0].getVal());
                auto newStr = "$str" + std::to_string(strCount);
                tempToString[newStr] = (*currInstr.getArgs())[0].getVal();
                assInstr.emplace_back("movl " + newStr + ", %eax");
                strCount++;
            }
            if ((*currInstr.getArgs())[0].print() == "register") {
                assInstr.emplace_back("movl " + tempToStack[(*currInstr.getArgs())[0].getVal()] + ",  %eax");
            }
        }
    }
    assInstr.emplace_back("movl  %ebp, %esp");
    assInstr.emplace_back("pop %ebp");
    assInstr.emplace_back("ret");
}

void AssemblyCodeGenerator::handleCall(General::Instr &currInstr, std::vector<std::string> &assInstr, int &firstFree) {
    std::vector<General::Type> &args = *currInstr.getArgs();
    int numArgs = args.size(), size = 0;
    for (int i = numArgs - 1; i > 0; --i) {
        if (args[i].print() == "register") {
            assInstr.emplace_back("push " + tempToStack[args[i].getVal()]);
        }
        if (args[i].print() == "string") {
            auto newStr = "$str" + std::to_string(strCount);
            tempToString[newStr] = args[i].getVal();
            assInstr.emplace_back("push " + newStr);
            strCount++;
        }
        if (args[i].print() == "int") {
            assInstr.emplace_back("push $" + args[i].getVal());
        }
        if (args[i].print() == "bool") {
            assInstr.emplace_back("push $" + args[i].getVal());
        }
        size += 4;
    }

    assInstr.emplace_back("call fun_" + args[0].getVal());
    if (size > 0) {
        assInstr.emplace_back("add $" + std::to_string(size) + ", %esp");
    }

    if (currInstr.getInstrName() == INSTR_CALL_RET) {
        auto newAddr = "-" + std::to_string(firstFree) + "(%ebp)";
        tempToStack[currInstr.getRes()->getVal()] = newAddr;
        assInstr.emplace_back("movl %eax, " + newAddr);
        firstFree += 4;

        if (funDefs[args[0].getVal()]->getFunType().print() == "string") {
            stringRegs.insert(currInstr.getRes()->getVal());
        }
    }
}

void AssemblyCodeGenerator::handleJump(General::Instr &currInstr, General::Instr &lastInstr,
                                       std::vector<std::string> &assInstr, int &firstFree) {
    if (currInstr.getInstrName() == INSTR_JUMP) {
        assInstr.emplace_back("jmp " + (*currInstr.getArgs())[0].getVal());
        return;
    }

    auto target = (*currInstr.getArgs())[1].getVal();

    if (&currInstr == &lastInstr) {
        auto jumpVal = (*currInstr.getArgs())[0];
        auto t1 = tempToStack[jumpVal.getVal()];

        assInstr.emplace_back("movl " + t1 + ", %eax");
        assInstr.emplace_back("cmpl $1, %eax");
        if (currInstr.getInstrName() == INSTR_IF_NOT_JUMP) {
            assInstr.emplace_back("jne " + target);
        }
        if (currInstr.getInstrName() == INSTR_IF_JUMP) {
            assInstr.emplace_back("je " + target);
        }
        return;
    }

    auto jumpVal = (*lastInstr.getArgs())[0];
    auto t1 = tempToStack[jumpVal.getVal()];

    if (jumpVal.print() == "bool" || jumpVal.print() == "int") {
        t1 = "$" + jumpVal.getVal();
    }

    assInstr.emplace_back("movl " + t1 + ", %eax");
    if (lastInstr.getOpName() == OP_ASSIGNMENT) {
        assInstr.emplace_back("cmp $1, %eax");
        if (currInstr.getInstrName() == INSTR_IF_NOT_JUMP) {
            assInstr.emplace_back("jne " + target);
        }
        if (currInstr.getInstrName() == INSTR_IF_JUMP) {
            assInstr.emplace_back("je " + target);
        }
        return;
    }
    if (lastInstr.getOpName() == OP_NOT) {
        assInstr.emplace_back("cmp $0, %eax");
        if (currInstr.getInstrName() == INSTR_IF_NOT_JUMP) {
            assInstr.emplace_back("jne " + target);
        }
        if (currInstr.getInstrName() == INSTR_IF_JUMP) {
            assInstr.emplace_back("je " + target);
        }
        return;
    }

    auto secondJumpVal =  (*lastInstr.getArgs())[1];
    auto t2 = tempToStack[secondJumpVal.getVal()];

    if (secondJumpVal.print() == "bool" || secondJumpVal.print() == "int") {
        t2 = "$" + secondJumpVal.getVal();
    }
    assInstr.emplace_back("movl " + t2 + ", %ebx");

    assInstr.emplace_back("cmpl %ebx, %eax");
    if (lastInstr.getOpName() == OP_EQU) {
        if (currInstr.getInstrName() == INSTR_IF_NOT_JUMP) {
            assInstr.emplace_back("jne " + target);
        }
        if (currInstr.getInstrName() == INSTR_IF_JUMP) {
            assInstr.emplace_back("je " + target);
        }
    }
    if (lastInstr.getOpName() == OP_NE) {
        if (currInstr.getInstrName() == INSTR_IF_NOT_JUMP) {
            assInstr.emplace_back("je " + target);
        }
        if (currInstr.getInstrName() == INSTR_IF_JUMP) {
            assInstr.emplace_back("jne " + target);
        }
    }
    if (lastInstr.getOpName() == OP_GE) {
        if (currInstr.getInstrName() == INSTR_IF_NOT_JUMP) {
            assInstr.emplace_back("jl " + target);
        }
        if (currInstr.getInstrName() == INSTR_IF_JUMP) {
            assInstr.emplace_back("jge " + target);
        }
    }
    if (lastInstr.getOpName() == OP_GTH) {
        if (currInstr.getInstrName() == INSTR_IF_NOT_JUMP) {
            assInstr.emplace_back("jle " + target);
        }
        if (currInstr.getInstrName() == INSTR_IF_JUMP) {
            assInstr.emplace_back("jg " + target);
        }
    }
    if (lastInstr.getOpName() == OP_LE) {
        if (currInstr.getInstrName() == INSTR_IF_NOT_JUMP) {
            assInstr.emplace_back("jg " + target);
        }
        if (currInstr.getInstrName() == INSTR_IF_JUMP) {
            assInstr.emplace_back("jle " + target);
        }
    }
    if (lastInstr.getOpName() == OP_LTH) {
        if (currInstr.getInstrName() == INSTR_IF_NOT_JUMP) {
            assInstr.emplace_back("jge " + target);
        }
        if (currInstr.getInstrName() == INSTR_IF_JUMP) {
            assInstr.emplace_back("jl " + target);
        }
    }
}

void AssemblyCodeGenerator::handleAss(General::Instr &currInstr, std::vector<std::string> &assInstr, int &firstFree) {
    auto &args = *currInstr.getArgs();
    auto &arg0 = args[0];

    if (arg0.print() == "int") {
        assInstr.emplace_back("movl $" + arg0.getVal() + ", %eax");
    }
    if (arg0.print() == "bool") {
        assInstr.emplace_back("movl $" + arg0.getVal() + ", %eax");
    }
    if (arg0.print() == "string") {
        stringRegs.insert(currInstr.getRes()->getVal());

        auto newStr = "$str" + std::to_string(strCount);
        tempToString[newStr] = arg0.getVal();
        assInstr.emplace_back("movl " + newStr + ", %eax");
        strCount++;
    }
    if (arg0.print() == "register") {
        assInstr.emplace_back("movl " + tempToStack[arg0.getVal()] + ", %eax");
    }
    if (stringRegs.find(arg0.getVal()) != stringRegs.end()) {
        stringRegs.insert(currInstr.getRes()->getVal());
    }

    if (args.size() == 1) {
        if (currInstr.getOpName() == OP_NEG) {
            assInstr.emplace_back("neg %eax");
        }
        if (currInstr.getOpName() == OP_NOT) {
            assInstr.emplace_back("xor $1, %eax");
        }
        if (tempToStack.find(currInstr.getRes()->getVal()) != tempToStack.end()) {
            auto addr = tempToStack[currInstr.getRes()->getVal()];
            assInstr.emplace_back("movl %eax, " + addr);
            return;
        }
        auto newAddr = "-" + std::to_string(firstFree) + "(%ebp)";
        tempToStack[currInstr.getRes()->getVal()] = newAddr;
        assInstr.emplace_back("movl %eax, " + newAddr);
        firstFree += 4;
        return;
    }

    auto &arg1 = args[1];
    if (arg1.print() == "int") {
        assInstr.emplace_back("movl $" + arg1.getVal() + ", %ebx");
    }
    if (arg1.print() == "bool") {
        assInstr.emplace_back("movl $" + arg1.getVal() + ", %ebx");
    }
    if (arg1.print() == "string") {
        auto newStr = "$str" + std::to_string(strCount);
        tempToString[newStr] = arg1.getVal();
        assInstr.emplace_back("movl " + newStr + ", %ebx");
        strCount++;
    }
    if (arg1.print() == "register") {
        assInstr.emplace_back("movl " + tempToStack[arg1.getVal()] + ", %ebx");
    }

    if (currInstr.getOpName() == OP_EQU) {
        assInstr.emplace_back("xor %ecx, %ecx");
        assInstr.emplace_back("cmp %ebx, %eax");
        assInstr.emplace_back("sete %cl");
        assInstr.emplace_back("mov %ecx, %eax");
    }
    if (currInstr.getOpName() == OP_NE) {
        assInstr.emplace_back("xor %ecx, %ecx");
        assInstr.emplace_back("cmp %ebx, %eax");
        assInstr.emplace_back("setne %cl");
        assInstr.emplace_back("mov %ecx, %eax");
    }
    if (currInstr.getOpName() == OP_GTH) {
        assInstr.emplace_back("xor %ecx, %ecx");
        assInstr.emplace_back("cmp %ebx, %eax");
        assInstr.emplace_back("setg %cl");
        assInstr.emplace_back("mov %ecx, %eax");
    }
    if (currInstr.getOpName() == OP_GE) {
        assInstr.emplace_back("xor %ecx, %ecx");
        assInstr.emplace_back("cmp %ebx, %eax");
        assInstr.emplace_back("setge %cl");
        assInstr.emplace_back("mov %ecx, %eax");
    }
    if (currInstr.getOpName() == OP_LTH) {
        assInstr.emplace_back("xor %ecx, %ecx");
        assInstr.emplace_back("cmp %ebx, %eax");
        assInstr.emplace_back("setl %cl");
        assInstr.emplace_back("mov %ecx, %eax");
    }
    if (currInstr.getOpName() == OP_LE) {
        assInstr.emplace_back("xor %ecx, %ecx");
        assInstr.emplace_back("cmp %ebx, %eax");
        assInstr.emplace_back("setle %cl");
        assInstr.emplace_back("mov %ecx, %eax");
    }
    if (currInstr.getOpName() == OP_PLUS) {
        if (stringRegs.find(arg0.getVal()) != stringRegs.end()) {
            assInstr.emplace_back("push %ebx");
            assInstr.emplace_back("push %eax");
            assInstr.emplace_back("call fun_concatStrings");
            assInstr.emplace_back("add $8, %esp");
            stringRegs.insert(currInstr.getRes()->getVal());

            auto newAddr = "-" + std::to_string(firstFree) + "(%ebp)";
            tempToStack[currInstr.getRes()->getVal()] = newAddr;
            assInstr.emplace_back("movl %eax, " + newAddr);
            firstFree += 4;
            return;
        }
        assInstr.emplace_back("add %ebx, %eax");
    }
    if (currInstr.getOpName() == OP_MINUS) {
        assInstr.emplace_back("sub %ebx, %eax");
    }
    if (currInstr.getOpName() == OP_TIMES) {
        assInstr.emplace_back("imul %ebx, %eax");
    }
    if (currInstr.getOpName() == OP_DIV) {
        auto newStr = "$zeroDivMsg";
        tempToString[newStr] = "can't divide by 0";

        assInstr.emplace_back("cmp $0, %ebx");
        assInstr.emplace_back("jne after_div_" + std::to_string(afterDiv));
        assInstr.emplace_back("push $zeroDivMsg");
        assInstr.emplace_back("call fun_runTimeError");
        assInstr.emplace_back("after_div_" + std::to_string(afterDiv) + ":");
        afterDiv++;
        assInstr.emplace_back("cdq");
        assInstr.emplace_back("idiv %ebx");
    }
    if (currInstr.getOpName() == OP_MOD) {
        assInstr.emplace_back("cdq");
        assInstr.emplace_back("idiv %ebx");
        assInstr.emplace_back("movl %edx, %eax");
    }

    if (tempToStack.find(currInstr.getRes()->getVal()) != tempToStack.end()) {
        auto addr = tempToStack[currInstr.getRes()->getVal()];
        assInstr.emplace_back("movl %eax, " + addr);
        return;
    }

    auto newAddr = "-" + std::to_string(firstFree) + "(%ebp)";
    tempToStack[currInstr.getRes()->getVal()] = newAddr;
    assInstr.emplace_back("movl %eax, " + newAddr);
    firstFree += 4;
}

std::vector<std::string>
AssemblyCodeGenerator::generateFunCode(std::vector<General::QuadrupleBlock *>::iterator &blockIt,
                                       std::vector<General::QuadrupleBlock *>::iterator endIt) {
    std::vector<std::string> rest;

    auto &b = *blockIt;
    auto funLabel = b->getLabel();
    auto instrIt = b->listInstr()->begin();

    int numParams = 0;
    while (instrIt != b->listInstr()->end() && instrIt->getOpName() == OP_PARAM) {
        numParams++;
        tempToStack[instrIt->getRes()->getVal()] = std::to_string(4 + 4 * numParams) + "(%ebp)";
        instrIt++;
    }

    int firstFree = 4; // tempToStack[tempName] = "ebp - firstFree"; firstFree += 4;

    while (blockIt != endIt) {
        if (b->getLabel().rfind("fun", 0) != 0) {
            rest.emplace_back(b->getLabel() + ":");
        }
        for (instrIt = b->listInstr()->begin(); instrIt != b->listInstr()->end(); ++instrIt) {
            if (instrIt->getInstrName() == INSTR_RETURN) {
                handleRet(*instrIt, rest, firstFree);
            }
            if (instrIt->getInstrName() == INSTR_CALL_NO_RET || instrIt->getInstrName() == INSTR_CALL_RET) {
                handleCall(*instrIt, rest, firstFree);
            }
            if (instrIt->getInstrName() == INSTR_JUMP || instrIt->getInstrName() == INSTR_IF_NOT_JUMP ||
                instrIt->getInstrName() == INSTR_IF_JUMP) {
                auto lastInstr = instrIt;
                if ((instrIt->getInstrName() == INSTR_IF_NOT_JUMP || instrIt->getInstrName() == INSTR_IF_JUMP) &&
                    lastInstr != b->listInstr()->begin()) {
                    if (instrIt->isSearchForUsedInJump()) {
                        while (!lastInstr->isUsedInJump()) {
                            lastInstr--;
                        }
                    }
                }
                handleJump(*instrIt, *lastInstr, rest, firstFree);
            }
            if (instrIt->getInstrName() == INSTR_ASSIGNMENT) {
                if (instrIt->isUsedInJump() || instrIt->getOpName() == OP_PARAM) {
                    //std::cerr << instrIt->getRes()->getVal() << " jest used in jump " << std::endl;
                    continue;
                }
                handleAss(*instrIt, rest, firstFree);
            }
        }
        blockIt++;
        if (blockIt != endIt) {
            b = *blockIt;
            if (b->getLabel().rfind("fun", 0) == 0) {
                break;
            }
        }
    }

    std::vector<std::string> out;

    if (funLabel == "fun_main") {
        out.emplace_back("main:");
    } else {
        out.emplace_back(funLabel + ":");
    }

    out.emplace_back("push %ebp");
    out.emplace_back("movl %esp, %ebp");
    out.emplace_back("subl $" + std::to_string(firstFree - 4) + ", %esp");
    out.insert(out.end(), rest.begin(), rest.end());

    return out;
}

std::string AssemblyCodeGenerator::generateCode() {
    auto blockIt = blocks->begin();
    std::string out;

    while (blockIt != blocks->end()) {
        auto funOut = generateFunCode(blockIt, blocks->end());
        for (auto &line: funOut) {
            if (line[line.size() - 1] == ':') {
                out += "\n" + line + "\n";
            } else {
                out += "\t" + line + "\n";
            }
        }
    }

    std::string data = ".data\n";

    for (auto &tempString: tempToString) {
        auto temp = std::string(tempString.first.begin() + 1, tempString.first.end());
        auto string = tempString.second;
        data += temp + ": .string \"" + string + "\"\n";
    }

    if (!tempToString.empty()) {
        return data + "\n.globl main\n" + out;
    }
    return ".globl main\n" + out;
}
