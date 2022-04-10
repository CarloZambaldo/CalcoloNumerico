function [t_h, u_h]=runge_kutta(f,t_max,y_0,h,B)
    %[t_h, u_h]=runge_kutta(f,t_max,y_0,h,B)
    %
    % Risolve il problema di Cauchy:
    %   y' = f(y,t)
    %   y(0) = y_0
    %
    % utilizzando il metodo di Runge-Kutta avendo fornito l'array di Butcher. 
    %
    % Input:
    % -> f: function che descrive il problema di Cauchy (dichiarata ad esempio tramite 
    %       inline o @) deve ricevere in ingresso due argomenti: f=f(t,y)
    % -> t_max: l'istante finale dell' intervallo temporale di soluzione 
    %           (l'istante iniziale e' t_0=0)
    % -> y_0: il dato iniziale del problema di cauchy: y(t=0)=dato_iniziale
    % -> h: l'ampiezza del passo di discretizzazione temporale.
    % -> B: ARRAY DI BUTCHER (nota: l'elemento in posizione ultima riga,
    %       prima colonna viene ignorato (non fa parte dell'array di Butcher)
    %
    %          c | A
    %     B = -------
    %            | b'
    %
    % Output:
    % -> t_h: vettore contenente gli istanti in cui si calcola la soluzione discreta
    % -> u_h: la soluzione discreta calcolata nei nodi temporali t_h
    %
    % NOTA:
    %   se B = [0 0; ~ 1]  ->  metodo EA
    %   se B = [0 0 0; 1 1 0; ~ 0.5 0.5]  ->  metodo H
    %   se B = [0 0 0 0 0; 0.5 0.5 0 0 0; 0.5 0 0.5 0 0; 1 0 0 1 0; ~ 1/6 1/3 1/3 1/6] 
    %        -> metodo RK4 (usa Runge_Kutta_4)
    %     
    % 
    % NOTA:
    %        se sum(b) = 1  <-> il metodo RK è CONSISTENTE

    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    

    % vettore degli istanti in cui risolvo la edo
    t0=0;
    t_h=t0:h:t_max;

       
    % estraggo i vettori dalla B
    c = B(1:end-1, 1);
    b = B(end, 2:end);
    A = B(1:end-1, 2:end);
    
    s = length(c);
    
    % controllo se il metodo è implicito
    if ~isequal(triu(A), zeros(size(A,1)))
        error("Attenzione! Questo metodo di Runge Kutta NON è esplicito!");
    end
    
    
    % inizializzo il vettore che conterra' la soluzione discreta
    N_istanti=length(t_h);
    u_h=zeros(1,N_istanti);

    u_h(1)=y_0;
   
    % calcolo la soluzione
    for n = 2:N_istanti
        % calcolo i coefficienti K_i
        K_i = zeros(1,s);
        for i = 1:s
            time = t_h(n-1) + c(i)*h;
            sommat = 0;
            for j = 1:s
                sommat = sommat + A(i,j) * K_i(j);
            end
            uun  = u_h(n-1) + h*sommat;
            K_i(i) = f(time, uun);
        end

        % calcolo la soluzione
        u_h(n) = u_h(n-1) + h * sum(b .* K_i);
    end
    
    if sum(b) == 1
        fprintf("\nIl metodo è consistente!\n");
    end
end
