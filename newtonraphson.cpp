#include <iostream>
#include <math.h>
#include <iomanip>
#include "exprtk.hpp"
#include <time.h>

typedef double T;

typedef exprtk::symbol_table<T> symbol_table_t;
typedef exprtk::expression<T>     expression_t;
typedef exprtk::parser<T>             parser_t;

//derivada: f(x + h) - f(x - h)) / 2 * h

std::list<double> newtworaphson(std::string _expression_string, T _x, T _tolerancia) {
    std::list<double> resultados = {};
    T x;
    T _erroResidual = 100, _erroAssociado = 100;
    symbol_table_t symbol_table;
    symbol_table.add_variable("x", x);
    expression_t expression;
    expression.register_symbol_table(symbol_table);
    parser_t parser;
    if (!parser.compile(_expression_string, expression))
    {
        printf("Compilation error...\n");
    }
    int n = 0;
    T h = 0.00000001;
    T _xOld = _x;
    do {
        x = _xOld + h;
        T _d1 = expression.value();
        x = _xOld - h;
        T _d2 = expression.value();
        if (((_d1 - _d2) / (2 * h)) == 0) {
            break;
        }
        n = n + 1;
        x = _xOld;
        T _fx = expression.value();
        T value = _xOld - (_fx/((_d1 - _d2) / (2 * h)));
        x = value;
        T _fValue = expression.value();
        if (_fValue == 0) {
            resultados.push_back(n);
            resultados.push_back(value);
            resultados.push_back(0);
            resultados.push_back(0);
            break;
        }
        _erroResidual = std::abs(_fValue);
        _erroAssociado = std::abs(value - _xOld);
        resultados.push_back(n);
        resultados.push_back(value);
        resultados.push_back(_erroResidual);
        resultados.push_back(_erroAssociado);
        _xOld = value;
        //std::cout << "N: " << n << std::endl << "x: " << x << std::endl << "Er: " << _erroResidual << std::endl << "Ex: " << _erroAssociado << std::endl << "------" << std::endl;
    } while ((_erroResidual > _tolerancia) && (_erroAssociado > _tolerancia));

    return resultados;
};

int main()
{
    clock_t t;
    t = clock();
    std::list<double> resultado = newtworaphson("3346.09*x^10-(x^9+x^8+x^7+x^6+x^5+x^4+x^3+x^2+x+1)*359.9", 4.0, 0.000001);
    t = clock() - t;
    double time_taken = ((double)t) / CLOCKS_PER_SEC;
    std::cout << "Tempo decorrido: " << std::fixed << std::setprecision(8) << time_taken << std::endl;
    return 0;
}