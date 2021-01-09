#include "types.h"
#include <iostream>

using namespace General;

bool Type::same(Type &otherType) {
    return className == otherType.className;
}

void Type::changeVal(std::string newVal) {
    val = newVal;
}

std::string &Type::print() {
    return className;
}

bool Type::getIsConst() {
    return isConst;
}

void Type::setIsConst(bool newVal) {
    isConst = newVal;
}

std::string &Type::getVal() {
    return val;
}

Int::Int() {
    className = "int";
}

Int::Int(int val) : Type(std::to_string(val)) {
    className = "int";
    isConst = true;
}

Bool::Bool() {
    className = "bool";
}

Bool::Bool(bool val) : Type(std::to_string(int(val))) {
    className = "bool";
    isConst = true;
}

String::String() {
    className = "string";
}

String::String(Ident val) : Type(val) {
    className = "string";
    isConst = true;
}

Void::Void() : Type() {
    className = "void";
    isConst = true;
}

Register::Register(Ident val) : Type(val) {
    className = "register";
}

Plus::Plus() {
    className = "plus";
}

Minus::Minus() {
    className = "minus";
}

Times::Times() {
    className = "times";
}

Div::Div() {
    className = "div";
}

Mod::Mod() {
    className = "mod";
}

LTH::LTH() {
    className = "lth";
}

LE::LE() {
    className = "le";
}

GTH::GTH() {
    className = "gth";
}

GE::GE() {
    className = "ge";
}

EQU::EQU() {
    className = "equ";
}

NE::NE() {
    className = "ne";
}

AND::AND() {
    className = "and";
}

OR::OR() {
    className = "or";
}

void QuadrupleBlock::addInstr(Instr singleInstr, bool start) {
    if (start) {
        std::vector<General::Instr> newInstr;
        newInstr.push_back(singleInstr);
        newInstr.insert(newInstr.end(), instr.begin(), instr.end());
        instr = newInstr;
        return;
    }
    instr.push_back(singleInstr);
}

void Instr::print() {
    if (instrName == INSTR_ASSIGNMENT) {
        if (opName == OP_ASSIGNMENT) {
            std::cout << "\t" << result.getVal() + " = " + args[0].getVal() << std::endl;
        } else if (opName == OP_NOT || opName == OP_NEG) {
            std::cout << "\t" << result.getVal() + " = " + opName + args[0].getVal() << std::endl;
        } else if (opName == OP_PARAM) {
            std::cout << "\t" << result.getVal() + " = param " << args[0].getVal() << std::endl;
        } else {
            std::cout << "\t" << result.getVal() + " = " + args[0].getVal() + " " + opName + " " + args[1].getVal()
                      << std::endl;
        }
    } else if (instrName == INSTR_PHI) {
        std::cout << "\t" << result.getVal() + " = phi(";
        for (auto it = args.begin(); it != args.end(); it += 2) {
            if (it != args.begin()) {
                std::cout << ", ";
            }
            std::cout << it->getVal() << ":" << (it + 1)->getVal();
        }
        std::cout << ")" << std::endl;
    } else if (instrName == INSTR_CALL_RET) {
        std::cout << "\t" << result.getVal() << " = call " + args[0].getVal() + "(";
        for (size_t i = 1; i < args.size(); i++) {
            if (i > 1) {
                std::cout << ", ";
            }
            std::cout << args[i].getVal();
        }
        std::cout << ")" << std::endl;
    } else if (instrName == INSTR_CALL_NO_RET) {
        std::cout << "\tcall " + args[0].getVal() + "(";
        for (size_t i = 1; i < args.size(); i++) {
            if (i > 1) {
                std::cout << ", ";
            }
            std::cout << args[i].getVal();
        }
        std::cout << ")" << std::endl;
    } else if (instrName == INSTR_RETURN) {
        std::cout << "\treturn";
        if (!args.empty()) {
            std::cout << " " + args[0].getVal();
        }
        std::cout << std::endl;
    } else if (instrName == INSTR_JUMP) {
        std::cout << "\tjump " + args[0].getVal() << std::endl;
    } else if (instrName == INSTR_IF_NOT_JUMP) {
        std::cout << "\tif !" + args[0].getVal() + " then jump " + args[1].getVal() << std::endl;
    } else if (instrName == INSTR_IF_JUMP) {
        std::cout << "\tif " + args[0].getVal() + " then jump " + args[1].getVal() << std::endl;
    } else {
        std::cout << "error" << std::endl;
    }
}

void QuadrupleBlock::print() {
    std::cout << label + ":" << std::endl;
    for (size_t i = 0; i < instr.size(); i++) {
        instr[i].print();
    }
}

Ident QuadrupleBlock::getLabel() {
    return label;
}

std::vector<Instr> *QuadrupleBlock::listInstr() {
    return &instr;
}

std::string &Instr::getInstrName() {
    return instrName;
}

std::string &Instr::getOpName() {
    return opName;
}

std::vector<Type> *Instr::getArgs() {
    return &args;
}

Type *Instr::getRes() {
    return &result;
}

bool Instr::setUsedInJump(bool used) {
    usedInJump = used;
}

bool Instr::isUsedInJump() {
    return usedInJump;
}

void QuadrupleBlock::addInstrBeforeJump(Instr singleInstr) {
    auto lastInstr = *std::prev(instr.end());
    if (lastInstr.getInstrName() == INSTR_RETURN ||
        lastInstr.getInstrName() == INSTR_JUMP ||
        lastInstr.getInstrName() == INSTR_IF_NOT_JUMP ||
        lastInstr.getInstrName() == INSTR_IF_JUMP ||
        (lastInstr.getInstrName() == INSTR_CALL_NO_RET &&
         std::prev(lastInstr.getArgs()->end())->getVal() == RUN_TIME_ERROR)) {
        instr.pop_back();
        instr.push_back(singleInstr);
        instr.push_back(lastInstr);
    } else {
        instr.push_back(singleInstr);
    }
}
