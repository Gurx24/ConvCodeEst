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

nd  = 30000;            % number of data
cl  = [2 3];            % constraint length
ber = 0.000;            % bit error rate
% g1  = 1;              % generator polynomial of 1st
% g2  = 53;             % generator polynomial of 2st
% g3  = 137;            % generator polynomial of 3st

%*********************** Data generation **************************

data = rand(1, nd) > 0.5;                  % data generation

%******************* Convolutional encodding **********************

genpoly  = [1 0 3;0 1 5];              % generator polynomial
trellis  = poly2trellis(cl, genpoly);  % arguments of convolutional code 
codedata = convenc(data, trellis);     % convolutional encoding

%********************** Generate error bits ************************

lb   = length(codedata);        % length of codedata bits
mask = rand(1, lb) < ber;       % used for generating bit errors
rcw  = xor(codedata, mask);     % received codeword with errors

%********************* Parameters estimation ***********************

% rcw          = rcw(3:end);
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