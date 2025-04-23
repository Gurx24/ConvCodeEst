%%%%%%%%%%%%%%%%%%%%% ccpbrV2.m %%%%%%%%%%%%%%%%%%%%%%%%
%
% This program is used for blind recognition of 
% convolutional code parameters including 
% synchronization position, input numbers, 
% constraint length and check matrix.
%
% date: 2025.3.12  GuRX
%
% [t, k, L, H] = ccpbrV2(r, n, na)
%
% ******************************************
% r  : received sequence with errors
% n  : number of output port
% na : the smallest column value of
%      observation matrix rank deficit
% t  : synchronization position
% k  : number of input port
% L  : constraint length
% H  : check matrix
% ******************************************

function [t, k, L, H] = ccpbrV2(r, n, na)

beta = 0.3;                                 % threshold
H    = [];                                  % check matrix

for i  = [na, na-n]
    for k = 1 : n-1
        for Z = 1 : n-k
            L = i/n * (n-k) - Z;
            l = (L+1) * n;
            u = 100;
            for t = 1 : n
                rt   = r(t:t+u*l-1);
                Rl   = reshape(rt, [l,u]).';
                flag = zeros(n-k, 1);                  % flag bit
                for s = 1 : n - k
                    idx = [1:k k+s];
                    for ii = 1 : L
                        idx = [idx, ii*n+1:ii*n+k, ii*n+k+s];
                    end
                    Rs = Rl(:, idx);
                    w  = 1;
                    while flag(s) == 0 && w <= 10
                        ridx = randperm(size(Rs, 1));  % rand index
                        Rs   = Rs(ridx, :);            % randomly swap rows
                        w    = w + 1;
                        [~, Xs, Bs] = gjetp(Rs);
                        ll   = size(Bs, 1);
                        Xl   = Xs(ll+1:end, :);
                        W    = sum(Xl);
                        for j = 1 : ll
                            if W(j) < (u-ll)/2 * beta && Bs(ll,j) == 1
                                H(s, :) = Bs(:, j).';
                                flag(s) = 1;
                            end
                        end
                    end
                end
                if all(flag(1:n-k)==1)
                    return;
                end
            end
        end
    end
end

%************************ end of file *****************************

