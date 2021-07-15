function [I] = gausslegendre(a,b,n,f)
    % [I] = gausslegendre(a,b,n,f)
    %
    % n+1 = numero dei nodi di quadratura
    % OVVERO : n = numero di sottointervalli
    %
    % calcolo l'integrale con formule di Gauss Legendre
    % [nodi, pesi] = zplege(n,a,b);
    % I = sum(pesi .* f(nodi));
    
    [nodi, pesi] = zplege(n,a,b);
    I = sum(pesi .* f(nodi));
end