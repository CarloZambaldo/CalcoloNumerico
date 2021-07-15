function [x_nodi,uh] = diffusione_trasporto_reazione_DN(N, f, mu, eta, sigma, a, b, alpha, gamma, ordine)
    % [x_nodi,uh] = diffusione_trasporto_reazione_DN(N, f, mu, eta, sigma, a, b, alpha, gamma, ordine)
    %
    % nota: se la condizione sulla derivata prima è in a usare la funzione
    % diffusione_trasporto_reazione_ND   (dove ND indica l'ordine delle
    % condizioni (Neumann-Dirichlet) LO SCHEMA ATTUALE RICHIEDE DIRICHLET
    % NELL'ESTREMO INFERIORE E NEUMANN IN QUELLO SUPERIORE
    % N = numero di intervalli
    % N+1 = numero di NODI
    %
    % risolve il problema:
    % -mu * u''(x) + eta * u'(x) + sigma * u(x) = f(x)
    % u(a) = alpha
    % mu * u'(b) = gamma  (**)
    %
    % NOTA: utilizza la funzione thomas per risolvere il sistema linare!
    % ATTENZIONE! può essere scritta come sigma = @(x) funzione(x)
    %
    % NOTA: ordine = ordine dello schema (può essere 1 o 2).
    %  ordine = 1 -> approssimo la (**) con schema DF indietro
    %  ordine = 2 -> approssimo la (**) con schema DF (de)centrate
    
    
    %% intro
    if ~isa(sigma,'function_handle')
        sigma = str2func("@(x)"+num2str(sigma)+" + 0.*x");
    end
    if ~isa(f,'function_handle')
        f = str2func("@(x)"+num2str(f)+" + 0.*x");
    end
    
    if nargin < 10
        error("INSERIRE L'ORDINE DELLA FORMULA!");
    end
    if ordine > 2 || ordine <= 0
        error("Attenzione: l'ordine deve essere o 1 o 2!!!");
    end
    
    fprintf("\n---\n");
    fprintf("PROBLEMA INSERITO:\n");
    fprintf("  -%.3g * u''(x) + %.3g * u'(x) + sigma(x) * u(x) = f(x)\n",mu,eta);
    fprintf("  x(%.3g) = %.3g\n",a,alpha);
    fprintf("  %.3g * x'(%.3g) = %.3g\n",mu,b,gamma);
    fprintf("  f(x) = "+func2str(f)+"\n");
    fprintf("  sigma(x) = "+func2str(sigma)+"\n\n");
    fprintf("ordine dello schema: %d\n\n", ordine);
    
    %% soluzione
    h = (b-a)/(N+1);
    x_nodi = (linspace(a,b,N+2))';
    
    A1 = mu/h^2 * tridiag(-1,2,-1,N) + eta/(2*h) * tridiag(-1, 0, 1, N) + sigma(x_nodi(2:end-1)).*eye(N);
    A = [A1, zeros(N,1); zeros(1, N+1)];
    
    b_vect = [f(x_nodi(2:end-1)); gamma];
    b_vect(1) = b_vect(1) + (mu/h^2 + eta/(2*h))*alpha;
        
    if ordine == 1 %% SCHEMA ORDINE 1
        A(end-1, end) = -mu/h^2 + eta/(2*h);
        A(end,end) = mu/h;
        A(end, end-1) = -mu/h;
    end
    
    if ordine == 2 %% SCHEMA ORDINE 2
        A(end-1, end) = -mu/h^2 + eta/(2*h);
        A(end,end) = 3*mu/(2*h);
        A(end, end-1) = -4*mu/(2*h);
        A(end, end-2) = mu/(2*h);
    end
    
    A = sparse(A);
    
    uh = A\b_vect;
    uh = [alpha; uh];
    
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
    
    plot_soluzione(x_nodi,uh)
    
end