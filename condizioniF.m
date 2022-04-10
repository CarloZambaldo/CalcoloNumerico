function [] = condizioniF(f, alpha, a, b, n_pti)
    % [] = condizioniF(f, alpha, a, b, n_pti)
    %
    %  f      =  funzione
    %  alpha  =  zero della funzione
    %  [a,b]  =  intervallo di plot (può essere omesso)
    %  n_pti  =  numero di punti nell'intervallo a,b (se non inserito = 1001)
    
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    

    funzione(f);
    
    if nargin == 2 && abs(f(alpha))<=0.5 % tolleranza preimpostata
        %fprintf("Molteplicità dello zero: %d", molteplicity(f,alpha,1,1e-4,1));
    end
    
    fprintf("-------------------------------------\n");
    fprintf("Interpreto la funzione inserita come phi(x) iter. pto fisso\n\n");
    phi = f;
    dphi = deriva(phi,1);
    if nargin >= 2
        fprintf("Iterazioni di punto fisso:\n");
        if abs(dphi(alpha))<1
            fprintf(" - Convergono se x0 suff. vicino  [ abs(dphi(alpha)) <1 ]\n");
        elseif abs(dphi(alpha))>1
            fprintf(" - NON convergono     [ abs(dphi(alpha)) >1 ]\n");
        elseif abs(dphi(alpha))==1
            fprintf(" - NON è DETTO CHE CONVERGA (dipende da x0 e phi(I)\n");
        end
    end
    
        % disegno l'inviluppo e controllo a vista se viene soddisfatta
    % l'ipotesi di convergenza globale
    if nargin < 5
        n_pti = 1001;
    end
    if nargin >= 4
        fprintf("Teorema convergenza globale metodo iter. pto fisso\n");
        % th. convergenza globale
        c = 1;
        for i = linspace(a,b,n_pti)
            if phi(i)<=a|| phi(i)>=b
                fprintf(2," - Prima condizione non soddisfatta\n");
                c = 0;
                break
            end
        end
        
        for i = linspace(a,b,n_pti)
            if abs(dphi(i)) >= 1
                fprintf(2," - Derivata in modulo superiore a 1\n");
                c = 0;
                break
            end
        end

        if c == 1
            fprintf(" - Tutte le condizioni soddisfatte, esiste almeno un pto fisso\n");
        end

        figure
        subplot(1,2,1)
        hold on
        grid
        x = linspace(a,b,n_pti);
        plot(x,phi(x))
        plot([a b],[a a],'r');
        plot([a b],[b b],'r');
        plot([b b],[a b],'r');
        plot([a a],[a b],'r');
        title("\phi (x)");
        
        subplot(1,2,2)
        hold on
        grid
        plot(x,abs(dphi(x)))
        plot([a b],[1 1],'r');
        title("|\phi ' (x)|");
    end
    
       
    fprintf("-------------------------------------\n");
    if nargin >=2
        p = molteplicity(@(x) phi(x)-alpha,alpha,1e-3,0.1);
        fprintf("Per x0 suffic. vicino il metodo delle iter di pto fisso converge con ordine: %d\n",p);
    end
    
end
