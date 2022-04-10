function [derivata] = deriva(f,ordine)
    % [derivata] = DERIVA(f,ordine)
    %
    % f       =  anonymous function in UNA variabile
    % ordine  =  ordine della derivata finale (derivata prima, seconda, ...)
    %  
    % la derivata viene effettuata secondo la variabile di f
    %
    % l'output derivata è a sua volta un'anonymous function.
    %
    % attenzione:
    %   d[@(x)x]/dx = @()1   ->   ovvero non ha più argomento


    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    

    syms x;
    f = f(x);

    derivata = diff(f,x,ordine);
    derivata = matlabFunction(derivata); 
end
