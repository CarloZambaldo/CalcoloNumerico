function f_integrata = integra(f)
    % [f_integrata] = INTEGRA(f)
    % f: funzione in una variabile
    % ordine: ordine della derivata finale (derivata prima, seconda, ...)
    % la derivata viene effettuata secondo la variabile di f
    
    syms x;
    f = f(x);
    
    f_integrata = int(f);
    f_integrata = matlabFunction(f_integrata);

end