function [x,k] = metodosecanti(f,x0,nmax,aq0,b)
%METODOSECANTI(f, x0, aq0 ,b)
%   f = funzione !!
%   x0 guess iniziale
%   aq0 assume due significati:
%    -- se non viene inserito b, aq0 viene usato come q_s iniziale
%    -- se viene inserito b, aq0 è l'estremo inferiore dell'intervallo
%   alpha in (a,b) -> intervallo
%
%   NOTA: se non viene inserito q0 viene ricavato il valore q0 iniziale
%   tramite il metodo delle corde !!!

    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    

   
    m = 0;
    if nargin==5
         x_01 = metodocorde(f,x0,1,aq0,b);
         q_s = (f(x_01) - f(x0))/(x_01 - x0);
         m = 1;
    else
        q_s = aq0;
    end
    
    k = 0;
    x = x0;

    while k<nmax-m
        k = k+1;
        x_old = x;
        x = x-f(x)/q_s;
        q_s = (f(x) - f(x_old))/(x - x_old);
    end
    
    if k < nmax
        fprintf("Newton converge in %d iterazioni\n", k);
    else
        fprintf("Newton non è arrivato a convergenza entro %d iterazioni\n",k);
    end
        
    fprintf("La soluzione calcolata è: %.6g\n\n", x);
end

