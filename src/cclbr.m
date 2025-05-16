%%%%%%%%%%%%%%%%%%%%% cclbr.m %%%%%%%%%%%%%%%%%%%%%%%%
%
% This program is used for blind recognition of 
% convolutional code parameters of code length.
%
% date: 2025.3.15  GuRX
%
% [n, na] = cclbr(r)
%
% ******************************************
% r  : received sequence with errors
% n  : number of output port
% na : the smallest column value of
% ******************************************

function [n, na] = cclbr(r)

lm   = 60;              % max number of column
u    = 300;             % number of row
beta = 0.4;             % threshold
n    = zeros(1, lm);    % initial number of correlated column

for l = 2 : lm
    rt        = r(1:u*l);
    Rl        = reshape(rt, [l, u]).';
    [~, X, ~] = gjetp(Rl);
    Xl        = X(l+1 : end, :);
    w         = sum(Xl);
    for i = 1 : l
        if w(i) < (u-l)/2 * beta
            n(l) = n(l) + 1;
        end
    end
end

% figure;
% stem(n);
% xlabel('column $l$', 'Interpreter', 'latex');
% ylabel('number of correlated columns');

idx = find(n);
na  = idx(1);
n   = mode(diff(idx));

%******************** end of file *******************