#ifndef LATTE_QUADRUPLEGENERATOR_H
#define LATTE_QUADRUPLEGENERATOR_H

#include "../grammar/Absyn.H"
#include "../general/quadruple_environment.h"
#include "../general/types.h"

using namespace Latte;

class QuadrupleGenerator : public Visitor {
    General::QuadrupleEnvironment &env;
    General::QuadrupleBlock *currBlock;
    bool dontCreateNewBlock = false;

public:
    QuadrupleGenerator(Visitable *p, General::QuadrupleEnvironment &env,
                       General::QuadrupleBlock *newBlock) :
            env(env), currBlock(newBlock) {
        dontCreateNewBlock = true;
        p->accept(this);
    }

    QuadrupleGenerator(Visitable *p, General::QuadrupleEnvironment &env) : env(env), currBlock() {
        p->accept(this);
    }

    void visitProgram(Program *p);

    void visitTopDef(TopDef *p);

    void visitArg(Arg *p);

    void visitBlock(Block *p);

    void visitStmt(Stmt *p);

    void visitItem(Item *p);

    void visitType(Type *p);

    void visitExpr(Expr *p);

    void visitAddOp(AddOp *p);

    void visitMulOp(MulOp *p);

    void visitRelOp(RelOp *p);

    void visitProg(Prog *p);

    void visitFnDef(FnDef *p);

    void visitAr(Ar *p);

    void visitBlk(Blk *p);

    void visitEmpty(Empty *p);

    void visitBStmt(BStmt *p);

    void visitDecl(Decl *p);

    void visitNoInit(NoInit *p);

    void visitInit(Init *p);

    void visitAss(Ass *p);

    void visitIncr(Incr *p);

    void visitDecr(Decr *p);

    void visitRet(Ret *p);

    void visitVRet(VRet *p);

    void visitCond(Cond *p);

    void visitCondElse(CondElse *p);

    void visitWhile(While *p);

    void visitSExp(SExp *p);

    void visitInt(Int *p);

    void visitStr(Str *p);

    void visitBool(Bool *p);

    void visitVoid(Void *p);

    void visitFun(Fun *p);

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

    void visitListTopDef(ListTopDef *p);

    void visitListArg(ListArg *p);

    void visitListStmt(ListStmt *p);

    void visitListItem(ListItem *p);

    void visitListType(ListType *p);

    void visitListExpr(ListExpr *p);

    void visitInteger(Integer x);

    void visitChar(Char x);

    void visitDouble(Double x);

    void visitString(String x);

    void visitIdent(Ident x);
};


#endif //LATTE_QUADRUPLEGENERATOR_H
