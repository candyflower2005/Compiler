#ifndef LATTE_PARSER_HEADER_FILE
#define LATTE_PARSER_HEADER_FILE

#include<vector>
#include<string>

namespace Latte
{
class Program;
class TopDef;
class ListTopDef;
class Arg;
class ListArg;
class Block;
class ListStmt;
class Stmt;
class Item;
class ListItem;
class Type;
class ListType;
class Expr;
class ListExpr;
class AddOp;
class MulOp;
class RelOp;

typedef union
{
  int int_;
  char char_;
  double double_;
  char* string_;
  Program* program_;
  TopDef* topdef_;
  ListTopDef* listtopdef_;
  Arg* arg_;
  ListArg* listarg_;
  Block* block_;
  ListStmt* liststmt_;
  Stmt* stmt_;
  Item* item_;
  ListItem* listitem_;
  Type* type_;
  ListType* listtype_;
  Expr* expr_;
  ListExpr* listexpr_;
  AddOp* addop_;
  MulOp* mulop_;
  RelOp* relop_;
} YYSTYPE;

Program* pProgram(FILE *inp);
Program* pProgram(const char *str);

}

#define LATTE__ERROR_ 258
#define LATTE__SYMB_0 259
#define LATTE__SYMB_1 260
#define LATTE__SYMB_2 261
#define LATTE__SYMB_3 262
#define LATTE__SYMB_4 263
#define LATTE__SYMB_5 264
#define LATTE__SYMB_6 265
#define LATTE__SYMB_7 266
#define LATTE__SYMB_8 267
#define LATTE__SYMB_9 268
#define LATTE__SYMB_10 269
#define LATTE__SYMB_11 270
#define LATTE__SYMB_12 271
#define LATTE__SYMB_13 272
#define LATTE__SYMB_14 273
#define LATTE__SYMB_15 274
#define LATTE__SYMB_16 275
#define LATTE__SYMB_17 276
#define LATTE__SYMB_18 277
#define LATTE__SYMB_19 278
#define LATTE__SYMB_20 279
#define LATTE__SYMB_21 280
#define LATTE__SYMB_22 281
#define LATTE__SYMB_23 282
#define LATTE__SYMB_24 283
#define LATTE__SYMB_25 284
#define LATTE__SYMB_26 285
#define LATTE__SYMB_27 286
#define LATTE__SYMB_28 287
#define LATTE__SYMB_29 288
#define LATTE__SYMB_30 289
#define LATTE__SYMB_31 290
#define LATTE__SYMB_32 291
#define LATTE__STRING_ 292
#define LATTE__INTEGER_ 293
#define LATTE__IDENT_ 294

extern Latte::YYSTYPE Latteyylval;

#endif
