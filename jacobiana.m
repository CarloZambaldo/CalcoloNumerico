function [J] = jacobiana(F, n_comp)
    % [J] = JACOBIANA(F, n_comp)
    % calcola la Jacobiana di F funzione a più variabili, dato in ingresso
    % un numero n_comp contenente il numero di componenti
    % 
    % esempio
    % F = @(x,y) x+y;
    % J = jacobiana(F,2)
    %
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    
    syms x1 x2 x3 x4 x5;
    
    if n_comp == 2
        F = F(x1,x2);
        v = [x1 x2];
        J = jacobian(F,v);
        J = matlabFunction(J);
    end
    
    if n_comp == 3 
        F = F(x1,x2,x3);
        v = [x1 x2 x3];
        J = jacobian(F,v);
        J = matlabFunction(J);
    end
    
    if n_comp == 4
        F = F(x1,x2,x3,x4);
        v = [x1 x2 x3 x4];
        J = jacobian(F,v);
        J = matlabFunction(J);
    end
    
    if n_comp == 5
        F = F(x1,x2,x3,x4,x5);
        v = [x1 x2 x3 x4 x5];
        J = jacobian(F,v);
        J = matlabFunction(J);
    end
    
    if n_comp < 2 || n_comp > 5
        error("Numero incorretto di componenti");
    end
end