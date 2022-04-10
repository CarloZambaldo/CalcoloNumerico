function [perturbazione, C_fac] = Wilkinson(A, const, epsilon_M, max_Akk)
    % effettua una stima della perturbazione massima attesa sulla matrice A,
    % const è un parametro che dipende dal metodo e calcolatore (deve
    % essere dato)
    % richiesto max_Akk = massimo elemento incontrato durante il passo k
    % del metodo utilizzato (MEG, MEG + pivoting ...)
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    
    n = size(A, 1);
    max_A = max(max(A));

    C_fac = max_Akk / max_A;
    perturbazione = const * n^3 * epsilon_M * C_fac;
    fprintf("\n  perturbazione attesa <= %.10g\n", perturbazione);
    if perturbazione > 0.4
        fprintf(2, "  Attenzione! La perturbazione sulla matrice risulta elevata!\n");
    end
    
    fprintf("\n  Perturbazioni stimate:\n");
    fprintf("\n  - con MEG no pivoting: >1 %g\n", 1);
    fprintf("\n  - con MEG e pivoting per riga: <= %g\n",2^(n-1));
    fprintf("\n  - con MEG e pivoting totale: <= %g\n", n^0.5 * n^((log(n)/4);
end