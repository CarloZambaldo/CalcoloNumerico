function [] = stability_region(R,a,b,n_punti)
    % [] = stability_region(R)
    % disegna la regione di stabilità 
    % R = funzione di stabilità: R = R(z)
    %
    % R notevoli:
    %
    %   EA  :  R = @(z) 1+z;
    %   EI  :  R = @(z) 1/(1-z);
    %   CN  :  R = @(z) (1+0.5*z)./(1-0.5*z);
    %   H   :  R = @(z) 1+z+z.^2/2;
    %
    % PER AVERE STABILITA':
    % abs(R(h*lambda)) < 1

    
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
    figure
    surf(X,Y,abs(R(X+1i*Y)),'Lines','no');
    colormap hot
    
    figure
    contourf(X, Y, abs(R(X+1i*Y)), [0 1], 'LineWidth',1);
    colormap bone
    grid on
    hold on
    axis equal
    
    plot([a b], [0 0], 'r--', [0 0],  [a b],'r--','LineWidth',1);
    title("Regione di Assoluta Stabilità");
    %legend("Regione di Assoluta Stabilità");
    xlabel("Reale");
    ylabel("Immaginario");