setfield(object_nodes(1),'translation',[2.568 1.2 3.232])%Station_front
setfield(object_nodes(2),'translation',[3.768 1.2 2.232])%Station_Left
setfield(object_nodes(3),'translation',[2.1 1.2 -.9])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.105*ones(1,3))%Right_Hand_Scale_Rot(.105-->.21)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*68.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[4 2.26 -3.41])%Right_Hand
setfield(object_nodes(9),'scale',.043*ones(1,3))%Left_Hand_Scale_Rot(.043-->.087)
setfield(object_nodes(9),'rotation',[.036 .9969 -.0706 -pi/180*163.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.94 2.035 -3])%Left_Hand
setfield(object_nodes(11),'scale',.0095*ones(1,3))%Tennis_Shoe_Right(.0095-->.019)
setfield(object_nodes(11),'rotation',[-.6749 -.6349 .3761 pi/180*140.4])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[4.1699 2.32 -2.75])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.043;R_scl_min=.105;F_scl_min=.0095;L_scl_max=.087;R_scl_max=.21;F_scl_max=.019;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_DiningTableFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

