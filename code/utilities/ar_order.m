function out = ar_order(columnSignal, arOrder)
% columnSignal: signalLength * channels
% arOrder: AR order

out = nan(1, arOrder * size(columnSignal, 2));
for i = 1 : size(columnSignal, 2)
    tmp = arburg(columnSignal(:, i), arOrder);
    out((i-1)*arOrder+1 : i*arOrder) = tmp(2: arOrder+1);
end