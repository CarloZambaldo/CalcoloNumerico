function [funzione, h, x_j, c_tilde_k] = interp_trigo(f, n, periodo)
    % [funzione, h, x_j, c_tilde_k] = interp_trigo(f, n, periodo)
    %
    % n    =  numero di intervalli
    % x_j  =  j*h
    % h    =  periodo / (n+1);
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    
    
    format rat;
    h = periodo/(n+1);
    x_j = [0:h:n*h];
    
    % calcolo tutti i coefficienti
    if mod(n,2) == 0 % n è pari
        M = n/2;
        mu = 0;
    else
        M = (n-1)/2;
        mu = 1;
    end
    
    % c_tilde_k = array di coefficienti (sono 2*(M+mu))
    n_coeff = 2*(M+mu)+1;
    offset = M+mu+1; % centro i coefficienti nel vettore
    fprintf("Calcolo %d coefficienti\n",n_coeff);
    
    c_tilde_k = zeros(1,n_coeff);
    c_k = zeros(1,n_coeff);
    
    % calcolo c_k
    for j = 0:n
        for k = -(M+mu):(M+mu)
            c_k(k+offset) = c_k(k+offset) + f(x_j(j+1)).*( cos(k*j*h) + sqrt(-1)*sin(-k*j*h) );
        end
    end
    c_k = c_k./(n+1);
    
    % SE n DISPARI:
    if mod(n,2)~=0
        % primo coefficiente
        k = -(M+1);
        c_tilde_k(k+offset) = c_k(k+offset)/2;
        
        % ultimo coefficiente
        k = M+1;
        c_tilde_k(k+offset) = c_k(k+offset)/2;
    end
    
    %coefficienti in mezzo
    for k = -M:M %
        c_tilde_k(k+offset) = c_k(k+offset);
    end
    
    f_string = "@(x)";
    % comporre l'interpolante
    for k = -(M+mu):(M+mu)
        %f_prov = @(x) c_tilde_k(k+offset) .* ( cos(k.*x) + sqrt(-1).*sin(k.*x) );
%         if imag(c_tilde_k(k+offset)) == 0
%             fprintf("(%g) * ", real(c_tilde_k(k+offset)));
%         else
%             fprintf("(%g + %gi) * ", real(c_tilde_k(k+offset)), imag(c_tilde_k(k+offset)));
%         end

        stringa = "("+num2str(c_tilde_k(k+offset)) +") * ( cos(" + num2str(k) + "*x)" + " + sqrt(-1)*sin(" + num2str(k) + "*x) )";
        %fprintf(stringa(5:end));
        f_string = f_string + " + " + stringa;
%         if k ~= M+mu
%             fprintf(" + ");
%         end
    end
    funzione = str2func(f_string);
    fprintf("\n\n");
    
    %% SEMPLIFICO LA FUNZIONE OTTENUTA
    syms X;
    funzione = funzione(X);
    funzione = simplify(funzione);
    funzione = matlabFunction(funzione);
end   
        
        
