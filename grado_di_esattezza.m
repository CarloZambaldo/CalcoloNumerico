function [] = grado_di_esattezza(formula,estr_i,estr_s)
    % [] = grado_di_esattezza(formula,estr_i,estr_s)
    %
    % formula è un'anonymous function in funzione della funzione
    %     esempio:   formula = @(f) .... f(3) + ... - f(1/2) ...
    %
    % estr_i, estr_s sono gli estremi di integrazione
    %
    % esempio:
    %    a = -12;
    %    b = 7;
    %    formula = @(f) (b-a) * f((a+b)/2)
    %    grado_di_esattezza(formula,a,b);
    %
    % si noti che gli estremi a e b possono essere messi "a caso", ma 
    % sempre con a<b
    
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    

    
    fprintf("-----------------------------------");
    syms a b c d e f g h m n o p q r s t u v z x
    coeff = [a, b, c, d, e, f, g, h, m, n, o, p, q, r, s, t, u, v, z];
    check = 0;
    grado_max = length(coeff);
    grado_real = -1;
    for grado = 1:grado_max % nota non è il grado, ma il grado +1
        poli_sim = poly2sym(flip(coeff(1:grado)));
        poli = matlabFunction(poli_sim,'Vars',{x,coeff(1:grado)});
        
        I_ex = int(poli_sim, x, [estr_i,estr_s] );

        Iq = formula(@(x)poli(x,coeff(1:grado))); %% QUESTA E' LA FORMULA DI INTEGRAZIONE
        
        fprintf("\nPolinomio di grado %d  -> ("+sym2str(poli_sim)+") \n",grado-1);
        fprintf("  I_formula = "+sym2str(Iq)+"\n");
        fprintf("  I_esatta  = "+sym2str(I_ex)+"\n");

        if Iq ~= I_ex
            if grado_real == -1
                grado_real = grado;
            end
            sr = input("\nProseguire con i tentativi? [s/n] : ");
            if sr ~= "s"
                break;
            else
                check = 1;
            end
        end
    end
    
    if check == 1
        fprintf("Attenzione: si è forzato il numero di iterazioni fino al grado: %d\n",grado-1);
        fprintf("\nGrado calcolato inizialmente: %d\n",grado_real-2);
    else
        if grado == grado_max && Iq == I_ex
            fprintf("\nLa formula è esatta ALMENO di grado: %d\n",grado_real-1);
        else
            fprintf("\nLa formula è esatta di grado: %d\n",grado_real-2);
        end
    end
    fprintf("-----------------------------------\n");
end
