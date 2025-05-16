clc; clear; close all;

addpath('../src/');

%************************ Parameters part *************************

nd    = 30000;                       % number of data
cl    = 3;                           % constraint length
poly  = [7, 5];                      % generator polynomial
ber   = 0.005;                       % bit error rate

%*********************** Data generation **************************

data = rand(1, nd) > 0.5;            % data generation

%******************* Convolutional encodding **********************

trellis  = poly2trellis(cl, poly, 7);   % arguments of convolutional code 
codedata = convenc(data, trellis);      % convolutional encoding

%********************** Generate error bits ************************

lb   = length(codedata);             % length of codedata bits
mask = rand(1, lb) < ber;            % used for generating bit errors
rcw  = xor(codedata, mask);          % received codeword with errors

%********************* Parameters estimation ***********************

rcw          = rcw(1:end);
[n, na]      = cclbr(rcw);           % n : code length
[t, k, L, H] = ccpbrV2(rcw, n, na);  % H : check matrix
                                     % t : synchronization position
                                     % k : number of input port and
                                     % L : constraint length

disp('Convolutional code parameter identification completed!');
fprintf('n = %d\nk = %d\nL = %d\nt = %d\n', n, k, L, t);
disp(['H = ',mat2str(H)]);
