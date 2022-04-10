function [t, u, w] = leap_frog(f, tv, y0, w0, h, Nh)
    % [t, u, w] = leap_frog(f, tv, y0, w0, h, Nh)
    %
    % implementazione metodo Leap Frog per la risoluzione di ODE di secondo grado
    % h   =  ampiezza sottointervalli
    % Nh  =  numero di intervalli + 1  (*)
    % tv  =  [t0 tf]
    %
    % NOTA: f = f(t,y,v)
    % dove v = y'
    %
    % metodo implicito, utilizzo iterazioni di punto fisso per risolvere 
    % l'equazione non lineare.
    %
    % NOTA (*): se viene inserito Nh il valore dichiarato per h viene ignorato 
    % e la funzione ricalcola h come:   h = (tv(2) - tv(1))/Nh
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    
    N_max = 1000;
    toll = 1e-6;
    
    t0 = tv(1);
    tf = tv(2);
    
    if nargin > 5
        h = (tv(2) - tv(1))/Nh;
    end
    
    t = [t0:h:tf];
    
    Nh = length(t)-1; %numero intervalli
    u = zeros(1, Nh+1);
    w = zeros(1, Nh+1);
    
    
    u(1) = y0;
    w(1) = w0;
    
    for n = 1:Nh % ATTENZIONE ! Nh = numero di intervalli!!
        
        u(n+1) = u(n) + h*w(n) + (h^2)/2 * f(t(n),u(n),w(n));
        
        % risolvo il sistema non lineare con PTOFIS
        % v_(n+1) = v_(n) + h/2 * [f(t_(n), u_(n), v_(n)) + f(t_(n+1), u_(n+1), v_(n+1))] = phi(u_(n+1))
        
        phi = @(w_req) w(n) + h/2 * ( f(t(n), u(n), w(n)) + f(t(n+1), u(n+1), w_req) );
        [w_req, it_pf] = ptofis(w(n), phi, N_max, toll);
        
        if it_pf == N_max 
            error("Raggiunto numero massimo di iterazioni!");
        end
        
        w(n+1) = w_req(end);
    end
    
end
