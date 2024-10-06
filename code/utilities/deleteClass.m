function del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc)
for i = del_ind:class_ind-class_ind_inc
    %             eval(['delete(''\\192.168.0.1\share\Class',num2str(i),'.mat'')'])
    delete(fullfile(sharePath, ['Class',num2str(i),'.mat']))
end
del_ind=class_ind-class_ind_inc+1;%pause(1.5)