function [T] = pentadiag(a, b, c, d, e, n)
        % [T] = pentadiag(a, b, c, d, e, n)
        % pentadiag  Pentadiagonal matrix.
        % returns an n by n matrix that has 
        % a, b, c, d, e as the subsubdiagonal, subdiagonal, main diagonal,
        % superdiagonal and supersuperdiagonal
        % entries in the matrix.

        T = c*diag(ones(n,1)) + d*diag(ones(n-1,1),1) + b*diag(ones(n-1,1),-1) + ...
            a*diag(ones(n-2,1),-2) + e*diag(ones(n-2,1),2);
end