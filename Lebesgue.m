function [Lebesgue_const] = Lebesgue(n, x_nodi, n_punti_grafico)
    % [Lebesgue_const] = Lebesgue(n, x_nodi, n_punti_grafico)
    %
    % n = grado della base polinomiale di Lagrange
    % x_nodi = ascisse dei nodi
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    

    
    gamma = 0.5; %circa
    Lebesgue_const = (2^(n+1))/(exp(1)*n*(log(n)+gamma));
    % l'interpolazione polinomiale di Lagrange su nodi equispaziati non è
    % stabile per n grande
    
    if n < 5
        Lebesgue_const_CGL = 2/pi*log(n)+pi/(72*n^2);%2/pi*(log(n)+a)+pi/(72*n^2);
    else
        Lebesgue_const_CGL = 2/pi*log(n)+pi/(72*n^2);
    end
        
    fprintf(2,"Guarda il valore restituito dalla funzione per una maggior precisione!!\n");
    fprintf("Costanti di Lebesgue:\n");
    fprintf(" - polinomi caratteristici di Lagrange su nodi equispaziati: %.5g\n",Lebesgue_const);
    fprintf(" - polinomi caratteristici di Lagrange su nodi CGL: STIMATA %.5g\n",Lebesgue_const_CGL);
    fprintf("\n\n");
    if nargin < 3
        n_punti_grafico = 1001;
    end
    xax = linspace(x_nodi(1), x_nodi(end), n_punti_grafico);
    
    [~, Lebesgue_const] = funzione_caratteristica_lagrange(x_nodi, n_punti_grafico); % [opzionale: a,b]
    fprintf(2," Lebesgue ottenuto con i dati inseriti: %.5g\n",Lebesgue_const);
    
end
