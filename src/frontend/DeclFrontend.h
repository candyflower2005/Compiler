#ifndef LATTE_DECLFRONTEND_H
#define LATTE_DECLFRONTEND_H

#include "../grammar/Absyn.H"
#include "../general/environment.h"
#include "../general/logger.h"
#include "../general/types.h"
#include "Frontend.h"


class DeclFrontend : public Frontend {
    General::Type type;
public:
    DeclFrontend(Visitable *p, General::Environment &env, General::Logger &logger, General::Type type, Ident currTopDef) :
            type(type), Frontend(nullptr, env, logger, currTopDef) {
        p->accept(this);
    };

    void visitListItem(ListItem *list_item);
    void visitNoInit(NoInit *p);
    void visitInit(Init *p);
};


#endif //LATTE_DECLFRONTEND_H
