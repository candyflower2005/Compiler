#include <algorithm>
#include "environment.h"
#include "function_def.h"
#include "types.h"


General::Environment::Environment() : funsWithError(new std::unordered_set<Ident>()) {
    used.push_back("printInt");
    used.push_back("printString");
    used.push_back("error");
    used.push_back("readInt");
    used.push_back("readString");

    // we don't have to use these functions in the frontend
    auto printInt = new FunctionDef(Void(), nullptr);
    printInt->addArg("someInteger", Int());

    auto printString = new FunctionDef(Void(), nullptr);
    printString->addArg("someString", String());

    auto error = new FunctionDef(Void(), nullptr);
    auto readInt = new FunctionDef(Int(), nullptr);
    auto readString = new FunctionDef(String(), nullptr);

    addFunctionDef("printInt", printInt);
    addFunctionDef("printString", printString);
    addFunctionDef("error", error);
    addFunctionDef("readInt", readInt);
    addFunctionDef("readString", readString);
}

General::Environment::Environment(Environment &env, bool deeper) : used(env.used), funDefs(env.funDefs),
                                                                   varVals(env.varVals), depths(env.depths),
                                                                   funsWithError(env.funsWithError) {
    myDepth = env.myDepth;
    if (deeper) {
        myDepth++;
    }
}

void General::Environment::addFunctionDef(Ident funName, FunctionDef *funDefPtr) {
    funDefs[funName] = funDefPtr;
    used.push_back(funName);
}

bool General::Environment::canAdd(Ident varname) {
    auto varDepth = depths.find(varname);
    if (varDepth == depths.end()) {
        return true;
    }
    if (depths[varname] == myDepth) {
        return false;
    }
    return true;
}

void General::Environment::addVar(Ident varName, Type varVal) {
    varVal.setIsConst(false);
    varVals[varName] = varVal;
    depths[varName] = myDepth;
}

General::Type &General::Environment::getVarVal(Ident varName) {
    return varVals[varName];
}

bool General::Environment::exists(Ident varName) {
    return varVals.find(varName) != varVals.end();
}

bool General::Environment::funExists(Ident funName) {
    return std::find(used.begin(), used.end(), funName) != used.end();
}

FunctionDef *General::Environment::getFunctionDef(Ident funName) {
    return funDefs[funName];
}

std::map<Ident, FunctionDef *> General::Environment::getFunDefs() {
    return funDefs;
}
