#include <iostream>
#include <cstdlib>
#include <vector>
#include <cmath>

using namespace std;

#define L 3
 
void Imprimir ( double vet[L])
{
    for (int i=0; i< L;i++)
    {
        cout << vet[i] << endl;
    }
}

double Maior (double vet[L])
{
    double maior= vet[0];
    for (int i=0; i<L; i++)
        if (vet[i] > maior)
            maior = vet[i];
    

    maior = fabs(maior);
    return maior;
}

int main ()
{
    int vetIndep [L],vetInicial[L], n = 0, kmax;
    double matriz [L][L],erro,rerro[L],errox[L],xn[L],oldx[L];

    cout << "Digite os valores da matriz:" << endl;
    for (int i=0; i< L; i++)
    {
        rerro[i] = 0;
    }

    for (int i=0; i < L ;i++)
    {
        for (int j=0; j < L;j++)
        {
            cout << "a" << "[" << i << "]"<< "[" << j << "] :" << endl;
            cin >> matriz [i][j];
        }
        cout << endl;
    }

    cout << "Digite o vetor dos termos independentes: "<< endl;
    for (int i=0; i<L;i++)
        cin >> vetIndep[i];
    cout << endl;

    cout << "Digite o numero maximo de iteracoes : " << endl;
    cin >> kmax;

    cout << "Digite o parametro de tolerencia dos erros:" << endl;
    cin >> erro;
    cout << endl;

    cout << "Digite a solucao inicial: " << endl;
    for (int i=0; i < L; i++)
        cin >> vetInicial[i];
    cout << endl;
    for (int i=0;i< L;i++)
        oldx[i] = vetInicial[i];

    do 
    {
        if (n == kmax)
        {
            cout << "Numero maximo de iteracoes atingido" << endl;
            break;
        }
        else 
        {
            n=n+1;
            for (int i=0; i< L;i++)
            {
                xn[i] = vetIndep[i];
                for (int j=0; j < (i-1);j++)
                    xn[i] = xn[i] - (matriz[i][j] * oldx[j]);  

                for (int j=(i+1); j< L;j++)
                    xn[i] = xn[i] - (matriz[i][j] * oldx[j]);
                
                if(matriz[i][i] != 0)
                    xn[i] = xn[i]/matriz[i][i];
                else 
                {
                    cout << " O metodo iterativo nao converge" << endl;
                }   
            }
        }
        for (int i=0; i< L;i++)
        {
            errox[i] = xn[i] - oldx[i];
        }

        for (int i = 0 ; i<L; i++)
        {
            for (int j = 0; j<L; j++)
            {
                rerro[i] = rerro[i] + (matriz[i][j] * xn[j]);
            }
            rerro[i] = rerro[i] - vetIndep[i];
            cout << rerro[i] << endl;
        }

        for (int i=0; i< L;i++)
        {
            oldx[i] = xn[i];
        }

        cout << "Iteracao " << n <<endl;
        Imprimir(xn);
        cout << "Erro residual :" << Maior(rerro) << endl;
        cout << "Erro em x:" << Maior(errox) << endl;
        cout << endl;

    }while (Maior(errox) >= erro &&  Maior(rerro) >= erro);
    
    return 0;
}