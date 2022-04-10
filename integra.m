function f_integrata = integra(f)
    % [f_integrata] = INTEGRA(f)
    %
    % f        =  funzione in una variabile
    % ordine   =  ordine della derivata finale (derivata prima, seconda, ...)
    %
    % la derivata viene effettuata secondo la variabile di f
    %
    % l'output f_integrata è a sua volta un'anonymous function
    % attenzione: f_integrata NON presenta la costante "+c".

    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    
    syms x;
    f = f(x);
    
    f_integrata = int(f);
    f_integrata = matlabFunction(f_integrata);

end
