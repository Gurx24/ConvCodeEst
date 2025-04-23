%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ccsim.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Generate convolutional code by specified arguments.
% Next, use convolutional code blind recognition methods 
% to perform parameter identification.
% 
% Understand the specific function of 
% functions through the help documentation.
%
% date:2025.3.6  GuRX
%

clc; clear; close all;

%************************ Parameters part *************************

nd    = 30000;            % number of data
cl    = [2 3];            % constraint length
poly  = [2 0 3;0 4 5];    % generator polynomial
ber   = 0.005;            % bit error rate

%*********************** Data generation **************************

data = rand(1, nd) > 0.5;                  % data generation

%******************* Convolutional encodding **********************

trellis  = poly2trellis(cl, poly);   % arguments of convolutional code 
codedata = convenc(data, trellis);   % convolutional encoding

%********************** Generate error bits ************************

lb   = length(codedata);        % length of codedata bits
mask = rand(1, lb) < ber;       % used for generating bit errors
rcw  = xor(codedata, mask);     % received codeword with errors

%********************* Parameters estimation ***********************

rcw          = rcw(2:end);
[n, na]      = cclbr(rcw);          % L : code length
[t, k, L, H] = ccpbr(rcw, n, na);   % H : check matrix
                                    % t : synchronization position
                                    % k : number of input port and
                                    % L : constraint length

%******************* Convolutional code decoding *******************                                

% datelen = floor(length(rcw) / n) * n;
% rcw = rcw(t : datelen);
% decodedata = ccdecode(rcw, H, L);
% biterr(data, decodedata)