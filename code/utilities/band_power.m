function BP = band_power(fs, columnSignal, bandRange)
% fs: sampling freq
% columnSignal: signalLength * channels
% bandRange = [lowFreq, highFreq]
% BP : 1*chNb

L = size(columnSignal,1); % Signal length
columnSignalFFT = fft(columnSignal, 2^nextpow2(L)); 

freq = linspace(0, fs, size(columnSignalFFT, 1)); % frequency vector
[~, freqLowIdx] = min(abs(freq - bandRange(1)));
[~, freqHighIdx] = min(abs(freq - bandRange(2)));

columnSignalFFT = columnSignalFFT(freqLowIdx:freqHighIdx, :); % Selected band
BP = diag(columnSignalFFT'*columnSignalFFT)';
