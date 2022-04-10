function [polin_valutati_in_riga, Lebesgue_const] = funzione_caratteristica_lagrange(x_nodi, n_punti_grafico, a,b)
    %
    % [polin_valutati_in_riga, Lebesgue_const] = funzione_caratteristica_lagrange(x_nodi, n_punti_grafico, a,b); 
    %
    %   polin_valutati_in_riga    ha come righe i phi(k) polinomi
    %   caratteristici di Lagrange
    %
    % x_nodi           =  ascisse dei nodi
    % n_punti_grafico  =  numero punti asse x, dove si volgliono valutare i nodi
    % a, b             =  estremi dell'intervallo di valutazione [opzionale]

    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    

%%
if nargin == 4
    xax = linspace(a, b, n_punti_grafico);
else
    xax = linspace(x_nodi(1), x_nodi(end), n_punti_grafico);
end

% ricavo il numero di nodi
n = length(x_nodi);
% inizializzo il polinomio di Lagrange a 0
polin_valutati_in_riga = zeros(length(x_nodi),length(xax));

% metto tutti i vettori come righe
xax = xax(:)';
x_nodi = x_nodi(:)';

%%
% calcolo i polinomi della base associati al nodo k
for k = 1:n
    % applico la proprietà L_i [x_i] = 1
    polin_valutati_in_riga(k, :)= ones(1,length(xax));
    % calcolo le altre L_i
    for j=1:n
        % faccio la produttoria di tutti i nodi j, con j diverso da k
        if j ~= k
            polin_valutati_in_riga(k, :) = polin_valutati_in_riga(k, :) .* ( (xax-x_nodi(j)) ./ (x_nodi(k)-x_nodi(j) ));
        end
    end
end

Lebesgue_const = max(sum(abs(polin_valutati_in_riga)));

%% plot

figure
hold on
plot(xax,polin_valutati_in_riga, '.-','LineWidth',1);
plot(x_nodi,0*x_nodi,'ob','LineWidth',5);
plot([xax(1) xax(end)], [0 0], '--k','LineWidth',0.5);
plot(0, 0, '+r','LineWidth',2);
grid on
title("Polinomi Caratteristici di Lagrange");

figure
hold on
plot(xax,sum(abs(polin_valutati_in_riga)), '.-','LineWidth',1);
plot(x_nodi,0*x_nodi,'ob','LineWidth',5);
plot([xax(1) xax(end)], [0 0], '--k','LineWidth',0.5);
plot(0, 0, '+r','LineWidth',2);
grid on
title("\Sigma |\phi_k| ;  max = const.Lebesgue \Lambda_n = "+num2str(Lebesgue_const));
