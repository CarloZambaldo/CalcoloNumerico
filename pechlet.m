function [Peh] = pechlet(mu, eta, h)
    % 
    % [Peh] = pechlet(mu, eta, h)
    %
    % valuta il numero di pechlet locale per il problema di diffuzione, trasporto e reazione.
    % mu, eta, h sono i parametri dati dal problema
    % (si veda l'help della funzione diffusione_trasporto_reazione)
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    
    
    if mu ~= 0
        %% FORMULA
        Peh = abs(eta)*h/(2*mu);
    else
        Peh = 0;
    end
    fprintf("Numero di Peclet locale: ");
    if Peh ~= 0
        
        if Peh >= 1 % possibili instabilità, suggerisco una viscosità artificiale
            fprintf(2,"%.4g\n", Peh);
            muh_UP = mu * (1+Peh);
            muh_SG = mu * (1+(Peh-1+(2*Peh)/(exp(2*Peh)-1)));
            fprintf("Per ridurre possibili instabilità usare:\n");
            fprintf("  Viscosità artificiale (metodo UPWIND): mu = %.4g\n", muh_UP);
            fprintf("  Viscosità artificiale ottimale (Scharfetter-Gummel): mu = %.4g\n", muh_SG);
        else
            fprintf("%.4g\n", Peh);
        end
    end
    fprintf("\n---\n");
end
