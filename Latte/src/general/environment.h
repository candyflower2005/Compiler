#ifndef LATTE_ENVIRONMENT_H
#define LATTE_ENVIRONMENT_H

#include "types.h"
#include "function_def.h"
#include<map>
#include<vector>
#include<string>
#include <unordered_set>

typedef std::map<Ident, General::Type> varValsType;
typedef std::map<Ident, int> depthsType;

namespace General {
    class Environment {
        std::vector<Ident> used;
        std::map<Ident, FunctionDef *> funDefs;
        varValsType varVals;
        depthsType depths;
        int myDepth;
    public:
        Environment();

        Environment(Environment &env, bool deeper);

        void addFunctionDef(Ident funName, FunctionDef *funDefPtr);

        bool canAdd(Ident varname);

        void addVar(Ident varName, Type varVal);

        General::Type &getVarVal(Ident varName);

        bool exists(Ident varName);

        bool funExists(Ident funName);

        FunctionDef *getFunctionDef(Ident funName);

        std::map<Ident, FunctionDef *> getFunDefs();

        std::unordered_set<Ident> *funsWithError;
    };
}

#endif //LATTE_ENVIRONMENT_H
