function [x_k] = CGL(a,b,grado)
    % [x_k] = CGL(a,b,grado)
    % 
    % grado+1 = numero di nodi
    %
    % funzione per il calcolo dei nodi di CHEBYSHEV-GAUSS-LOBATTO
    % restituisce un vettore del tipo:
    % x_k = [x_0, x_1, ..., x_n];
    %

    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.

    x_i = @(i) -cos((pi/grado)*i);
    if a ~= -1 && b ~=1
        function_x_k = @(i)(a+b)/2 +(b-a)/2 * x_i(i);

        x_k = [];
        for i = 0:grado
            x_k(end+1) = function_x_k(i);
        end
    else
        x_k = x_i(0:grado);
    end
end
