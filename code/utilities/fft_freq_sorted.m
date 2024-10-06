function out = fft_freq_sorted(fs, columnSignal, compNb)
% columnSignal: signalLength * channels
% compNb: # of components

columnSignalFFT = abs(fft(columnSignal, 2^nextpow2(size(columnSignal, 1)))); 
freq = linspace(0, fs, size(columnSignalFFT, 1)); % frequency vector
[~, idx] = sort(columnSignalFFT(1: round(size(columnSignalFFT, 1)/2),:));
out = idx(end-compNb+1 : end, :);
out = freq(out(:));

