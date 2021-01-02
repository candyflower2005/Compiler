#include "ExprFrontend.h"

General::Type &ExprFrontend::getRetType() {
    return retType;
}

void ExprFrontend::visitInt(Int *p) {
    retType = General::Int();
}

void ExprFrontend::visitStr(Str *p) {
    retType = General::String();
}

void ExprFrontend::visitBool(Bool *p) {
    retType = General::Bool();
}

void ExprFrontend::visitVoid(Void *p) {
    retType = General::Void();
}

void ExprFrontend::visitEVar(EVar *p) {
    int lineNumber = p->line_number;
    Ident varName = p->ident_;
    if (!env.exists(varName)) {
        logger.logError(lineNumber, "undeclared variable '" + varName + "' used");
    }
    retType = env.getVarVal(varName);
}

void ExprFrontend::visitELitInt(ELitInt *p) {
    retType = General::Int(p->integer_);
}

void ExprFrontend::visitELitTrue(ELitTrue *p) {
    retType = General::Bool(true);
}

void ExprFrontend::visitELitFalse(ELitFalse *p) {
    retType = General::Bool(false);
}

void ExprFrontend::visitEApp(EApp *p) {
    int lineNumber = p->line_number;
    Ident funName = p->ident_;

    if (funName == "main") {
        logger.logError(lineNumber, "can't call function 'main'");
    }

    if (!env.funExists(funName)) {
        logger.logError(lineNumber, "Call to an undeclared function '" + funName + "'");
    }

    auto currFun = env.getFunctionDef(funName);
    funArgsType *funArgs = currFun->getFunArgs();

    auto listExpr = p->listexpr_; // can't access line number in visitListExpr
    if (funArgs->size() != listExpr->size()) {
        logger.logError(lineNumber, "function '" + funName + "' got " + std::to_string(listExpr->size()) +
                                    " arguments, expected " + std::to_string(funArgs->size()));
    }

    auto callArg = listExpr->begin();
    auto funArg = funArgs->begin();
    while (callArg != listExpr->end()) {
        ExprFrontend currCallArg(*callArg, env, logger, currTopDef);
        if (!currCallArg.getRetType().same(funArg->second)) {
            Ident argName = funArg->first;
            logger.logError(lineNumber, "'" + argName + "' is of type " + funArg->second.print() +
                                        ", got type " + currCallArg.getRetType().print());
        }
        callArg++;
        funArg++;
    }
    retType = currFun->getFunType();
}

void ExprFrontend::visitEString(EString *p) {
    retType = General::String(p->string_);
}

void ExprFrontend::visitNeg(Neg *p) {
    int lineNumber = p->line_number;
    ExprFrontend exprFrontend(p->expr_, env, logger, currTopDef);
    auto intType = General::Int();
    if (!exprFrontend.getRetType().same(intType)) {
        logger.logError(lineNumber, "not an integer");
    }

    if (exprFrontend.getRetType().getIsConst()) {
        auto val = std::stoi(exprFrontend.getRetType().getVal());
        retType = General::Int(-val);
        return;
    }
    retType = General::Int();
}

void ExprFrontend::visitNot(Not *p) {
    int lineNumber = p->line_number;
    ExprFrontend exprFrontend(p->expr_, env, logger, currTopDef);
    auto boolType = General::Bool();
    if (!exprFrontend.getRetType().same(boolType)) {
        logger.logError(lineNumber, "not a boolean expression");
    }

    if (exprFrontend.getRetType().getIsConst()) {
        auto val = bool(std::stoi(exprFrontend.getRetType().getVal()));
        retType = General::Bool(!val);
        return;
    }
    retType = General::Bool();
}

void ExprFrontend::visitEMul(EMul *p) {
    int lineNumber = p->line_number;
    ExprFrontend expr1Frontend(p->expr_1, env, logger, currTopDef);
    ExprFrontend expr2Frontend(p->expr_2, env, logger, currTopDef);
    ExprFrontend mulFrontend(p->mulop_, env, logger, currTopDef);
    auto expr1Type = expr1Frontend.getRetType(), expr2Type = expr2Frontend.getRetType(), mulExprType = mulFrontend.getRetType();
    auto intType = General::Int();
    if (!expr1Type.same(intType)) {
        logger.logError(lineNumber, "first expression is not an integer");
    }
    if (!expr2Type.same(intType)) {
        logger.logError(lineNumber, "second expression is not an integer");
    }

    if (expr1Type.getIsConst() && expr2Type.getIsConst()) {
        auto val1 = std::stoi(expr1Frontend.getRetType().getVal());
        auto val2 = std::stoi(expr2Frontend.getRetType().getVal());
        if (mulExprType.print() == "times") {
            retType = General::Int(val1 * val2);
        } else if (mulExprType.print() == "div") {
            retType = General::Int(val1 / val2);
        } else if (mulExprType.print() == "mod") {
            retType = General::Int(val1 % val2);
        }
        return;
    }
    retType = General::Int();
}

void ExprFrontend::visitEAdd(EAdd *p) {
    int lineNumber = p->line_number;
    ExprFrontend expr1Frontend(p->expr_1, env, logger, currTopDef);
    ExprFrontend expr2Frontend(p->expr_2, env, logger, currTopDef);
    ExprFrontend addFrontend(p->addop_, env, logger, currTopDef);
    auto expr1Type = expr1Frontend.getRetType(), expr2Type = expr2Frontend.getRetType(), addlExprType = addFrontend.getRetType();
    auto intType = General::Int();
    auto strType = General::String();
    if (!(
            (expr1Type.same(intType) && expr2Type.same(intType)) ||
            (expr1Type.same(strType) && expr2Type.same(strType) && !(addlExprType.print() != "plus"))
    )) {
        logger.logError(lineNumber, "wrong types of expression's arguments");
    }

    if (expr1Type.getIsConst() && expr2Type.getIsConst()) {
        if (expr1Type.same(strType)) {
            auto val1 = expr1Frontend.getRetType().getVal();
            auto val2 = expr2Frontend.getRetType().getVal();
            retType = General::String(val1 + val2);
        } else {
            auto val1 = std::stoi(expr1Frontend.getRetType().getVal());
            auto val2 = std::stoi(expr2Frontend.getRetType().getVal());
            if (addlExprType.print() == "plus") {
                retType = General::Int(val1 + val2);
            } else if (addlExprType.print() == "minus") {
                retType = General::Int(val2 - val2);
            }
        }
        return;
    }

    if (expr1Type.same(intType)) {
        retType = General::Int();
    } else {
        retType = General::String();
    }
}

void ExprFrontend::visitERel(ERel *p) {
    int lineNumber = p->line_number;
    ExprFrontend expr1Frontend(p->expr_1, env, logger, currTopDef);
    ExprFrontend expr2Frontend(p->expr_2, env, logger, currTopDef);
    ExprFrontend relFrontend(p->relop_, env, logger, currTopDef);
    auto expr1Type = expr1Frontend.getRetType(), expr2Type = expr2Frontend.getRetType(), relExprType = relFrontend.getRetType();
    auto intType = General::Int();
    auto strType = General::String();
    auto boolType = General::Bool();
    if (!(
            (expr1Type.same(intType) && expr2Type.same(intType)) ||
            (expr1Type.same(strType) && expr2Type.same(strType) && relExprType.print() == "equ") ||
            (expr1Type.same(strType) && expr2Type.same(strType) && relExprType.print() == "ne") ||
            (expr1Type.same(boolType) && expr2Type.same(boolType) && relExprType.print() == "equ") ||
            (expr1Type.same(boolType) && expr2Type.same(boolType) && relExprType.print() == "ne")
    )) {
        logger.logError(lineNumber, "can't apply '" + relExprType.print() + "' to variables of types " +
                                    expr1Type.print() + " and " + expr2Type.print());
    }

    if (expr1Type.getIsConst() && expr2Type.getIsConst() && expr1Type.same(intType)) {
        auto val1 = std::stoi(expr1Frontend.getRetType().getVal());
        auto val2 = std::stoi(expr2Frontend.getRetType().getVal());
        if (relExprType.print() == "lth") {
            retType = General::Bool(val1 < val2);
        } else if (relExprType.print() == "le") {
            retType = General::Bool(val1 <= val2);
        } else if (relExprType.print() == "gth") {
            retType = General::Bool(val1 > val2);
        } else if (relExprType.print() == "ge") {
            retType = General::Bool(val1 >= val2);
        } else if (relExprType.print() == "equ") {
            retType = General::Bool(val1 == val2);
        } else if (relExprType.print() == "ne") {
            retType = General::Bool(val1 != val2);
        }
        return;
    }
    if (expr1Type.getIsConst() && expr2Type.getIsConst() && expr1Type.same(strType)) {
        auto val1 = expr1Frontend.getRetType().getVal();
        auto val2 = expr2Frontend.getRetType().getVal();
        if (relExprType.print() == "equ") {
            retType = General::Bool(val1 == val2);
        } else if (relExprType.print() == "ne") {
            retType = General::Bool(val1 != val2);
        }
        return;
    }
    if (expr1Type.getIsConst() && expr2Type.getIsConst() && expr1Type.same(boolType)) {
        auto val1 = bool(std::stoi(expr1Frontend.getRetType().getVal()));
        auto val2 = bool(std::stoi(expr2Frontend.getRetType().getVal()));
        if (relExprType.print() == "equ") {
            retType = General::Bool(val1 == val2);
        } else if (relExprType.print() == "ne") {
            retType = General::Bool(val1 != val2);
        }
        return;
    }
    retType = General::Bool();
}

void ExprFrontend::visitEAnd(EAnd *p) {
    int lineNumber = p->line_number;
    ExprFrontend expr1Frontend(p->expr_1, env, logger, currTopDef);
    ExprFrontend expr2Frontend(p->expr_2, env, logger, currTopDef);
    auto expr1Type = expr1Frontend.getRetType(), expr2Type = expr2Frontend.getRetType();
    auto boolType = General::Bool();
    if (!expr1Type.same(boolType)) {
        logger.logError(lineNumber, "not a boolean expression");
    }
    if (!expr2Type.same(boolType)) {
        logger.logError(lineNumber, "not a boolean expression");
    }

    if (expr1Type.getIsConst() && expr2Type.getIsConst()) {
        auto val1 = bool(std::stoi(expr1Type.getVal()));
        auto val2 = bool(std::stoi(expr2Type.getVal()));
        retType = General::Bool(val1 && val2);
        return;
    }
    retType = General::Bool();
}

void ExprFrontend::visitEOr(EOr *p) {
    int lineNumber = p->line_number;
    ExprFrontend expr1Frontend(p->expr_1, env, logger, currTopDef);
    ExprFrontend expr2Frontend(p->expr_2, env, logger, currTopDef);
    auto expr1Type = expr1Frontend.getRetType(), expr2Type = expr2Frontend.getRetType();
    auto boolType = General::Bool();
    if (!expr1Type.same(boolType)) {
        logger.logError(lineNumber, "not a boolean expression");
    }
    if (!expr2Type.same(boolType)) {
        logger.logError(lineNumber, "not a boolean expression");
    }

    if (expr1Type.getIsConst() && expr2Type.getIsConst()) {
        auto val1 = bool(std::stoi(expr1Type.getVal()));
        auto val2 = bool(std::stoi(expr2Type.getVal()));
        retType = General::Bool(val1 || val2);
        return;
    }
    retType = General::Bool();
}

void ExprFrontend::visitPlus(Plus *p) {
    retType = General::Plus();
}

void ExprFrontend::visitMinus(Minus *p) {
    retType = General::Minus();
}

void ExprFrontend::visitTimes(Times *p) {
    retType = General::Times();
}

void ExprFrontend::visitDiv(Div *p) {
    retType = General::Div();
}

void ExprFrontend::visitMod(Mod *p) {
    retType = General::Mod();
}

void ExprFrontend::visitLTH(LTH *p) {
    retType = General::LTH();
}

void ExprFrontend::visitLE(LE *p) {
    retType = General::LE();
}

void ExprFrontend::visitGTH(GTH *p) {
    retType = General::GTH();
}

void ExprFrontend::visitGE(GE *p) {
    retType = General::GE();
}

void ExprFrontend::visitEQU(EQU *p) {
    retType = General::EQU();
}

void ExprFrontend::visitNE(NE *p) {
    retType = General::NE();
}
