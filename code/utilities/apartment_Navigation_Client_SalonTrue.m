setfield(object_nodes(1),'translation',[-.672 1.2 -11.5028])%Station_front
setfield(object_nodes(3),'translation',[2.8658 1.2 -10.6942])%Station_Right
setfield(object_nodes(2),'translation',[-1.32 1.2 -9.3428])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.065*ones(1,3))%Right_Hand_Scale_Rot(.065-->.13)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*163.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[2.7069 2.0517 -6.9441])%Right_Hand
setfield(object_nodes(9),'scale',.115*ones(1,3))%Left_Hand_Scale_Rot(.115-->.23)
setfield(object_nodes(9),'rotation',[-.036 -1 .0706 pi/180*69])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[2.1 2.03 -6.59])%Left_Hand
setfield(object_nodes(11),'scale',.007*ones(1,3))%Tennis_Shoe_Right(.007-->.0145)
setfield(object_nodes(11),'rotation',[.5971 .7212 .3502 pi/180*133.6037])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[2.35 2.23 -6.7212])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.115;R_scl_min=.065;F_scl_min=.007;L_scl_max=.23;R_scl_max=.13;F_scl_max=.0145;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_SalonTrue_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

