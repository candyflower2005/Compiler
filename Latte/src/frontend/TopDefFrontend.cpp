#include "TopDefFrontend.h"
#include "ExprFrontend.h"
#include <iostream>

void TopDefFrontend::visitFnDef(FnDef *p) {
    Ident funName = p->ident_;
    currTopDef = funName;
    int lineNumber = p->line_number;

    ExprFrontend typeFrontend(p->type_, env, logger, currTopDef);
    auto funType = typeFrontend.getRetType();
    auto funBody = (Latte::Blk *) p->block_;

    if (funName == "main" && funType.print() != "int") {
        logger.logError(lineNumber, "main must be of type int");
    }

    if (env.funExists(funName) || env.exists(funName)) {
        logger.logError(lineNumber, "function's name '" + funName + "' already used");
    }
    auto funDef = new FunctionDef(funType, funBody);
    env.addFunctionDef(funName, funDef);

    currTopDef = funName;
    p->listarg_->accept(this);
}

void TopDefFrontend::visitListArg(ListArg *p) {
    for (ListArg::iterator i = p->begin(); i != p->end(); ++i) {
        (*i)->accept(this);
    }
}

void TopDefFrontend::visitAr(Ar *p) {
    Ident argName = p->ident_;
    ExprFrontend typeFrontend(p->type_, env, logger, currTopDef);
    auto argType = typeFrontend.getRetType();
    int lineNumber = p->line_number;

    if (currTopDef == "main") {
        logger.logError(lineNumber,  "main can't take any arguments");
    }

    if (argType.print() == "void") {
        logger.logError(lineNumber, "function's argument can't be of type void");
    }

    if (env.funExists(argName)) {
        logger.logError(lineNumber, "function " + currTopDef + " uses reserved identifier");
    }

    auto funDef = env.getFunctionDef(currTopDef);
    if (funDef->argExists(argName)) {
        logger.logError(lineNumber, "function " + currTopDef + " has two arguments with the same name");
    }
    funDef->addArg(argName, argType);
}
