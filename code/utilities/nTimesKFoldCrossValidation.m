function [accuracy_mean, accuracy_SD, precision_mean, precision_SD, ...
    recall_mean, recall_SD, f1score_mean, f1score_SD] = ...
    nTimesKFoldCrossValidation(nTimes, kFold, feature, lable, isOnlyAcc, isWaitbar)
if isWaitbar
    h = waitbar(0,'Please wait... Cross-validation');
end
classNb = length(unique(lable));
Acc_mean = nan(1, nTimes);
if ~isOnlyAcc
    prcsn_mean = nan(nTimes, classNb);
    rcll_mean = nan(nTimes, classNb);
    f1scr_mean = nan(nTimes, classNb);
end
for j = 1:nTimes
    indices = crossvalind('Kfold', lable, kFold);
    Acc = nan(1, kFold);
    precision = nan(kFold, classNb);
    recall = nan(kFold, classNb);
    f1score = nan(kFold, classNb);
    for i = 1:kFold
        test = (indices == i); train = ~test;
        [featureTrainNorm, PS] = mapminmax(feature(train,:)');
        featureTestNorm = mapminmax('apply', feature(test,:)', PS);
        try
            C = classify(featureTestNorm',featureTrainNorm', lable(train));
        catch
            disp('A classification error was handled!')
            continue
        end
        Acc(i) = (sum(C'==lable(test))/length(find(test)));
        if ~isOnlyAcc
            matrixC = confusionmat(lable(test), C);
%             TP = diag(matrixC);
%             FP = sum(matrixC, 1)' - TP;
%             FN = sum(matrixC, 2) - TP;
%             precision(i, :) = TP ./ (TP + FP);
%             recall(i, :) = TP ./ (TP + FN);
%             f1score(i, :) = 2 * (precision(i, :) .* recall(i, :)) ./ (precision(i, :) + recall(i, :));
[precision(i, :), recall(i, :), f1score(i, :)] = precisionRecallF1_confusion(matrixC);
        end
    end
    Acc_mean(j) = nanmean(Acc(:));
    if ~isOnlyAcc
        prcsn_mean(j, :) = nanmean(precision);
        rcll_mean(j, :) = nanmean(recall);
        f1scr_mean(j, :) = nanmean(f1score);
    end
    if isWaitbar
        waitbar(((j-1)*kFold + i)/(nTimes * kFold))
    end
end
if isWaitbar
    close(h)
end
accuracy_mean = 100*mean(Acc_mean);
accuracy_SD = std(100*Acc_mean);
if ~isOnlyAcc
    precision_mean = 100*mean(prcsn_mean);
    precision_SD = std(100*prcsn_mean);
    recall_mean = 100*mean(rcll_mean);
    recall_SD = std(100*rcll_mean);
    f1score_mean = 100*mean(f1scr_mean);
    f1score_SD = std(100*f1scr_mean);
else
    [precision_mean, precision_SD, recall_mean, recall_SD, f1score_mean, f1score_SD] = deal(nan, nan, nan, nan, nan, nan);
end