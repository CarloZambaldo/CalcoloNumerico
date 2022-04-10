function [] = controlla(A)
    % la funzione restituisce:
    % - numero di condizionamento, stima del numero di condizionamento (se la matrice è molto grande)
    % - raggio spettrale
    % 
 
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    

    n = size(A,1);
    m = size(A,2);
    if(m ~= n)
        fprintf(2,"La matrice non è quadrata!\n");
    end
    
    % calcolo numero di condizionamento
    if(n < 10000)
        condiz = cond(A);
        fprintf("Numero di condizionamento: %g\n", condiz);
    else
        condiz = condest(A);
        fprintf(2,"Stima del numero di condizionamento: %g\n", condiz);
    end
    if(condiz > 1e5)
        fprintf(2,"Warning! Il numero di condizionamento risulta elevato!\n");
    end
    % calcolo raggio spettrale
    rho = max(abs(eig(A)));
    fprintf("Raggio spettrale: %g\n", rho);
    
end
