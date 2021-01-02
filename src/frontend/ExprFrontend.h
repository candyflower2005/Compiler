#ifndef LATTE_EXPRFRONTEND_H
#define LATTE_EXPRFRONTEND_H

#include "../grammar/Absyn.H"
#include "../general/types.h"
#include "../general/environment.h"
#include "../general/logger.h"
#include "Frontend.h"

using namespace Latte;

class ExprFrontend : public Frontend {
    General::Type retType;
public:
    General::Type& getRetType();
    ExprFrontend(Visitable *p, General::Environment &env, General::Logger &logger, Ident currTopDef) :
            Frontend(nullptr, env, logger, currTopDef) {
        p->accept(this);
    };

    void visitInt(Int *p);
    void visitStr(Str *p);
    void visitBool(Bool *p);
    void visitVoid(Void *p);

    void visitEVar(EVar *p);
    void visitELitInt(ELitInt *p);
    void visitELitTrue(ELitTrue *p);
    void visitELitFalse(ELitFalse *p);
    void visitEApp(EApp *p);
    void visitEString(EString *p);
    void visitNeg(Neg *p);
    void visitNot(Not *p);
    void visitEMul(EMul *p);
    void visitEAdd(EAdd *p);
    void visitERel(ERel *p);
    void visitEAnd(EAnd *p);
    void visitEOr(EOr *p);

    void visitPlus(Plus *p);
    void visitMinus(Minus *p);
    void visitTimes(Times *p);
    void visitDiv(Div *p);
    void visitMod(Mod *p);
    void visitLTH(LTH *p);
    void visitLE(LE *p);
    void visitGTH(GTH *p);
    void visitGE(GE *p);
    void visitEQU(EQU *p);
    void visitNE(NE *p);
};


#endif //LATTE_EXPRFRONTEND_H
