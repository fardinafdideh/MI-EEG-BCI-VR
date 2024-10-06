% The last k_class, length(C)+1, save in the BCI workstation is loaded and
% updates k and class_ind.
% The Cs between the current and k and the updated one, if any, are
% ignored, because the ttask is finished and there is no need anymore to
% them
load(k_classPath)
% disp([del_ind, k, k_class])
k=k_class;
class_ind=k;
