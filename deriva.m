function [derivata] = deriva(f,ordine)
% [derivata] = DERIVA(f,ordine)
% f: funzione in una variabile
% ordine: ordine della derivata finale (derivata prima, seconda, ...)
% la derivata viene effettuata secondo la variabile di f

    syms x;
    f = f(x);

    derivata = diff(f,x,ordine);
    derivata = matlabFunction(derivata);
end