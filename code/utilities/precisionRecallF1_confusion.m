function [precision, recall, f1score] = precisionRecallF1_confusion(matrixC)
% matrixC = target*predicted
TP = diag(matrixC);
FP = sum(matrixC, 1)' - TP;
FN = sum(matrixC, 2) - TP;
precision = TP ./ (TP + FP);
recall = TP ./ (TP + FN);
f1score = 2 * (precision .* recall) ./ (precision + recall);