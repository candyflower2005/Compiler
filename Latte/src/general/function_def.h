#ifndef LATTE_FUNCTION_DEF_H
#define LATTE_FUNCTION_DEF_H


#include "types.h"

typedef std::vector<std::pair<Ident, General::Type>> funArgsType;

class FunctionDef {
    Latte::Blk *funBody;
    funArgsType funArgs;
    General::Type funType;

public:
    FunctionDef(General::Type funType, Latte::Blk *funBody) : funType(funType), funBody(funBody) {};

    funArgsType *getFunArgs();

    bool argExists(Ident argName);

    void addArg(Ident argName, General::Type argVal);

    General::Type &getFunType();
};


#endif //LATTE_FUNCTION_DEF_H
