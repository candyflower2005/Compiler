#ifndef LATTE_TOPDEFFRONTEND_H
#define LATTE_TOPDEFFRONTEND_H

#include "../grammar/Absyn.H"
#include "../general/environment.h"
#include "../general/logger.h"
#include "../general/types.h"
#include "Frontend.h"

using namespace Latte;

class TopDefFrontend : public Frontend {
    Ident currTopDef;

public:
    TopDefFrontend(Visitable *p, General::Environment &env, General::Logger &logger) :
            Frontend(nullptr, env, logger, "") {
        p->accept(this);
    };

    void visitFnDef(FnDef *p);
    void visitListArg(ListArg *p);
    void visitAr(Ar *p);
};


#endif //LATTE_TOPDEFFRONTEND_H
