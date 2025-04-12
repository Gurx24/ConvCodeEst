%%%%%%%%%%%%%%%%%%%%% ccdecide.m %%%%%%%%%%%%%%%%%%%%
%
% Convolutional code decode by parameters of estimation
% Viterbi decoding
% 
% date:2025.3.19  GuRX
%

function output = ccdecode(input, H, L)

estg1 = H(end:-2:1);
estg2 = H(end-1:-2:1);

binStr1 = num2str(estg1); 
binStr1(binStr1 == ' ') = '';
decNum1 = bin2dec(binStr1);  
strg1 = dec2base(decNum1, 8);
octg1 = str2double(strg1);

binStr2 = num2str(estg2); 
binStr2(binStr2 == ' ') = '';
decNum2 = bin2dec(binStr2);  
strg2 = dec2base(decNum2, 8);
octg2 = str2double(strg2);

estgenploy = [octg1, octg2];
trellis    = poly2trellis(L+1, estgenploy);
tbdepth    = 34; % Traceback depth for Viterbi decoder
output     = vitdec(input, trellis, tbdepth, 'trunc', 'hard');
