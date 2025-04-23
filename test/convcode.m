%%%%%%%%%%%%%%%%%%%%% convcode.m %%%%%%%%%%%%%%%%%%%%
%
% Generate convolutional code by specified arguments
% 
% date:2025.3.6  GuRX
%
% [out] = convcode(in, gp, cl)
%
% **************************************************
% in  : data of input
% gp  : generator polynomial
% cl  : constraint length
% out : data after convolutional encodding
% **************************************************

function [out] = convcode(in, gp, cl)

if nargin ~= 3
    error('error of argument input');
end

trellis  = poly2trellis(cl, gp);     % arguments of convolutional code
in       = [in zeros(1, cl-1)];      % insert tail bits for register reset         
out      = convenc(in, trellis);     % convolutional encoding

%*********************** end of file **************************