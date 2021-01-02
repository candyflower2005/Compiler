#include "function_def.h"
#include <algorithm>

funArgsType *FunctionDef::getFunArgs() {
    return &funArgs;
}

bool FunctionDef::argExists(Ident argName) {
    for (auto &arg: funArgs) {
        if (arg.first == argName) {
            return true;
        }
    }
    return false;
}

void FunctionDef::addArg(Ident argName, General::Type argVal) {
    funArgs.push_back(std::make_pair(argName, argVal));
}

General::Type &FunctionDef::getFunType() {
    return funType;
}
