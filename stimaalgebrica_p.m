function [p,c]=stimaalgebrica_p(err,hh)
    %
    % [p,c]=stimaalgebrica_p(err)
    %
    %  ----------------------
    %  |   err <= C * h^p   |
    %  ----------------------
    %
    % Stima ordine e fattore di abbattimento dell'errore
    % utilizzando le seguenti formule :
    %          
    %        | h1 |
    %     ln ------
    %        | h2 |            | E_h1 |
    % p = ------------    c = ----------
    %        | E_h1 |          |  h1  |^p  
    %     ln --------
    %        | E_h2 |
    %
    % Parametri di ingresso:
    %
    % err         Vettore contenente l'errore a vari h
    % hh          Vettore contenente i passi usati per calcolare err
    % 
    % Parametri di uscita:
    %
    % p          Vettore contenente tutte le stime dell'ordine calcolate
    % c          Vettore contenente tutte le stime del 
    %            fattore di abbattimento dell'errore

    if size(err) ~= size(hh)
        error("ATTENZIONE: le dimensioni di err e hh devono combaciare.\n");
    end

    it = max(size(err));
    p = zeros(1,length(err)-1);
    c = zeros(1,length(err)-1);

    for i = 1:it-1
      if (hh(i)==hh(i+1))
        fprintf(2,"Attenzione: due valori di hh coincidenti in posizione %d e %d.\n", i, i+1);
        break;
      else
        den=log(hh(i)/hh(i+1));
        num=log(err(i)/err(i+1));
        p(i)=num/den;
        c(i)= err(i)/(hh(i))^p(i);
      end
    end

    dim = max(size(p));
    if (it > 2)
      fprintf(' Ordine stimato       : %12.8f \n',p(dim) );
      fprintf(' Fattore di riduzione : %12.8f \n',c(dim) );  
    else
      disp(' Numero di iterazioni insufficiente !!!')
    end
end


