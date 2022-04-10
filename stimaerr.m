function [] = stimaerr(toll, a, b, f, n);
    % funzione "multifunzione":
    % stima il numero N minimo di sottointervalli per cui l'errore<toll
    % data:
    % toll
    %
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    

    
    if b<a
        error(" b < a !!! ");
    end
    d2f_int = deriva(f,2);
    d4f_int = deriva(f,4);
    xx = linspace(a,b,1001);
    K2 = max(abs(d2f_int(xx)));
    K4 = max(abs(d4f_int(xx)));
    
    fprintf(2,"ATTENZIONE! Assumo sempre nodi equispaziati\n\n");
    
    fprintf("Numero minimo sottointervalli per rispettare la tolleranza:\n\n");
    
    %%
    fprintf(" ------- INTERPOLAZIONE -------\n");
    
    
    if nargin > 4
        dn1f = deriva(f,n+1);
        N_LAG = ceil((b-a)/(toll * 4 * (n+1)/(max(abs(dn1f(xx)))))^(1/(n+1)));
        fprintf("  Interpolazione di Lagrange di ordine n=%d: %d\n",n,N_LAG);
    end
    
    N_poli = ceil((b-a)/sqrt(8 * toll / K2));
    fprintf("  Interpolazione polinomiale a tratti: %d\n",N_poli);

    %%
    
    fprintf("\n ------- INTEGRAZIONE -------\n"); 
    N_PMC = ceil(sqrt(((b-a)^3*K2)/(24*toll)));
    N_TC = ceil(sqrt(((b-a)^3*K2)/(12*toll)));
    N_SC = ceil(((b-a)^5*K4/(2880*toll))^(1/4));
    fprintf("  Formula Punto Medio Composito: %d\n",N_PMC);
    fprintf("  Formula dei Trapezi: %d\n",N_TC);
    fprintf("  Formula di Simpson: %d\n",N_SC);
    
    
    %%
    
    fprintf("\n ------- DERIVAZIONE -------\n"); 
    
    N_DFA = ceil(2*toll/K2);
    N_DFI = ceil(2*toll/K2);
    %N_DFC = ceil(
    fprintf("  Differenze finite in Avanti: %d\n",N_DFA);
    fprintf("  Differenze finite all'Indietro: %d\n",N_DFI);
    %fprintf("  Differenze finite Centrate: %d\n",N_DFC);
    
    
end