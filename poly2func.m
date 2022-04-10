function [p_fun] = poly2func(p_vect)
 %  [p_fun] = poly2func(p_vect)
 %
 % converte un polinomio (definito dal vettore dei coefficienti) in anonymous function 
 
 
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    
    p = symfun(p_vect);
    p_fun = matlabFunction(p);
end
