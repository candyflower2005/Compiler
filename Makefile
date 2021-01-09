CC=g++
CCFLAGS=-g

BNFC=bnfc
FLEX=flex
BISON=bison

GENERAL=src/general/
BACKEND=src/backend/
FRONTEND=src/frontend/
GRAMMAR=src/grammar/

all: latc_x86

# gcc -m32 -c lib/runtime.c -o lib/runtime.o

clean:
	rm latc_x86
	rm -r ${GRAMMAR}*.o
	rm -r ${BACKEND}*.o
	rm -r ${FRONTEND}*.o
	rm -r ${GENERAL}*.o

${GRAMMAR}Lexer.C: ${GRAMMAR}Latte.l
	${FLEX} -o ${GRAMMAR}Lexer.C ${GRAMMAR}Latte.l

${GRAMMAR}Parser.C ${GRAMMAR}Parser.H: ${GRAMMAR}Latte.y
	${BISON} ${GRAMMAR}Latte.y -o ${GRAMMAR}Parser.C

${GRAMMAR}Absyn.o: ${GRAMMAR}Absyn.C ${GRAMMAR}Absyn.H
	${CC} ${CCFLAGS} -c ${GRAMMAR}Absyn.C -o ${GRAMMAR}Absyn.o

${GRAMMAR}Lexer.o: ${GRAMMAR}Lexer.C ${GRAMMAR}Parser.H
	${CC} ${CCFLAGS} -c ${GRAMMAR}Lexer.C -o ${GRAMMAR}Lexer.o

${GRAMMAR}Parser.o: ${GRAMMAR}Parser.C ${GRAMMAR}Absyn.H
	${CC} ${CCFLAGS} -c ${GRAMMAR}Parser.C -o ${GRAMMAR}Parser.o

latc_x86: ${GENERAL}latc.o ${FRONTEND}Frontend.o ${GRAMMAR}Parser.o ${BACKEND}QuadrupleGenerator.o ${GENERAL}environment.o ${GENERAL}logger.o ${GENERAL}function_def.o ${FRONTEND}ExprFrontend.o ${GENERAL}types.o ${FRONTEND}TopDefFrontend.o ${FRONTEND}DeclFrontend.o ${GRAMMAR}Absyn.o ${GRAMMAR}Lexer.o ${GENERAL}quadruple_environment.o ${BACKEND}Optimizer.o ${BACKEND}AssemblyCodeGenerator.o
	${CC} ${CCFLAGS} ${GENERAL}latc.o ${FRONTEND}Frontend.o ${GENERAL}environment.o ${GENERAL}logger.o ${GRAMMAR}Parser.o ${BACKEND}QuadrupleGenerator.o ${GENERAL}function_def.o ${FRONTEND}ExprFrontend.o ${GENERAL}types.o ${FRONTEND}TopDefFrontend.o ${FRONTEND}DeclFrontend.o ${GRAMMAR}Absyn.o ${GRAMMAR}Lexer.o ${GENERAL}quadruple_environment.o ${BACKEND}Optimizer.o ${BACKEND}AssemblyCodeGenerator.o -o latc_x86

${GENERAL}latc.o: ${GENERAL}latc.cpp ${FRONTEND}Frontend.h ${GRAMMAR}Parser.H ${GENERAL}environment.h ${GENERAL}logger.h
	${CC} ${CCFLAGS} -c ${GENERAL}latc.cpp -o ${GENERAL}latc.o

${FRONTEND}Frontend.o: ${FRONTEND}Frontend.cpp ${FRONTEND}Frontend.h ${FRONTEND}TopDefFrontend.h ${FRONTEND}DeclFrontend.h ${FRONTEND}ExprFrontend.h ${GRAMMAR}Absyn.H ${GENERAL}environment.h ${GENERAL}logger.h ${GENERAL}types.h
	${CC} ${CCFLAGS} -c ${FRONTEND}Frontend.cpp -o ${FRONTEND}Frontend.o

${GENERAL}function_def.o: ${GENERAL}function_def.cpp ${GENERAL}function_def.h ${GENERAL}types.h
	${CC} ${CCFLAGS} -c ${GENERAL}function_def.cpp -o ${GENERAL}function_def.o

${FRONTEND}ExprFrontend.o: ${FRONTEND}ExprFrontend.cpp ${FRONTEND}ExprFrontend.h ${GRAMMAR}Absyn.H ${FRONTEND}Frontend.h
	${CC} ${CCFLAGS} -c ${FRONTEND}ExprFrontend.cpp -o ${FRONTEND}ExprFrontend.o

${GENERAL}types.o: ${GENERAL}types.cpp ${GENERAL}types.h ${GRAMMAR}Absyn.H
	${CC} ${CCFLAGS} -c ${GENERAL}types.cpp -o ${GENERAL}types.o

${FRONTEND}TopDefFrontend.o: ${FRONTEND}TopDefFrontend.cpp ${FRONTEND}TopDefFrontend.h ${GRAMMAR}Absyn.H ${FRONTEND}ExprFrontend.h ${GENERAL}environment.h ${GENERAL}logger.h ${GENERAL}types.h ${FRONTEND}Frontend.h
	${CC} ${CCFLAGS} -c ${FRONTEND}TopDefFrontend.cpp -o ${FRONTEND}TopDefFrontend.o

${FRONTEND}DeclFrontend.o: ${FRONTEND}DeclFrontend.cpp ${FRONTEND}DeclFrontend.h ${GRAMMAR}Absyn.H ${FRONTEND}ExprFrontend.h ${GENERAL}environment.h ${GENERAL}logger.h ${GENERAL}types.h ${FRONTEND}Frontend.h
	${CC} ${CCFLAGS} -c ${FRONTEND}DeclFrontend.cpp -o ${FRONTEND}DeclFrontend.o

${BACKEND}QuadrupleGenerator.o: ${BACKEND}QuadrupleGenerator.cpp ${BACKEND}QuadrupleGenerator.h ${GRAMMAR}Absyn.H ${GENERAL}types.h ${GENERAL}quadruple_environment.h
	${CC} ${CCFLAGS} -c ${BACKEND}QuadrupleGenerator.cpp -o ${BACKEND}QuadrupleGenerator.o

${GENERAL}quadruple_environment.o: ${GENERAL}quadruple_environment.cpp ${GENERAL}quadruple_environment.h ${GENERAL}types.h ${GENERAL}environment.h ${GENERAL}function_def.h
	${CC} ${CCFLAGS} -c ${GENERAL}quadruple_environment.cpp -o ${GENERAL}quadruple_environment.o

${BACKEND}Optimizer.o: ${BACKEND}Optimizer.cpp ${BACKEND}Optimizer.h ${GENERAL}types.h ${GENERAL}quadruple_environment.h
	${CC} ${CCFLAGS} -c ${BACKEND}Optimizer.cpp -o ${BACKEND}Optimizer.o

${BACKEND}AssemblyCodeGenerator.o: ${BACKEND}AssemblyCodeGenerator.cpp ${BACKEND}AssemblyCodeGenerator.h ${BACKEND}Optimizer.h
	${CC} ${CCFLAGS} -c ${BACKEND}AssemblyCodeGenerator.cpp -o ${BACKEND}AssemblyCodeGenerator.o
