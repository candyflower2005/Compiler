#ifndef LATTE_LOGGER_H
#define LATTE_LOGGER_H

#include <vector>
#include "types.h"

namespace General {
    class Logger {
        std::vector<std::string> messages;
    public:
        void logError(int lineNumber, std::string message);

        void logWarning(int lineNumber, std::string message);

        void print();
    };
}

#endif //LATTE_LOGGER_H
