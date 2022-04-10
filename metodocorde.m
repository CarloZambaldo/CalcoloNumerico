function [x,k] = metodocorde(f,x0,nmax, a,b)
%METODOCORDE(f,x0, a,b)
%   f = funzione !!
%   x0 guess iniziale
%   alpha in (a,b) -> intervallo

    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    


    if (f(a) * f(b) >=0)
        error("non posso stabilire se ci sono zeri");
    end
    
    q_c = (f(b)-f(a))/(b-a);
    k = 0;
    x = x0;
    while k<nmax
        k = k+1;
        x = x-f(x)/q_c;
    end
    
    if k < nmax
        fprintf("Newton converge in %d iterazioni\n", k);
    else
        fprintf("Newton non è arrivato a convergenza entro %d iterazioni\n",k);
    end
        
    fprintf("La soluzione calcolata è: %.6g\n\n", x);
end

