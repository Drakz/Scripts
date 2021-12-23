#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

//#include "SisLin.h"

// Calcula a solução aproximada de um sistema de equações lineares
// via método de Jacobi.
// O sistema a*x=b deve estar na forma de uma matriz completa A:=[a b].
// A matriz de coeficientes "a" é decomposta como a=B-C onde "B" é a matriz
// diagonal formada pela diagonal principal de "a".

// Variáveis de entrada

// A        -> matriz completa de um sistema de equações lineares.
// xi       -> aproximação inicial do sistema.
// tol      -> tolerância na diferença entre duas aproximações sucessivas.

// Variável de saída

// X        -> solução aproximada do sistema.

// Variáveis auxiliares

// n        -> número de linhas no sistema.
// m        -> número de colunas no sistema.
// InvB     -> inversa de B.
// C        -> matriz C=B-a.
// InvB_b   -> produto InvB*b.
// InvB_C   -> produto InvB*C.
// x0       -> solução aproximada do sistema na iterada anterior.
// segue    -> variável booleana. Controla a execução das iteradas.
// contador -> contador do número de iteradas.

int gjacobi(Matrix &A, Matrix &xi, double tol, Matrix &X)
{
  double erro;
  int i,j,k,
      n = size(A,1),
      m = size(A,2);
  
  Matrix invB(n,n),  invB_b(n,1),  invB_C(n,n), C(n,n), x0;

  
  for (i=0; i<n; ++i)
    invB(i,i)=1/A(i,i);

  for (i=0; i<n; ++i)
    for (j=0; j<n; ++j)
      if (i != j) C(i,j)=-A(i,j);

  for (i=0; i<n; ++i)
    invB_b(i,0) = invB(i,i)*A(i,n);

  for (i=0; i<n; ++i)
    for (j=0; j<n; ++j)
      invB_C(i,j) = invB(i,i)*C(i,j);

  // Aproximação inicial e inicialização das demais variáveis.
  x0 = xi;
  k = 0;

  // Iteração
  cout << "X(" << k << "): " << endl;
  cout << x0 << endl;

  do {
    ++k;
    
    X = invB_b + invB_C*x0;

    erro = maxAbs(X-x0);
    x0 = X;

    cout << "X(" << k << "): " << endl;
    cout << X << endl;
    cout << "Erro(" << k << ") = " << scientific << setw(10) << erro << fixed << endl;
    // Matrix residuo = X - invB_C*X - invB_b
    // cout << "Residuo(" << k << "): " << endl;
    // cout << residuo << endl;
    // cin.getline();    
  } while ( erro > tol and k != MAX_IT );

  cout << endl << endl;
  
  if (k >= MAX_IT)
    cerr << "Não houve convergência." << endl;

  return k;
}
