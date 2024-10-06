setfield(object_nodes(1),'translation',[6.5 1.2 2.9])%Station_front
setfield(object_nodes(2),'translation',[4.4 1.2 1])%Station_Left
setfield(object_nodes(3),'translation',[6.6304 1.1892 4.28])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.3*ones(1,3))%Right_Hand_Scale_Rot(.3-->.6)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 -pi/180*111])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[6.037 2.38 4.95])%Right_Hand
setfield(object_nodes(9),'scale',.05*ones(1,3))%Left_Hand_Scale_Rot(.05-->.105)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*0])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.255 1.83 5.5])%Left_Hand
setfield(object_nodes(11),'scale',.045*ones(1,3))%Tennis_Shoe_Right(.045-->.09)
setfield(object_nodes(11),'rotation',[.4756 .4429 .76 pi/180*108])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[6 1.4 3])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.05;R_scl_min=.3;F_scl_min=.045;L_scl_max=.105;R_scl_max=.6;F_scl_max=.09;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_KitchenRightFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

