%%%%%%%%%%%%%%%%%%%%% ccpbr_1.m %%%%%%%%%%%%%%%%%%%%%%%%
%
% This program is used for blind recognition of 
% convolutional code parameters including 
% input numbers, constraint length and check matrix.
%
% date: 2025.4.18  GuRX
%
% [k, L, H] = ccpbr(r, n, na)
%
% ******************************************
% r  : received sequence with errors
% n  : number of output port
% na : the smallest column value of
%      observation matrix rank deficit
% k  : number of input port
% L  : constraint length
% H  : check matrix
% ******************************************

function [k, L, H] = ccpbr_1(r, n, na)

beta = 0.3;                                 % threshold
H    = [];                                  % check matrix

for k = 1 : n-1
    for Z = 1 : n-k
        L = na/n * (n-k) - Z;
        for s = 1 : n - k
            u   = floor(length(r)/n);
            R   = reshape(r, [n, u]).';
            R1  = R(:, [1:k k+s]);
            r1  = reshape(R1.', 1, []);
            l   = (L+1)*(k+1);
            u   = 100;
            Rl  = reshape(r1(1:l*u), [l,u]).';
            [~, X, B] = gjetp(Rl);
            Xl  = X(l+1:end, :);
            W   = sum(Xl);
            for j = 1 : l
                if W(j) < (u-l)/2 * beta && B(l,j) == 1
                    H(s, :) = B(:, j).';
                end
            end
        end
    end
end
