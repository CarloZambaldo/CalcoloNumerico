function [] = stability_region_contour(R,a,b,n_punti)
    % [] = stability_region(R)
    %
    % disegna solo il contorno della regione di stabilità 
    % R = funzione di stabilità: R = R(z)
    %
    % funzione analoga a stability_region (si rimanda all'help di questa).
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    
    
    if ~(nargin>1)
        a = -5;
        b = 5;
    end
    if nargin < 4
        n_punti = 1001;
    end
    x = linspace(a, b, n_punti);
    y = linspace(a, b, n_punti);
   
    [X, Y] = meshgrid(x,y);
%     figure
%     surf(X,Y,abs(R(X+1i*Y)),'Lines','no');
%     colormap hot
    
    %figure
    contourf(X, Y, abs(R(X+1i*Y)), [0.9999 1],'b', 'LineWidth',1);
    colormap bone
    hold on
    plot([a b], [0 0], 'r--', [0 0],  [a b],'r--','LineWidth',1);
    title("Regione di Assoluta Stabilità");
    xlabel("Reale");
    ylabel("Immaginario");
    grid on
    axis equal
