function Hd = LPF3K(Fc, Fs)
%LPF3K Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.7 and Signal Processing Toolbox 8.3.
% Generated on: 12-Mar-2020 11:29:07

% Butterworth Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
% Fs = 480000;  % Sampling Frequency

N  = 10;    % Order
% Fc = 8000;  % Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.lowpass('N,F3dB', N, Fc, Fs);
Hd = design(h, 'butter');

% [EOF]