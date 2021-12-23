// metodos_1.cpp : Este arquivo contém a função 'main'. A execução do programa começa e termina ali.
//

#include <iostream>
#include <math.h>
#include <iomanip>
#include "exprtk.hpp"
#include <time.h>

typedef double T;

typedef exprtk::symbol_table<T> symbol_table_t;
typedef exprtk::expression<T>     expression_t;
typedef exprtk::parser<T>             parser_t;

std::list<double> bissecao(std::string _expression_string, T _a, T _b, T _tolerancia) {
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
    x = _a;
    T _fA = expression.value();
    x = _b;
    T _fB = expression.value();
    if (_fA * _fB > 0) {
        return resultados;
    }
    T _x = (_a + _b) / 2;
    int n = 1;
    _fA = expression.value();
    x = _x;
    T _fx = expression.value();
    resultados.push_back(n);
    resultados.push_back(_x);
    _erroResidual = std::abs(_fx);
    resultados.push_back(_erroResidual);
    resultados.push_back(_erroAssociado);
    std::cout << "N: " << n << std::endl << "x: " << _x << std::endl << std::endl << "_erroResidual: " << _erroResidual << std::endl << "_erroAssociado: " << "-" << std::endl << "----------" << std::endl;
    n++;
    do {
        x = _x;
        T _fx = expression.value();
        if (_fx == 0) {
            resultados.push_back(n);
            resultados.push_back(_x);
            resultados.push_back(0);
            resultados.push_back(0);
        }
        T _xOld = _x;
        x = _a;
        _fA = expression.value();
        x = _x;
        _fx = expression.value();
        if (_fA * _fx < 0) {
            _b = _x;
        }
        else {
            _a = _x;
        }
        resultados.push_back(n);
        resultados.push_back(_x);
        _x = (_a + _b) / 2;
        x = _x;
        _fx = expression.value();
        _erroResidual = std::abs(_fx);
        _erroAssociado = std::abs(_x - _xOld);
        resultados.push_back(_erroResidual);
        resultados.push_back(_erroAssociado);
        std::cout << "N: " << n << std::endl << "x: " << _x << std::endl << "_erroResidual: " << _erroResidual << std::endl << "_erroAssociado: " << _erroAssociado << std::endl << "----------" << std::endl;
        n += 1;
        
    } while ((_erroResidual > _tolerancia) && (_erroAssociado > _tolerancia));

    return resultados;
};

int main()
{
    clock_t t;
    t = clock();
    std::list<double> resultado = bissecao("x^5 - x^3 + 3x - 5",1.0,2.0,0.00000001);
    t = clock() - t;
    double time_taken = ((double)t) / CLOCKS_PER_SEC;
    std::cout << "Tempo decorrido: " << std::fixed << std::setprecision(4) << time_taken << std::endl;
    return 0;
}

