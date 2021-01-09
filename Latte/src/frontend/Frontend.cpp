#include "Frontend.h"
#include "TopDefFrontend.h"
#include "DeclFrontend.h"
#include "ExprFrontend.h"


void Frontend::visitProgram(Program *p) {}

void Frontend::visitProg(Prog *p) {
    p->listtopdef_->accept(this);
    int lineNumber = p->line_number;
    if (!env.funExists("main")) {
        logger.logError(lineNumber, "program must have 'main' function");
    }
}

void Frontend::visitListTopDef(ListTopDef *p) {
    // First pass: update environment
    for (ListTopDef::iterator i = p->begin(); i != p->end(); ++i) {
        TopDefFrontend topDefFrontend(*i, env, logger);
    }

    // Second pass: check correctness
    for (ListTopDef::iterator i = p->begin(); i != p->end(); ++i) {
        (*i)->accept(this);
    }
}

void Frontend::visitTopDef(TopDef *p) {}

void Frontend::visitFnDef(FnDef *p) {
    int lineNumber = p->line_number;
    Ident funName = p->ident_;

    // second pass for block parsing
    General::Environment localEnv(env, true);

    auto funDef = localEnv.getFunctionDef(funName);
    auto funArgs = funDef->getFunArgs();
    for (auto &arg: *funArgs) {
        Ident varName = arg.first;
        General::Type varType = arg.second;
        localEnv.addVar(varName, varType);
    }

    Frontend parseFunBlock(p->block_, localEnv, logger, funName);

    auto funType = funDef->getFunType().print();
    if (parseFunBlock.ret == CANT_RETURN && funType != "void" &&
        env.funsWithError->find(currTopDef) == env.funsWithError->end()) {
        logger.logError(lineNumber, "function '" + funName + "' must return " + funType);
    }
}

void Frontend::visitListArg(ListArg *p) {}

void Frontend::visitArg(Arg *p) {}

void Frontend::visitAr(Ar *p) {}

void Frontend::visitBlock(Block *p) {}

void Frontend::visitBlk(Blk *p) {
    p->liststmt_->accept(this);
}

void Frontend::visitListStmt(ListStmt *p) {
    for (ListStmt::iterator i = p->begin(); i != p->end(); ++i) {
        if (ret == MUST_RETURN) {
            logger.logError((*i)->line_number, "code is unreachable");
        }
        Frontend parseStmt(*i, env, logger, currTopDef);
        if (parseStmt.ret != CANT_RETURN) {
            ret = parseStmt.ret;
        }
    }
}

void Frontend::visitStmt(Stmt *p) {}

void Frontend::visitBStmt(BStmt *p) {
    int lineNumber = p->line_number;
    if (ret == MUST_RETURN) {
        logger.logError(lineNumber, "code is unreachable");
    }
    General::Environment localEnv(env, true);
    Frontend parseBlockStmt(p->block_, localEnv, logger, currTopDef);
    if (ret == CANT_RETURN && parseBlockStmt.ret == MUST_RETURN) {
        ret = MUST_RETURN;
    } else if (parseBlockStmt.ret != CANT_RETURN) {
        ret = MIGHT_RETURN;
    }
}

void Frontend::visitDecl(Decl *p) {
    int lineNumber = p->line_number;
    if (ret == MUST_RETURN) {
        logger.logError(lineNumber, "code is unreachable");
    }
    ExprFrontend typeFrontend(p->type_, env, logger, currTopDef);
    auto declType = typeFrontend.getRetType();
    if (declType.print() == "void") {
        logger.logError(lineNumber, "can't declare variable of type void");
    }
    DeclFrontend declFrontend(p->listitem_, env, logger, declType, currTopDef);
}

void Frontend::visitListItem(ListItem *p) {}

void Frontend::visitItem(Item *p) {}

void Frontend::visitNoInit(NoInit *p) {}

void Frontend::visitInit(Init *p) {}

void Frontend::visitAss(Ass *p) {
    int lineNumber = p->line_number;
    if (ret == MUST_RETURN) {
        logger.logError(lineNumber, "code is unreachable");
    }
    Ident varName = p->ident_;
    if (!env.exists(varName)) {
        logger.logError(lineNumber, "variable '" + varName + "' is undeclared");
    }

    auto varType = env.getVarVal(varName);
    ExprFrontend exprFrontend(p->expr_, env, logger, currTopDef);
    auto exprType = exprFrontend.getRetType();

    if (!varType.same(exprType)) {
        logger.logError(lineNumber, "can't assign " + exprType.print() + " to " + varType.print());
    }
}

void Frontend::visitIncr(Incr *p) {
    int lineNumber = p->line_number;
    if (ret == MUST_RETURN) {
        logger.logError(lineNumber, "code is unreachable");
    }
    Ident varName = p->ident_;
    if (!env.exists(varName)) {
        logger.logError(lineNumber, "variable '" + varName + "' undeclared");
    }
    auto intType = General::Int();
    auto varVal = env.getVarVal(varName);
    if (!varVal.same(intType)) {
        logger.logError(lineNumber, "variable '" + varName + "' is not an integer");
    }

    if (varVal.getIsConst()) {
        int val = std::stoi(varVal.getVal());
        auto newVar = General::Int(++val);
        env.addVar(varName, newVar);
    }
}

void Frontend::visitDecr(Decr *p) {
    int lineNumber = p->line_number;
    if (ret == MUST_RETURN) {
        logger.logError(lineNumber, "code is unreachable");
    }
    Ident varName = p->ident_;
    if (!env.exists(varName)) {
        logger.logError(lineNumber, "variable '" + varName + "' undeclared");
    }
    auto intType = General::Int();
    auto varVal = env.getVarVal(varName);
    if (!varVal.same(intType)) {
        logger.logError(lineNumber, "variable '" + varName + "' is not an integer");
    }

    if (varVal.getIsConst()) {
        int val = std::stoi(varVal.getVal());
        auto newVar = General::Int(--val);
        env.addVar(varName, newVar);
    }
}

void Frontend::visitRet(Ret *p) {
    int lineNumber = p->line_number;
    if (ret == MUST_RETURN) {
        logger.logError(lineNumber, "code is unreachable");
    }
    ExprFrontend exprFrontend(p->expr_, env, logger, currTopDef);
    auto exprType = exprFrontend.getRetType();
    auto currFunType = env.getFunctionDef(currTopDef)->getFunType();
    if (!exprType.same(currFunType)) {
        logger.logError(lineNumber, "function '" + currTopDef + "' should return " + currFunType.print() +
                                    " instead of " + exprType.print());
    }
    if (ret == CANT_RETURN) {
        ret = MUST_RETURN;
    }
}

void Frontend::visitVRet(VRet *p) {
    int lineNumber = p->line_number;
    if (ret == MUST_RETURN) {
        logger.logError(lineNumber, "code is unreachable");
    }
    auto currFunType = env.getFunctionDef(currTopDef)->getFunType();
    auto voidType = General::Void();
    if (!voidType.same(currFunType)) {
        logger.logError(lineNumber, "function '" + currTopDef + "' should return " + currFunType.print() +
                                    " instead of void");
    }
    if (ret == CANT_RETURN) {
        ret = MUST_RETURN;
    }
}

void Frontend::visitCond(Cond *p) {
    int lineNumber = p->line_number;
    if (ret == MUST_RETURN) {
        logger.logError(lineNumber, "code is unreachable");
    }
    ExprFrontend exprFrontend(p->expr_, env, logger, currTopDef);
    auto boolType = General::Bool();
    if (!exprFrontend.getRetType().same(boolType)) {
        logger.logError(lineNumber, "not a bool expression");
    }

    General::Environment localEnv(env, true);
    Frontend ifFrontend(p->stmt_, localEnv, logger, currTopDef);

    bool isConst = exprFrontend.getRetType().getIsConst();
    if (!isConst) {
        if (ifFrontend.ret != CANT_RETURN) {
            ret = MIGHT_RETURN;
        }
        return;
    }

    auto val = bool(std::stoi(exprFrontend.getRetType().getVal()));
    if (!val) {
        logger.logWarning(lineNumber, "condition never satisfied");
        return;
    }
    if (val) {
        logger.logWarning(lineNumber, "condition always satisfied");
        if (ifFrontend.ret != CANT_RETURN) {
            if (ret != MUST_RETURN) {
                ret = ifFrontend.ret;
            }
        }
    }
}

void Frontend::visitCondElse(CondElse *p) {
    int lineNumber = p->line_number;
    if (ret == MUST_RETURN) {
        logger.logError(lineNumber, "code is unreachable");
    }
    ExprFrontend exprFrontend(p->expr_, env, logger, currTopDef);
    auto boolType = General::Bool();
    if (!exprFrontend.getRetType().same(boolType)) {
        logger.logError(lineNumber, "not a bool expression");
    }

    General::Environment localEnv1(env, true);
    Frontend ifTrueFrontend(p->stmt_1, localEnv1, logger, currTopDef);

    General::Environment localEnv2(env, true);
    Frontend ifFalseFrontend(p->stmt_2, localEnv2, logger, currTopDef);

    bool isConst = exprFrontend.getRetType().getIsConst();
    if (!isConst) {
        if (ifTrueFrontend.ret != CANT_RETURN || ifFalseFrontend.ret != CANT_RETURN) {
            ret = MIGHT_RETURN;
        }
        return;
    }

    auto val = bool(std::stoi(exprFrontend.getRetType().getVal()));

    if (!val) {
        logger.logWarning(lineNumber, "condition never satisfied");
        if (ifFalseFrontend.ret != CANT_RETURN) {
            if (ret != MUST_RETURN) {
                ret = ifFalseFrontend.ret;
            }
        }
    }
    if (val) {
        logger.logWarning(lineNumber, "condition always satisfied");
        if (ifTrueFrontend.ret != CANT_RETURN) {
            if (ret != MUST_RETURN) {
                ret = ifTrueFrontend.ret;
            }
        }
    }
}

void Frontend::visitWhile(While *p) {
    int lineNumber = p->line_number;
    if (ret == MUST_RETURN) {
        logger.logError(lineNumber, "code is unreachable");
    }
    ExprFrontend exprFrontend(p->expr_, env, logger, currTopDef);

    auto boolType = General::Bool();
    if (!exprFrontend.getRetType().same(boolType)) {
        logger.logError(lineNumber, "not a bool expression");
    }

    General::Environment localEnv(env, true);
    Frontend whileFrontend(p->stmt_, localEnv, logger, currTopDef);

    bool isConst = exprFrontend.getRetType().getIsConst();
    if (!isConst) {
        if (whileFrontend.ret != CANT_RETURN) {
            ret = MIGHT_RETURN;
        }
        return;
    }

    auto val = bool(std::stoi(exprFrontend.getRetType().getVal()));
    if (!val) {
        logger.logWarning(lineNumber, "condition never satisfied");
    }
    if (val) {
        if (whileFrontend.ret == CANT_RETURN) {
            logger.logError(lineNumber, "infinite loop");
        }
        if (whileFrontend.ret != CANT_RETURN) {
            if (ret != MUST_RETURN) {
                ret = whileFrontend.ret;
            }
        }
    }
}

void Frontend::visitSExp(SExp *p) {
    int lineNumber = p->line_number;
    if (ret == MUST_RETURN) {
        logger.logError(lineNumber, "code is unreachable");
    }
    ExprFrontend exprFrontend(p->expr_, env, logger, currTopDef);
}

void Frontend::visitListExpr(ListExpr *p) {}

void Frontend::visitType(Type *p) {}

void Frontend::visitInt(Int *p) {}

void Frontend::visitStr(Str *p) {}

void Frontend::visitBool(Bool *p) {}

void Frontend::visitVoid(Void *p) {}

void Frontend::visitExpr(Expr *p) {}

void Frontend::visitFun(Fun *p) {} // useless?

void Frontend::visitAddOp(AddOp *p) {}

void Frontend::visitMulOp(MulOp *p) {}

void Frontend::visitRelOp(RelOp *p) {}

void Frontend::visitEmpty(Empty *p) {}

void Frontend::visitEVar(EVar *p) {}

void Frontend::visitELitInt(ELitInt *p) {}

void Frontend::visitELitTrue(ELitTrue *p) {}

void Frontend::visitELitFalse(ELitFalse *p) {}

void Frontend::visitEApp(EApp *p) {}

void Frontend::visitEString(EString *p) {}

void Frontend::visitNeg(Neg *p) {}

void Frontend::visitNot(Not *p) {}

void Frontend::visitEMul(EMul *p) {}

void Frontend::visitEAdd(EAdd *p) {}

void Frontend::visitERel(ERel *p) {}

void Frontend::visitEAnd(EAnd *p) {}

void Frontend::visitEOr(EOr *p) {}

void Frontend::visitPlus(Plus *p) {}

void Frontend::visitMinus(Minus *p) {}

void Frontend::visitTimes(Times *p) {}

void Frontend::visitDiv(Div *p) {}

void Frontend::visitMod(Mod *p) {}

void Frontend::visitLTH(LTH *p) {}

void Frontend::visitLE(LE *p) {}

void Frontend::visitGTH(GTH *p) {}

void Frontend::visitGE(GE *p) {}

void Frontend::visitEQU(EQU *p) {}

void Frontend::visitNE(NE *p) {}

void Frontend::visitListType(ListType *p) {}

void Frontend::visitInteger(Integer x) {}

void Frontend::visitChar(Char x) {}

void Frontend::visitDouble(Double x) {}

void Frontend::visitString(String x) {}

void Frontend::visitIdent(Ident x) {}
