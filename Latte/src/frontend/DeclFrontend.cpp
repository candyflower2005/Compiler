#include "DeclFrontend.h"
#include "ExprFrontend.h"

void DeclFrontend::visitListItem(ListItem *list_item) {
    for (ListItem::iterator i = list_item->begin(); i != list_item->end(); ++i) {
        (*i)->accept(this);
    }
}

void DeclFrontend::visitNoInit(NoInit *p) {
    Ident varName = p->ident_;
    int lineNumber = p->line_number;

    if (env.funExists(varName)) {
        logger.logError(lineNumber, "variable's name '" + varName + "' already used");
    }
    if (!env.canAdd(varName)) {
        logger.logError(lineNumber, "variable '" + varName + "' can't be redefined in this scope");
    }
    env.addVar(varName, type);
}

void DeclFrontend::visitInit(Init *p) {
    Ident varName = p->ident_;
    int lineNumber = p->line_number;

    if (env.funExists(varName)) {
        logger.logError(lineNumber, "variable's name '" + varName + "' already used");
    }
    if (!env.canAdd(varName)) {
        logger.logError(lineNumber, "variable '" + varName + "' can't be redefined in this scope");
    }

    ExprFrontend exprFrontend(p->expr_, env, logger, currTopDef);
    if (!type.same(exprFrontend.getRetType())) {
        logger.logError(lineNumber, "can't assign " + exprFrontend.getRetType().print() + " to " + type.print());
    }
    env.addVar(varName, exprFrontend.getRetType());
}