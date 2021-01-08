#include "QuadrupleGenerator.h"
#include <iostream>

void QuadrupleGenerator::visitProgram(Program *p) {}

void QuadrupleGenerator::visitProg(Prog *p) {
    p->listtopdef_->accept(this);
}

void QuadrupleGenerator::visitListTopDef(ListTopDef *p) {
    for (auto &i : *p) {
        General::QuadrupleEnvironment localEnv(env);
        QuadrupleGenerator newQGen(i, localEnv);
    }
}

void QuadrupleGenerator::visitTopDef(TopDef *p) {}

void QuadrupleGenerator::visitFnDef(FnDef *p) {
    auto funLabel = env.getFunBlockLabel(p->ident_);
    auto newFunBlock = new General::QuadrupleBlock(General::FUN_DEF, funLabel);

    env.addNewBlock(funLabel, newFunBlock);
    currBlock = newFunBlock;

    auto funDef = env.getFunDefs()[p->ident_];
    for (size_t i = 0; i < funDef->getFunArgs()->size(); ++i) {
        auto newLoc = General::QuadrupleEnvironment::getNewLoc();
        auto newTemp = env.getFreshTemp();
        auto varName = (*funDef->getFunArgs())[i].first;

        env.setNewVarAddress(varName, newLoc);
        env.setNewVarValue(newLoc, newTemp);

        auto res = General::Register(newTemp);
        auto instr = General::Instr(INSTR_ASSIGNMENT, OP_PARAM, res, argsType{General::Int(i + 1)});
        currBlock->addInstr(instr);
    }

    p->block_->accept(this);
}

void QuadrupleGenerator::visitListArg(ListArg *p) {}

void QuadrupleGenerator::visitArg(Arg *p) {}

void QuadrupleGenerator::visitAr(Ar *p) {}

void QuadrupleGenerator::visitBlock(Block *p) {}

void QuadrupleGenerator::visitBlk(Blk *p) {
    p->liststmt_->accept(this);
}

void QuadrupleGenerator::visitListStmt(ListStmt *p) {
    for (auto &i : *p) {
        std::cerr << "current line: " << i->line_number << std::endl;
        i->accept(this);
    }
}

void QuadrupleGenerator::visitStmt(Stmt *p) {}

void QuadrupleGenerator::visitBStmt(BStmt *p) {
    if (!dontCreateNewBlock) {
        auto newBStmtBlockLabel = env.getFreshLabel();
        auto newBStmtBlock = new General::QuadrupleBlock(General::NORMAL, newBStmtBlockLabel);

        env.addNewBlock(newBStmtBlockLabel, newBStmtBlock);
        General::QuadrupleEnvironment localEnv(env);
        QuadrupleGenerator newQGen(p->block_, localEnv, newBStmtBlock);

        auto newBlockLabel = env.getFreshLabel();
        auto newCurrBlock = new General::QuadrupleBlock(General::NORMAL, newBlockLabel);
        env.addNewBlock(newBlockLabel, newCurrBlock);
        currBlock = newCurrBlock;

        Ident lastBlockLabel = newQGen.currBlock->getLabel();
        env.generatePhiInstr(newBlockLabel, localEnv, lastBlockLabel, localEnv, lastBlockLabel, newBlockLabel);
    } else {
        QuadrupleGenerator newQGen(p->block_, env, currBlock);
    }
}

void QuadrupleGenerator::visitDecl(Decl *p) {
    p->type_->accept(this);
    p->listitem_->accept(this);
}

void QuadrupleGenerator::visitType(Type *p) {}

void QuadrupleGenerator::visitInt(Int *p) {
    env.addTempVarType(General::Int(0));
}

void QuadrupleGenerator::visitStr(Str *p) {
    env.addTempVarType(General::String(""));
}

void QuadrupleGenerator::visitBool(Bool *p) {
    env.addTempVarType(General::Bool(false));
}

void QuadrupleGenerator::visitVoid(Void *p) {}

void QuadrupleGenerator::visitListItem(ListItem *p) {
    for (auto &i : *p) {
        i->accept(this);
    }
}

void QuadrupleGenerator::visitItem(Item *p) {}

void QuadrupleGenerator::visitNoInit(NoInit *p) {
    /*
        jeśli jest definicja postaci x = expr, to:
            newTemp = expr.eval()
            newLoc = env.getNewLoc()
            varAddresses[x] = newLoc
            varValues[newLoc] = newTemp
     */

    auto newLoc = General::QuadrupleEnvironment::getNewLoc();
    auto newTemp = env.getFreshTemp();
    auto exprVal = env.getTempVarType();

    env.setNewVarAddress(p->ident_, newLoc);
    env.setNewVarValue(newLoc, newTemp);

    auto res = General::Register(newTemp);
    auto instr = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, res, argsType{exprVal});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitInit(Init *p) {
    auto newLoc = General::QuadrupleEnvironment::getNewLoc();
    auto newTemp = env.getFreshTemp();
    p->expr_->accept(this);
    auto exprVal = env.getRecentRegister();

    env.setNewVarAddress(p->ident_, newLoc);
    env.setNewVarValue(newLoc, newTemp);

    auto res = General::Register(newTemp);
    auto instr = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, res, argsType{exprVal});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitAss(Ass *p) {
    /*
        jeśli jest assignment postaci x = expr, to:
            newTemp = expr.eval()
            varLoc = varAddresses[x]
            varValues[varLoc] = newTemp
     */
    auto varLoc = env.getVarAddress(p->ident_);
    auto newTemp = env.getFreshTemp();
    p->expr_->accept(this);
    auto exprVal = env.getRecentRegister();

    env.setNewVarValue(varLoc, newTemp);

    auto res = General::Register(newTemp);
    auto instr = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, res, argsType{exprVal});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitIncr(Incr *p) {
    auto varLoc = env.getVarAddress(p->ident_);
    auto newTemp = env.getFreshTemp();
    auto varVal = General::Register(env.getVarValue(varLoc));
    auto one = General::Int(1);

    env.setNewVarValue(varLoc, newTemp);

    auto res = General::Register(newTemp);
    auto instr = General::Instr(INSTR_ASSIGNMENT, OP_PLUS, res, argsType{varVal, one});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitDecr(Decr *p) {
    auto varLoc = env.getVarAddress(p->ident_);
    auto newTemp = env.getFreshTemp();
    auto varVal = General::Register(env.getVarValue(varLoc));
    auto one = General::Int(1);

    env.setNewVarValue(varLoc, newTemp);

    auto res = General::Register(newTemp);
    auto instr = General::Instr(INSTR_ASSIGNMENT, OP_MINUS, res, argsType{varVal, one});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitRet(Ret *p) {
    p->expr_->accept(this);
    auto instr = General::Instr(INSTR_RETURN, OP_NULL, General::Type(""), argsType{env.getRecentRegister()});
    currBlock->addInstr(instr);

    currBlock = new General::QuadrupleBlock(General::NORMAL, env.getFreshLabel());
    // TODO new block might be needed to avoid adding unnecessary jump?
}

void QuadrupleGenerator::visitVRet(VRet *p) {
    auto instr = General::Instr(INSTR_RETURN, OP_NULL, General::Type(""), argsType{});
    currBlock->addInstr(instr);

    currBlock = new General::QuadrupleBlock(General::NORMAL, env.getFreshLabel());
    // TODO new block might be needed to avoid adding unnecessary jump?
}

void QuadrupleGenerator::visitCond(Cond *p) {
    auto currLabel = currBlock->getLabel();
    auto condLabel = env.getFreshLabel("if_body"), afterCondLabel = env.getFreshLabel("after_cond");
    auto newCondBlock = new General::QuadrupleBlock(General::NORMAL, condLabel);
    auto newAfterCondBlock = new General::QuadrupleBlock(General::NORMAL, afterCondLabel);

    // If cond
    p->expr_->accept(this);
    auto &lastInstr = (*currBlock->listInstr())[currBlock->listInstr()->size() - 1];
    lastInstr.setUsedInJump(true);

    auto jumpTarget = General::String(afterCondLabel);
    auto jump = General::Instr(INSTR_IF_NOT_JUMP, OP_NULL, General::Type(""),
                               argsType{env.getRecentRegister(), jumpTarget});
    currBlock->addInstr(jump);

    // If body
    env.addNewBlock(condLabel, newCondBlock);
    General::QuadrupleEnvironment localEnv(env);
    QuadrupleGenerator newQGen(p->stmt_, localEnv, newCondBlock);

    env.addNewBlock(afterCondLabel, newAfterCondBlock);
    currBlock = newAfterCondBlock;

    Ident lastCondBlockLabel = newQGen.currBlock->getLabel();
    env.generatePhiInstr(afterCondLabel, localEnv, lastCondBlockLabel, env, currLabel, afterCondLabel);
}

void QuadrupleGenerator::visitCondElse(CondElse *p) {
    auto condLabel = env.getFreshLabel("if_body"), elseCondLabel = env.getFreshLabel(
            "else_body"), afterCondLabel = env.getFreshLabel("after_cond");
    auto newCondBlock = new General::QuadrupleBlock(General::NORMAL, condLabel);
    auto newElseCondBlock = new General::QuadrupleBlock(General::NORMAL, elseCondLabel);
    auto newAfterCondBlock = new General::QuadrupleBlock(General::NORMAL, afterCondLabel);

    // Cond
    p->expr_->accept(this);
    auto &lastInstr = (*currBlock->listInstr())[currBlock->listInstr()->size() - 1];
    lastInstr.setUsedInJump(true);
    auto condJumpTarget = General::String(elseCondLabel);
    auto condJump = General::Instr(INSTR_IF_NOT_JUMP, OP_NULL, General::Type(""),
                                   argsType{env.getRecentRegister(), condJumpTarget});
    currBlock->addInstr(condJump);

    // If body
    env.addNewBlock(condLabel, newCondBlock);
    General::QuadrupleEnvironment localEnv1(env);
    QuadrupleGenerator newQGen1(p->stmt_1, localEnv1, newCondBlock);

    // Else body
    env.addNewBlock(elseCondLabel, newElseCondBlock);
    General::QuadrupleEnvironment localEnv2(env);
    QuadrupleGenerator newQGen2(p->stmt_2, localEnv2, newElseCondBlock);

    auto condBodyJumpTarget = General::String(afterCondLabel);
    auto condBodyJump = General::Instr(INSTR_JUMP, OP_NULL, General::Type(""), argsType{condBodyJumpTarget});
    newQGen1.currBlock->addInstr(condBodyJump);

    env.addNewBlock(afterCondLabel, newAfterCondBlock);
    currBlock = newAfterCondBlock;

    Ident lastCondBlockLabel = newQGen1.currBlock->getLabel();
    Ident lastElseBlockLabel = newQGen2.currBlock->getLabel();
    env.generatePhiInstr(afterCondLabel, localEnv1, lastCondBlockLabel, localEnv2, lastElseBlockLabel, afterCondLabel);
}

void QuadrupleGenerator::visitWhile(While *p) {
    auto currLabel = currBlock->getLabel();
    auto condLabel = env.getFreshLabel("loop_cond"), whileBodyLabel = env.getFreshLabel(
            "loop_body"), afterWhileLabel = env.getFreshLabel("after_loop");
    auto newCondBlock = new General::QuadrupleBlock(General::LOOP, condLabel);
    //currBlock->addJump(General::Jump(newCondBlock));
    auto newWhileBlock = new General::QuadrupleBlock(General::NORMAL, whileBodyLabel);
    auto newAfterWhileBlock = new General::QuadrupleBlock(General::NORMAL, afterWhileLabel);

    // Loop cond
    env.addNewBlock(condLabel, newCondBlock);
    QuadrupleGenerator newCondQGen(p->expr_, env, newCondBlock);
    auto &lastInstr = (*newCondQGen.currBlock->listInstr())[newCondQGen.currBlock->listInstr()->size() - 1];
    lastInstr.setUsedInJump(true);
    auto condJumpTarget = General::String(afterWhileLabel);
    auto condJump = General::Instr(INSTR_IF_NOT_JUMP, OP_NULL, General::Type(""),
                                   argsType{env.getRecentRegister(), condJumpTarget});
    newCondQGen.currBlock->addInstr(condJump);

    // Loop body
    env.addNewBlock(whileBodyLabel, newWhileBlock);
    General::QuadrupleEnvironment localEnv(env);
    QuadrupleGenerator newBodyQGen(p->stmt_, localEnv, newWhileBlock);
    auto bodyJumpTarget = General::String(condLabel);
    auto bodyJump = General::Instr(INSTR_JUMP, OP_NULL, General::Type(""),
                                   argsType{bodyJumpTarget});
    newBodyQGen.currBlock->addInstr(bodyJump);

    env.addNewBlock(afterWhileLabel, newAfterWhileBlock);
    currBlock = newAfterWhileBlock;

    Ident lastBodyBlockLabel = newBodyQGen.currBlock->getLabel();
    env.generatePhiInstr(condLabel, localEnv, lastBodyBlockLabel, env, currLabel, whileBodyLabel);
    env.generatePhiInstr(afterWhileLabel, localEnv, lastBodyBlockLabel, env, condLabel, afterWhileLabel);
}

// TODO usunąć trywialne phi (takie, które odnoszą się do swojego bloku i zmienna nie zmienia się)

void QuadrupleGenerator::visitSExp(SExp *p) {
    p->expr_->accept(this);
}

void QuadrupleGenerator::visitExpr(Expr *p) {}

void QuadrupleGenerator::visitEApp(EApp *p) {
    argsType args{General::String(p->ident_)};

    for (auto &i : *p->listexpr_) {
        i->accept(this);
        args.push_back(env.getRecentRegister());
    }

    auto funDef = env.getFunctionDef(p->ident_);

    if (funDef->getFunType().print() == "void") {
        auto funCallInstr = General::Instr(INSTR_CALL_NO_RET, OP_NULL, General::Type(""), args);
        currBlock->addInstr(funCallInstr);
    } else {
        auto res = General::Register(env.getFreshTemp());
        auto funCallInstr = General::Instr(INSTR_CALL_RET, OP_NULL, res, args);
        currBlock->addInstr(funCallInstr);
    }
}

void QuadrupleGenerator::visitEVar(EVar *p) {
    auto res = General::Register(env.getFreshTemp());
    auto varVal = General::Register(env.getVarValue(env.getVarAddress(p->ident_)));
    auto instr = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, res, argsType{varVal});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitELitInt(ELitInt *p) {
    auto res = General::Register(env.getFreshTemp());
    auto instr = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, res, argsType{General::Int(p->integer_)});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitELitTrue(ELitTrue *p) {
    auto res = General::Register(env.getFreshTemp());
    auto instr = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, res, argsType{General::Bool(true)});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitELitFalse(ELitFalse *p) {
    auto res = General::Register(env.getFreshTemp());
    auto instr = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, res, argsType{General::Bool(false)});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitEString(EString *p) {
    auto res = General::Register(env.getFreshTemp());
    auto instr = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, res, argsType{General::String(p->string_)});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitAddOp(AddOp *p) {}

void QuadrupleGenerator::visitMulOp(MulOp *p) {}

void QuadrupleGenerator::visitRelOp(RelOp *p) {}

void QuadrupleGenerator::visitEmpty(Empty *p) {}

void QuadrupleGenerator::visitFun(Fun *p) {}

void QuadrupleGenerator::visitNeg(Neg *p) {
    p->expr_->accept(this);
    auto arg = env.getRecentRegister();

    auto res = General::Register(env.getFreshTemp());
    auto instr = General::Instr(INSTR_ASSIGNMENT, OP_NEG, res, argsType{arg});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitNot(Not *p) {
    p->expr_->accept(this);
    auto arg = env.getRecentRegister();

    auto res = General::Register(env.getFreshTemp());
    auto instr = General::Instr(INSTR_ASSIGNMENT, OP_NOT, res, argsType{arg});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitEMul(EMul *p) {
    p->expr_1->accept(this);
    auto arg1 = env.getRecentRegister();
    p->expr_2->accept(this);
    auto arg2 = env.getRecentRegister();

    p->mulop_->accept(this);

    auto res = General::Register(env.getFreshTemp());
    auto instr = General::Instr(INSTR_ASSIGNMENT, env.getRecentOp(), res, argsType{arg1, arg2});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitEAdd(EAdd *p) {
    p->expr_1->accept(this);
    auto arg1 = env.getRecentRegister();
    p->expr_2->accept(this);
    auto arg2 = env.getRecentRegister();

    p->addop_->accept(this);

    auto res = General::Register(env.getFreshTemp());
    auto instr = General::Instr(INSTR_ASSIGNMENT, env.getRecentOp(), res, argsType{arg1, arg2});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitERel(ERel *p) {
    p->expr_1->accept(this);
    auto arg1 = env.getRecentRegister();
    p->expr_2->accept(this);
    auto arg2 = env.getRecentRegister();

    p->relop_->accept(this);

    auto res = General::Register(env.getFreshTemp());
    auto instr = General::Instr(INSTR_ASSIGNMENT, env.getRecentOp(), res, argsType{arg1, arg2});
    currBlock->addInstr(instr);
}

void QuadrupleGenerator::visitEAnd(EAnd *p) {
    /*
     currBlock:
        w1 = expr1.eval()
        if not w1 goto Lfalse
     secondCond:
        w2 = expr2.eval()
        if not w2 goto Lfalse
     Ltrue:
        ...
        jump Rest
     Lfalse:
        ...
     Rest:
     */
    auto secondCondLabel = env.getFreshLabel();
    auto trueLabel = env.getFreshLabel("LTrue");
    auto falseLabel = env.getFreshLabel("LFalse");
    auto restLabel = env.getFreshLabel();
    auto secondCondBlock = new General::QuadrupleBlock(General::NORMAL, secondCondLabel);
    auto trueBlock = new General::QuadrupleBlock(General::NORMAL, trueLabel);
    auto falseBlock = new General::QuadrupleBlock(General::NORMAL, falseLabel);
    auto restBlock = new General::QuadrupleBlock(General::NORMAL, restLabel);

    p->expr_1->accept(this);
    auto &lastInstr = (*currBlock->listInstr())[currBlock->listInstr()->size() - 1];
    lastInstr.setUsedInJump(true);
    auto arg1 = env.getRecentRegister();

    auto firstCondJump = General::Instr(INSTR_IF_NOT_JUMP, OP_NULL, General::Type(""), argsType{arg1, falseLabel});
    currBlock->addInstr(firstCondJump);

    env.addNewBlock(secondCondLabel, secondCondBlock);
    General::QuadrupleEnvironment &localEnv(env);
    QuadrupleGenerator newQGenCond2(p->expr_2, localEnv, secondCondBlock);
    auto &secondlastInstr = (*newQGenCond2.currBlock->listInstr())[newQGenCond2.currBlock->listInstr()->size() - 1];
    secondlastInstr.setUsedInJump(true);
    auto arg2 = env.getRecentRegister();
    auto secondCondJump = General::Instr(INSTR_IF_NOT_JUMP, OP_NULL, General::Type(""), argsType{arg2, falseLabel});
    newQGenCond2.currBlock->addInstr(secondCondJump);

    env.addNewBlock(trueLabel, trueBlock);
    auto trueTemp = env.getFreshTemp();
    auto trueAssign = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, General::Register(trueTemp),
                                     argsType{General::Bool(true)});
    auto trueJump = General::Instr(INSTR_JUMP, OP_NULL, General::Type(""), argsType{restLabel});
    trueBlock->addInstr(trueAssign);
    trueBlock->addInstr(trueJump);

    env.addNewBlock(falseLabel, falseBlock);
    auto falseTemp = env.getFreshTemp();
    auto falseAssign = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, General::Register(falseTemp),
                                      argsType{General::Bool(false)});
    falseBlock->addInstr(falseAssign);

    env.addNewBlock(restLabel, restBlock);
    currBlock = restBlock;
    auto resTemp = env.getFreshTemp();
    auto phiInstr = General::Instr(INSTR_PHI, OP_NULL, General::Register(resTemp),
                                   argsType{trueLabel, trueTemp, falseLabel, falseTemp});
    restBlock->addInstr(phiInstr);

    //(*varValues)[it.first] = newTemp;

// TODO zmienić and i or na (albo i nie, bo to jest trudne do zaimplementowania, jak już, to dla cond i condelse)
/*
 if not w1 goto Lfalse
 if not w2 goto Lfalse
 code for Ltrue

 if w1 goto Ltrue
 if w2 goto Ltrue
 code for Lfalse

 */
}

void QuadrupleGenerator::visitEOr(EOr *p) {
    auto secondCondLabel = env.getFreshLabel();
    auto trueLabel = env.getFreshLabel("LTrue");
    auto falseLabel = env.getFreshLabel("LFalse");
    auto restLabel = env.getFreshLabel();
    auto secondCondBlock = new General::QuadrupleBlock(General::NORMAL, secondCondLabel);
    auto trueBlock = new General::QuadrupleBlock(General::NORMAL, trueLabel);
    auto falseBlock = new General::QuadrupleBlock(General::NORMAL, falseLabel);
    auto restBlock = new General::QuadrupleBlock(General::NORMAL, restLabel);

    p->expr_1->accept(this);
    auto &lastInstr = (*currBlock->listInstr())[currBlock->listInstr()->size() - 1];
    lastInstr.setUsedInJump(true);
    auto arg1 = env.getRecentRegister();

    auto firstCondJump = General::Instr(INSTR_IF_JUMP, OP_NULL, General::Type(""), argsType{arg1, trueLabel});
    currBlock->addInstr(firstCondJump);

    env.addNewBlock(secondCondLabel, secondCondBlock);
    General::QuadrupleEnvironment &localEnv(env);
    QuadrupleGenerator newQGenCond2(p->expr_2, localEnv, secondCondBlock);
    auto &secondlastInstr = (*newQGenCond2.currBlock->listInstr())[newQGenCond2.currBlock->listInstr()->size() - 1];
    secondlastInstr.setUsedInJump(true);
    auto arg2 = env.getRecentRegister();
    auto secondCondJump = General::Instr(INSTR_IF_JUMP, OP_NULL, General::Type(""), argsType{arg2, trueLabel});
    newQGenCond2.currBlock->addInstr(secondCondJump);

    env.addNewBlock(falseLabel, falseBlock);
    auto falseTemp = env.getFreshTemp();
    auto falseAssign = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, General::Register(falseTemp),
                                      argsType{General::Bool(false)});
    auto falseJump = General::Instr(INSTR_JUMP, OP_NULL, General::Type(""), argsType{restLabel});
    falseBlock->addInstr(falseAssign);
    falseBlock->addInstr(falseJump);


    env.addNewBlock(trueLabel, trueBlock);
    auto trueTemp = env.getFreshTemp();
    auto trueAssign = General::Instr(INSTR_ASSIGNMENT, OP_ASSIGNMENT, General::Register(trueTemp),
                                     argsType{General::Bool(true)});
    trueBlock->addInstr(trueAssign);

    env.addNewBlock(restLabel, restBlock);
    currBlock = restBlock;
    auto resTemp = env.getFreshTemp();
    auto phiInstr = General::Instr(INSTR_PHI, OP_NULL, General::Register(resTemp),
                                   argsType{trueLabel, trueTemp, falseLabel, falseTemp});
    restBlock->addInstr(phiInstr);
}

void QuadrupleGenerator::visitPlus(Plus *p) {
    env.addNewOp(OP_PLUS);
}

void QuadrupleGenerator::visitMinus(Minus *p) {
    env.addNewOp(OP_MINUS);
}

void QuadrupleGenerator::visitTimes(Times *p) {
    env.addNewOp(OP_TIMES);
}

void QuadrupleGenerator::visitDiv(Div *p) {
    env.addNewOp(OP_DIV);
}

void QuadrupleGenerator::visitMod(Mod *p) {
    env.addNewOp(OP_MOD);
}

void QuadrupleGenerator::visitLTH(LTH *p) {
    env.addNewOp(OP_LTH);
}

void QuadrupleGenerator::visitLE(LE *p) {
    env.addNewOp(OP_LE);
}

void QuadrupleGenerator::visitGTH(GTH *p) {
    env.addNewOp(OP_GTH);
}

void QuadrupleGenerator::visitGE(GE *p) {
    env.addNewOp(OP_GE);
}

void QuadrupleGenerator::visitEQU(EQU *p) {
    env.addNewOp(OP_EQU);
}

void QuadrupleGenerator::visitNE(NE *p) {
    env.addNewOp(OP_NE);
}

void QuadrupleGenerator::visitListType(ListType *p) {}

void QuadrupleGenerator::visitListExpr(ListExpr *p) {}

void QuadrupleGenerator::visitInteger(Integer x) {}

void QuadrupleGenerator::visitChar(Char x) {}

void QuadrupleGenerator::visitDouble(Double x) {}

void QuadrupleGenerator::visitString(String x) {}

void QuadrupleGenerator::visitIdent(Ident x) {}
