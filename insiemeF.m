function [] = insiemeF(beta,t,L,U,num)
    
%     F = F(beta, t, L, U)
%     beta = base
%     t = n. di cifre
%     L = estremo inferiore
%     U = estremo superiore
%     num = numero (se inserita, calcola la distanza con elemento
%     successivo) va inserito in base decimale.
%
%     nota: segno
%          s = 0 segno '+'
%          s = 1 segno '-'
%     una mantissa (xxxxxx), l'esponente -> trasforma mantissa in dec e
%     moltiplica per 2^(e-t)
%     con t numero di elementi della mantissa

    epsilon_macchina = beta .^ (1 - t);
    x_min = beta .^ (L - 1);
    x_max = beta .^ U .* (1- beta .^ (- t));
    nnum = 2 .* (beta - 1) .* beta .^ (t - 1) .* (U - L + 1);
    
    fprintf("-----\n");
    fprintf("epsilon_macchina = %g\n", epsilon_macchina);
    fprintf("x max = %f\n", x_max);
    fprintf("x min = %f\n", x_min);
    fprintf("cardinalità di F: %d\n", nnum);
    fprintf("-----\n");
    
    
    if nargin == 5
        %% trasformo la parte decimale del numero
        k_max = -20; % numero massimo decimali
        k = -1; % esponente
        decimal = [''];
        x = mod(num,1); % numero da trasformare
        resto = 1;
        while resto~=0 && k>=k_max
            resto = mod(x, 2^k);
            if resto == 0 && x~=0;
                decimal(abs(k)) = '1';
                x = x-2^k;
            elseif resto~=0
                if x > 2^k
                    decimal(abs(k)) = '1';
                    x = x-2^k;
                else
                    decimal(abs(k)) = '0';
                end
                %x = mod(x, 2^k);
            end
            k = k-1;
        end
        decimal = [decimal '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0'];
        
        %% trasformo la parte intera del numero minimo:
        x = num - mod(num,1); % rimuovo la parte decimale
        intera = dec2bin(x);

        len_decimal = length(decimal);
        len_intera = length(intera);
        
        while len_intera < t
            intera = ['0' intera];
            len_intera = length(intera);
        end

        numero = [intera '.' decimal]
        len_numero = length(numero);
        
        i = 1;
        esponente = 0;
        
        while numero(1) == '0'
            if i <= len_intera
                numero = [intera(i:len_intera) decimal(1:(t-len_intera+i-1))];
                esponente = esponente-1;
            else
                numero = [decimal(i-t:i-1)];
                esponente = esponente-1;
            end
            i = i +1;
        end
        mantissa_numero = numero
        esponente = esponente+1;
    
    %% calcolo la mantissa successiva

        if (num > x_max || num < x_min) || (num == x_max)
            if (num == x_max)
                fprintf(2, "Attenzione! Il numero inserito corrisponde al massimo rappresentabile.\n\n");
            else
                fprintf(2,"numero %f non contenuto nell'insieme.\n", num);
            end
        else
            % m contiene il numero inserito (mantissa),
            % m1 calcolato +1
            m = mantissa_numero;
            j=length(m);
            while j<t
                m = [m '0'];
                j = j+1;
            end
            m1 = m;
            m1_num = str2num(m1);
            
            if str2num(m1(end))<beta-1 || m1(end)=='0' % se posso sommare 1
                m1(end) = m1(end) + 1;
            else
                m1(end-1) = num2str(str2num(m1(end-1))+1);
                m1(end) = '0';
                j = j-1;
                while str2num(m1(j))>=beta && j > 2
                    m1(j) = '0';
                    m1(j-1) = num2str(str2num(m1(j-1))+1);
                    j = j-1;
                end
                if str2num(m1(1)) >= beta;
                    m1(1) = '0';
                    m1 = ['1' m1];
                end
            end
            m
            m1
            
            
            x1 = bin2dec(m1) * (beta^(esponente));
            epsilon_num = x1-num;
            
            if epsilon_num == 0
                fprintf("An error has occurred. \n");
            else
                fprintf("La differenza tra %f e %f è: %.8f\n",num,x1,epsilon_num);
            end
        end
    end
    
end