function p_fun = poly2func(p_vect)
    p = symfun(p_vect);
    p_fun = matlabFunction(p);
end