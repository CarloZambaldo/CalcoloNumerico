function [] = plot_soluzione(t, y)
    % stampa un grafico sul piano t-y
    %
    % input : t e y (discreti)
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    
    plot(t,y,'.-','LineWidth',1);
    hold on
    plot([t(1) t(end)], [0 0], '--k','LineWidth',0.5);
    plot(0, 0, '+r','LineWidth',2);
    xlabel(inputname(1));
    ylabel(inputname(2));
    hold off
    grid on
    
    % disegno la soluzione in spazio di stato
    if min(size(y)) == 2 && length(t) > 10
        figure
        hold on
        if size(y,1) > size(y,2)  % ovvero il tempo è lungo le righe
            y = y';
        end
        plot(y(1,:),y(2,:),'.-','LineWidth',1);
        plot(0, 0, '+r','LineWidth',2);
        xlabel(inputname(2)+"(1)");
        ylabel(inputname(2)+"(2)");
        title("Spazio di Stato (2D)");
        grid on
        hold off
    end
    
    if min(size(y)) == 3 && length(t) > 10
        figure
        hold on
        if size(y,1) > size(y,2)  % ovvero il tempo è lungo le righe
            y = y';
        end
        plot3(y(1,:),y(2,:),y(3,:),'.-','LineWidth',1);
        plot3(0, 0, 0, '+r','LineWidth',2);
        xlabel(inputname(2)+"(1)");
        ylabel(inputname(2)+"(2)");
        zlabel(inputname(2)+"(3)");
        title("Spazio di Stato (3D)");
        grid on
        hold off
    end
    
    
    
        
end
