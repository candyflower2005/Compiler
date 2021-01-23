#ifndef LATTE_TYPES_H
#define LATTE_TYPES_H

#include<string>
#include<exception>
#include <memory>
#include <list>
#include "../grammar/Absyn.H"

typedef std::string Ident;
typedef int Loc;

const static std::string INSTR_ASSIGNMENT = "assignment";
const static std::string INSTR_PHI = "phi";
const static std::string INSTR_CALL_RET = "call_ret";
const static std::string INSTR_CALL_NO_RET = "call_no_ret"; // args {fun_label, arg1, arg2, ...}
const static std::string INSTR_RETURN = "return";
const static std::string INSTR_JUMP = "jump";
const static std::string INSTR_IF_NOT_JUMP = "if_not_jump";
const static std::string INSTR_IF_JUMP = "if_jump";

const static std::string OP_NULL = "null";
const static std::string OP_ASSIGNMENT = "assignment";
const static std::string OP_PARAM = "param";
const static std::string OP_NEG = "- ";
const static std::string OP_NOT = "!";
const static std::string OP_AND = "&&";
const static std::string OP_OR = "||";
const static std::string OP_PLUS = "+";
const static std::string OP_MINUS = "-";
const static std::string OP_TIMES = "*";
const static std::string OP_DIV = "/";
const static std::string OP_MOD = "%";
const static std::string OP_LTH = "<";
const static std::string OP_LE = "<=";
const static std::string OP_GTH = ">";
const static std::string OP_GE = ">=";
const static std::string OP_EQU = "==";
const static std::string OP_NE = "!=";

const static std::string RUN_TIME_ERROR = "runTimeError";

typedef enum {
    CANT_RETURN,
    MIGHT_RETURN,
    MUST_RETURN,
} ret_type;

namespace General {
    typedef enum {
        LOOP,
        FUN_DEF,
        NORMAL,
    } blockType;

    class Type {
    protected:
        std::string className;
        bool isConst = false;
        std::string val;

    public:
        Type() {};

        Type(std::string val) : val(val) {};

        void changeVal(std::string newVal);

        bool same(Type &);

        std::string &print();

        bool getIsConst();

        void setIsConst(bool newVal);

        std::string &getVal();
    };

    class Int : public Type {
    public:
        Int();

        Int(int val);
    };

    class Bool : public Type {
    public:
        Bool();

        Bool(bool val);
    };

    class String : public Type {
    public:
        String();

        String(Ident val);

    };

    class Void : public Type {
    public:
        Void();
    };

    class Register : public Type {
    public:
        Register(Ident val);
    };

    class Plus : public Type {
    public:
        Plus();
    };

    class Minus : public Type {
    public:
        Minus();
    };

    class Times : public Type {
    public:
        Times();
    };

    class Div : public Type {
    public:
        Div();
    };

    class Mod : public Type {
    public:
        Mod();
    };

    class LTH : public Type {
    public:
        LTH();
    };

    class LE : public Type {
    public:
        LE();
    };

    class GTH : public Type {
    public:
        GTH();
    };

    class GE : public Type {
    public:
        GE();
    };

    class EQU : public Type {
    public:
        EQU();
    };

    class NE : public Type {
    public:
        NE();
    };

    class AND : public Type {
    public:
        AND();
    };

    class OR : public Type {
    public:
        OR();
    };

    class CompilerError : public std::exception {
    public:
        const char *what() const throw() {};
    };

    class Instr {
        std::string instrName;
        std::string opName;
        Type result; // either 'Register' or constant of type 'Type'
        std::vector<Type> args;
        bool usedInJump = false;

    public:
        Instr(std::string instrName, std::string opName, Type result,
              std::vector<Type> args) : instrName(std::move(instrName)),
                                        opName(std::move(opName)),
                                        result(std::move(result)),
                                        args(std::move(args)) {}

        void print();

        std::string &getInstrName();

        std::string &getOpName();

        std::vector<Type> *getArgs();

        Type *getRes();

        bool setUsedInJump(bool used);

        bool isUsedInJump();
    };

    class QuadrupleBlock {
        blockType type;
        Ident label;
        std::list<Instr> instr;

    public:
        QuadrupleBlock(blockType type, Ident label) : type(type), label(std::move(label)) {}

        void addInstr(Instr singleInstr, bool start=false);

        void addInstrBeforeJump(Instr singleInstr);

        Ident getLabel();

        void print();

        std::list<Instr> *listInstr();
    };

}

typedef std::vector<General::Type> argsType;

#endif //LATTE_TYPES_H
