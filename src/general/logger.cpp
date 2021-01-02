#include "logger.h"
#include <iostream>

void General::Logger::logError(int lineNumber, std::string message) {
    messages.push_back("Line " + std::to_string(lineNumber) + ": " + message + "\n");
    throw General::CompilerError();
}

void General::Logger::logWarning(int lineNumber, std::string message) {
    messages.push_back("Warning: Line " + std::to_string(lineNumber) + ": " + message + "\n");
}

void General::Logger::print() {
    for (auto &s: messages) {
        std::cerr << s;
    }
}