function [T] = tridiag(a, b, c, n)
        % [T] = tridiag(a, b, c, n)
        % tridiag  Tridiagonal matrix.
        % T = tridiag(a, b, c, n) returns an n by n matrix that has 
        % a, b, c as the subdiagonal, main diagonal, and superdiagonal 
        % entries in the matrix.
        
    % Software by Carlo Zambaldo (info@carlozambaldo.it)
    % This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
    

        T = b*diag(ones(n,1)) + c*diag(ones(n-1,1),1) + a*diag(ones(n-1,1),-1);
end
