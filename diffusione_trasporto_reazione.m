function [x_nodi,uh] = diffusione_trasporto_reazione(N, f, mu, eta, sigma, a, b, alpha, beta)
    % [x_nodi,uh] = diffusione_trasporto_reazione(N, f, mu, eta, sigma, a, b, alpha, beta)
    %
    % N     =   numero di intervalli
    % N+1   =   numero di NODI
    %
    % ------------------------------------------------
    % risolve il problema:
    % -mu * u''(x) + eta * u'(x) + sigma * u(x) = f(x)
    % u(a) = alpha
    % u(b) = beta
    % ------------------------------------------------
    %
    %
    % NOTA: utilizza la funzione thomas per risolvere il sistema linare!
    % ATTENZIONE! può essere scritta come sigma = @(x) funzione(x)
    
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    
    
    %% intro
    if ~isa(sigma,'function_handle') 
        sigma = str2func("@(x)"+num2str(sigma)+" + 0.*x");
    end
    
    if ~isa(f,'function_handle')
        f = str2func("@(x)"+num2str(f)+" + 0.*x");
    end
    
    fprintf("PROBLEMA INSERITO:\n");
    fprintf("  -%.3g * u''(x) + %.3g * u'(x) + sigma(x) * u(x) = f(x)\n",mu,eta);
    fprintf("  x(%.3g) = %.3g\n",a,alpha);
    fprintf("  x(%.3g) = %.3g\n",b,beta);
    fprintf("  f(x) = "+func2str(f)+"\n");
    fprintf("  sigma(x) = "+func2str(sigma)+"\n\n");
    
    %% soluzione
    h = (b-a)/(N+1);
    x_nodi = (linspace(a,b,N+2))';
    
    A = mu/h^2 * tridiag(-1,2,-1,N) + eta/(2*h) * tridiag(-1, 0, 1, N) + sigma(x_nodi(2:end-1)).*eye(N);
    
    b_vect = f(x_nodi(2:end-1));
    b_vect(1) = b_vect(1) + (mu/h^2 + eta/(2*h))*alpha;
    b_vect(end) = b_vect(end) + (mu/h^2 - eta/(2*h))*beta;
    
    if max(size(A)) ~= length(b_vect)
        error("Dimensioni di A e b_vect non compatibili! (A = %dx%d), (b_vect = %dx%d)",size(A,1),size(A,2),size(b_vect,1),size(b_vect,2));
    end
    %uh = A\b_vect;
    [~, ~, uh] = thomas(A, b_vect); % risolvo con il metodo di thomas
    uh = [alpha; uh; beta];
    
    %% stampo note
    
    if abs(eta)*h/(2*mu) > 1
        fprintf("Nota: il trasporto domina localmente sulla diffusione\n");
    end
    
    max_sigma = max(sigma(x_nodi));
    numero = max_sigma*h^2/(6*mu);
    if numero > 1
        fprintf("Nota: in qualche nodo la reazione domina localmente sulla diffusione\n");
    end
    
    if mu ~= 0
        Peh = abs(eta)*h/(2*mu);
    else
        Peh = 0;
    end
    if Peh ~= 0
        fprintf("Numero di Peclet locale: ");
    end
    if Peh >= 1 || numero >=1 % possibili instabilità, suggerisco una viscosità artificiale
        fprintf(2,"%.4g\n", Peh);
        muh_UP = mu * (1+Peh);
        muh_SG = mu * (1+(Peh-1+(2*Peh)/(exp(2*Peh)-1)));
        fprintf("Per ridurre possibili instabilità usare:\n");
        fprintf("  Viscosità artificiale (metodo UPWIND): mu = %.4g\n", muh_UP);
        fprintf("  Viscosità artificiale ottimale (Scharfetter-Gummel): mu = %.4g\n", muh_SG);
    else
        fprintf("%.4g\n", Peh);
    end
    
    fprintf("\n---\n");
    
    figure
    plot_soluzione(x_nodi,uh)
    
end
