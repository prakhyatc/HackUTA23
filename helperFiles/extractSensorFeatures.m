function feature = extractSensorFeatures(a, uniformSampleRate)
% The function extracts features of a chunk of acceleration data stored in
% 'a'. 'uniformSampleRate' specifies the sample rate at which 'a' is sampled.
% 
% The output is a row vector consisting of 2 entries. They are 1) sum of height of
% frequency component below 5 Hz, and 2) the magnitude of y after applying 
% a high pass filter. These features are in the frequency domain. They are extracted from the 
% y-axis (up and down) data only.
%
% Copyright 2014-2019 The MathWorks, Inc.

%% Obtain Y acceleration data and subtract the mean
y = a(:,2);
y = y - mean(y);

% Apply fast fourier transformation to the signal
% Next power of 2 from length of averaged rms acceleration
NFFT = 2 ^ nextpow2(length(y)); 
freqAccel = fft(y, NFFT) / length(y);

% Amplitude of spectrum
amplitudeSpectrum = 2 * abs(freqAccel(1:NFFT / 2 + 1)); 

% Freq. feature 1, single sideed bandwidth is uniformSampleRate / 2, we are
% interested in 5Hz out of uniformSampleRate / 2.
sum5Hz = sum(amplitudeSpectrum(1:ceil(NFFT*5/(uniformSampleRate/2))));

% Freq feature 2, norm after applying 4th-order high-pass Butterworth filter to y
% to smooth and remove noise from the data
[b,a] = butter(4,0.2,'high');
bt = filter(b,a,y);
bt = sqrt(sum([bt.^2]));

%%
feature = [sum5Hz, bt];
