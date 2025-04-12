clc; clear; close all;

% data = [1 0 1 1 1];
% cl   = 4;
% 
% g1 = 13;
% g2 = 14;
% 
% genpoly  = [g1 g2];                        % generator polynomial
% codedata = convcode(data, genpoly, cl);    % generate convolutional code

data = randi([0 1],70,1);
trellis = poly2trellis(5,[37 33]);
codedData = convenc(data,trellis);
tbdepth = 34; % Traceback depth for Viterbi decoder
decodedData = vitdec(codedData,trellis,tbdepth,'trunc','hard');

biterr(data,decodedData)