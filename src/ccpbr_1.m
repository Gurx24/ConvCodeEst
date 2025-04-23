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
