function [x_finale, it] = ptofis_sistemi(x0, phi, nmax, toll)
    % [x_finale, it] = ptofis_sistemi(x0, phi, nmax, toll)
    %
    % risoluzione di sistemi non lineari con metodo di ptofis
    %
    % nota phi restituisce dei vettori!
    %

    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    

    err = toll +1;
    it = 0;
    x = x0;
    while it < nmax && err > toll
        x_new = phi(x);
        err = norm(x_new - x);
        x = x_new;
        it = it+1;
    end

    x_finale = x;
    
    fprintf("Iterazioni di punto fisso: %d\n",it);
    fprintf("Punto fisso calcolato: %g\n",x_finale);
    fprintf("-\n");
end



    