%%%%%%%%%%%%%%%%%%%%%%%%% gjetp.m %%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function convert a matrix into a lower triangular matrix in GF(2).
% A Gauss-Jordan elimination through pivoting algorithm 
% based on algebraic properties of convolutional codes.
% 
% date:2025.3.14 GuRX
%
% [A, L, B] = gjetp(X)
%
% **********************************************************
% L = A*X*B
% X : matrix of input
% A : record the row transformations during elimination
% B : record the column transformations during elimination
% L : matrix of lower triangular
% **********************************************************

function [A, L, B] = gjetp(X)

[u, n] = size(X);
A = eye(u);
B = eye(n);
L = A * X * B;
for i = 1 : n
    if L(i, i) == 0
        for ii = i + 1 : n
            if L(i, ii) == 1
                B(:, [i, ii]) = B(:, [ii, i]);
                break;
            end
        end
    end
    L = mod(A * X * B, 2);
    if L(i, i) == 0
        for ii = i + 1 : u
            if L(ii, i) == 1
                A([i, ii], :) = A([ii, i], :);
                break;
            end
        end
    end
    L = mod(A * X * B, 2);
    if L(i, i) == 1
        for ii = i + 1 : n
            if L(i, ii) == 1
                B(:, ii) = xor(B(:, i), B(:, ii));
            end
        end
    end
    L = mod(A * X * B, 2);
end

%*************************** end of file **************************