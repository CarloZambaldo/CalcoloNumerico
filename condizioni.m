function [] = condizioni(A, P, toll)
    % [] = condizioni(A, P, toll)
    %
    % a seconda del numero di input restituisce più o meno caratteristiche associate ad A:
    %   - numero di condizionamento e raggio spettrale
    %   - verifica le condizioni:
    %      * sufficienti per l'esistenza della fattorizzazione LU di A
    %      * condizioni sufficienti per la convergenza per i metodi di:
    %        ° Jacobi
    %        ° Gauss Seidel
    %        ° Richardson (**)
    %   - inserire P solo per metodo di Richardson (**)
    %   - inserendo toll viene calcolata la stima di iterazioni da svolgere
    %   - determina il coefficiente h tale per cui (problema di Cauchy):
    %      * Assoluta Stabilità metodo di EULERO IN AVANTI
    %      * Assoluta Stabilità metodo di HEUN
    %
    % ATTENZIONE! LA FUNZIONE POTREBBE BLOCCARSI, IN CASO INTERROMPERE
    %             L'ESECUZIONE IL PRIMA POSSIBILE (premendo CTRL+C)
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    

    
    
    
    if(size(A,1) ~= size(A,2))
        error(' non è quadrata!!')
    end
    
    n = size(A,1);
    fprintf("__________________________________________________________________\n\n");
    fprintf("__________________________ INIZIO OUTPUT _________________________\n\n");
    fprintf("__________________________________________________________________\n\n");
    %fprintf("* numero di condizionamento della matrice: %g\n", cond(A));
    controlla(A);
    fprintf("__________________________________________________________________\n\n");
    %%
    % fprintf("* condizione necessaria e sufficiente per l'esistenza della fattorizzazione LU di A:\n");
    % calcolo determinante delle sottomatrici principali \neq 0
    
    %%
    fprintf("* condizioni sufficienti per l'esistenza della fattorizzazione LU di A:\n");
    % verifico che A sia SDP
    fprintf("  - è simmetrica ");
    def_pos = 0;
    if A == A'
        fprintf("[TRUE]\n");
        
        %criterio di Sylvester
        fprintf("  - è definita positiva ");
%         for i = 1:n
%             if det(A(1:i, 1:i)) > 0 % determinante di tutte le sottomatrici
%                 if i == n % quando arrivo al termine
%                     fprintf("[TRUE] ");
%                     def_pos = 1;
%                 end
%             else % se non è verificata termino
%                 fprintf(2, "[FALSE] ");
%                 break %termina l'esecuzione
%             end
%         end
        if(eig(A) > 0)
            fprintf("[TRUE]\n");
            def_pos = 1;
        else
            fprintf(2, "[FALSE]\n");
        end
    else
        fprintf(2, "[FALSE]\n");
    end
    
    % verifico se è a dominanza diagonale per righe
    domi_stretta = 0;
    fprintf("  - è a dominanza diagonale stretta per righe ");
    if (abs(diag(A))' > sum(abs(A-diag(diag(A)))'))
        fprintf("[TRUE]\n");
        domi_stretta = 1;
    else
        fprintf(2, "[FALSE]\n");
    end
    
    % verifico se è a dominanza diagonale per colonne
    fprintf("  - è a dominanza diagonale stretta per colonne ");
    if (abs(diag(A))' > sum(abs(A-diag(diag(A)))))
        fprintf("[TRUE]\n");
    else
        fprintf(2, "[FALSE]\n");
    end
    
    
    %% altre caratteristiche
    fprintf("__________________________________________________________________\n\n");
    % verifico se è a dominanza diagonale per righe
    fprintf("  - è a dominanza diagonale per righe ");
    if (abs(diag(A))' >= sum(abs(A-diag(diag(A)))'))
        fprintf("[TRUE]\n");
    else
        fprintf(2, "[FALSE]\n");
    end
    
    % verifico se è a dominanza diagonale per colonne
    fprintf("  - è a dominanza diagonale per colonne ");
    if (abs(diag(A))' >= sum(abs(A-diag(diag(A)))))
        fprintf("[TRUE]\n");
    else
        fprintf(2, "[FALSE]\n");
    end
    
    %% metodi di Jacobi e Gauss-Seidel
    fprintf("__________________________________________________________________\n\n");
    fprintf("* condizioni sufficienti per la convergenza per i metodi di: Jacobi e Gauss Seidel\n");
    fprintf("  Per la soluzione del sistema 'Ax = b'\n");
    c = 0;
    % A non singolare e a dominanza stretta per righe -> GS e J
    if (domi_stretta ~=0) && (det(A) ~= 0)
        fprintf("  - Gauss-Seidel e Jacobi convergono entrambi\n");
        c = 1;
        if(isequal((diag(A) == zeros(n,1)), zeros(n,1))) % elementi diagonale diversi da zero
            % A non singolare, con elementi diag neq 0, tridiagonale allora J e GS
            % convergono o divergono entrambi
            fprintf("    - conviene usare il metodo di Gauss-Seidel (converge più rapidamente)\n");
        end
    end
    
    % A è simmetrica e definita positiva -> GS
    
    if (def_pos == 1)&&(isequal(A,A'))
        fprintf("  - Gauss-Seidel converge\n");
    end
    
    if c == 0
        fprintf("  - Controllo il raggio spettrale di -> B <- per determinare la convergenza.\n");

        % J,  P = diag(diag(A)) -----------------
        try
            P_inv = diag(1./diag(A));
            B = eye(n) - P_inv * A;
            rho = max(abs(eig(B)));
            fprintf("      Raggio spettrale B Jacobi: %g\n", rho);
        catch
            warning('la matrice A ha degli zeri sulla diagonale. Non posso calcolare P^-1');
        end
        
        
        % GS, P = tril(A) ---------------------
        try
            P_GS = tril(A);
        	B = eye(n) - P_GS\A;
            rho = max(abs(eig(B)));
            fprintf("      Raggio spettrale B Gauss-Seidel: %g\n\n", rho);
        catch
            warning('la matrice A ha degli zeri sulla diagonale. Non posso calcolare P^-1');
        end
        
    
    end
    
    if nargin == 3
        D_inv = diag(1 ./ diag(A));
        B_jac = eye(n) - D_inv * A;
        rho_jac = max(abs(eig(B_jac)));
        stima_k_j = ceil(log(toll)/log(rho_jac));
        fprintf("  - Stima iterazioni con metodo di Jacobi: %d\n", stima_k_j);
        
        T = tril(A);
        B_gs = eye(n) - T\A; % T\A = T^-1 * A
        rho_gs = max(abs(eig(B_gs)));
        stima_k_gs = ceil(log(toll) / log(rho_gs));
        fprintf("  - Stima iterazioni con metodo di Gauss-Seigel: %d\n", stima_k_gs);
    end
    
    %% metodi di Richardson
    if nargin >= 2
        fprintf("__________________________________________________________________\n\n");
        fprintf("* condizione necessaria e sufficiente per la convergenza del metodo di Richardson STAZIONARIO\n");
        fprintf("  Per la soluzione del sistema 'Ax = b'\n");
        if (eig(P) > 0)
            if (def_pos == 1) && (isequal(P,P'))
                fprintf("  - Converge se e solo se alpha è compreso tra: ");
                autoval = eig(P\A);
                alfa = 2./max(autoval);
                fprintf("  0 e %f\n", alfa);
                alfa_opt = 2 / (min(autoval) + max(autoval));
                fprintf("    - con alpha ottimale:  %f\n", alfa_opt);
                B_R = eye(n) - alfa_opt.*(P\A);
                % nota: rho = (cond(A)-1)/(cond(A)+1)
                rho = max(abs(eig(B_R)));
                fprintf("    - raggio spettrale matrice di iterazione 'B' per alpha ottimale:  %f\n\n", rho);
            elseif (det(A) ~= 0) && (det(P) ~= 0)
                min_alpha = min(2.*real(eig(P\A))./abs(eig(P\A)).^2);
                %fprintf("  - Converge se e solo se alpha*|autovalori(P^-1 A)|^2 < 2*Re(autovalori(P^-1 A)) forall autovalori\n");
                fprintf("  - Converge se e solo se alpha < %f\n", min_alpha);
            else
                fprintf("  - Non converge.\n\n");
            end
        elseif (det(A) ~= 0) && (det(P) ~= 0)
            min_alpha = min(2.*real(eig(P\A))./abs(eig(P\A)).^2);
            %fprintf("  - Converge se e solo se alpha*|autovalori(P^-1 A)|^2 < 2*Re(autovalori(P^-1 A)) forall autovalori\n");
            fprintf("  - Converge se e solo se alpha < %f\n", min_alpha);
        else
            fprintf("  - Non converge.\n\n");
        end
    end
    
    fprintf("__________________________________________________________________\n\n");
    fprintf("* Assoluta Stabilità metodo di EULERO IN AVANTI (Problema Di Cauchy)\n");
    L = eig(A);
    h = min(-2*real(L)./abs(L).^2);
    fprintf("  affinché sia Assolutamente Stabile:   0 < h < %.4f\n\n", h);

    
    fprintf("* Assoluta Stabilità metodo di HEUN (Problema Di Cauchy)\n");
    L = eig(A);
    if isequal(imag(L),zeros(size(L)))
        h_H = min(2./(abs(L)));
        fprintf("  affinché sia Assolutamente Stabile:   0 < h < %.4f\n", h_H);
    else
        fprintf("  affinché sia Assolutamente Stabile:\n     Attenzione! sono presenti autovalori con parte immaginaria!\n");
    end  
    
    
        st = min(real(L))/max(real(L));
    fprintf("\n\n  coeff. di stiffness:   %.4f  ", st);
    
    if st > 1
        fprintf(2," (il problema potrebbe essere stiff!)\n");
    else
        fprintf(" (il problema non è stiff!)\n");
    end
    
    fprintf("__________________________________________________________________\n\n");
    fprintf("___________________________ FINE OUTPUT __________________________\n\n");
    fprintf("__________________________________________________________________\n\n");
    
end
