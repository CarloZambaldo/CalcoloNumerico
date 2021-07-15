function [m] = molteplicity(f,alpha,toll_f,toll_d,~)
    % [m] = MOLTEPLICITY(f,alpha,toll_f,toll_d,~)
    % calcola la molteplicità dello zero alpha
    %
    % input:
    % f       : funzione 
    % alpha   : valore dello zero
    %
    % se lo zero è un'approssimazione usare:
    % toll_f  :  tolleranza dello zero (errore accettabile nel valutare f(alpha))
    % toll_d  :  tolleranza per stabilire derivata n-esima in alpha == 0.
    %
    % se non viene inserita la tolleranza si assume che sia nulla,
    % se non viene inserita toll_d si assume che sia uguale a toll_f
    %
    % inserire il quinto parametro in ingresso se si vuole sopprimere l'output dei
    % valori delle derivate (sconsigliato)
    %
    % numero massimo di molteplicità calcolabile: 100
    
    if nargin == 2
        toll_f = 0;
        toll_d = 0;
    elseif nargin == 3
        toll_d = toll_f;
    end
    
    m = 0;
    nmax = 100;
    if abs(f(alpha))<=toll_f
        if f(alpha) ~= 0
            fprintf(2,"Attenzione. Il numero inserito è solo un'approssimazione dello zero.\n");
        end
        i = 1;
        der = deriva(f,i);
        if nargin <= 4
            fprintf("derivata %d^ = %f\n",i,der(alpha));
        end
        while abs(der(alpha))<=toll_d && i < nmax
            i = i+1;
            der = deriva(f,i);
            if nargin <= 4
                fprintf("derivata %d^ = %f\n",i,der(alpha));
            end
        end
        m = i;
    else
        error("Attenzione. Alpha inserito NON è uno zero.");
    end
    
    if i == nmax
        error("Numero massimo derivate raggiunto, impossibile stabilire la molteplicità.\n\n");
    else
        fprintf("La molteplicità dello zero è: %d\n\n",m);
    end
end