setfield(object_nodes(1),'translation',[1.9091 1.2 .9511])%Station_front
setfield(object_nodes(2),'translation',[1.9091 1.2 3.2511])%Station_Left
setfield(object_nodes(3),'translation',[4.0091 1.6 -.9489])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.085*ones(1,3))%Right_Hand_Scale_Rot(.085-->.171)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*120.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[7.1 2.5549 .25])%Right_Hand
setfield(object_nodes(9),'scale',.085*ones(1,3))%Left_Hand_Scale_Rot(.085-->.171)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*115.2])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[7.2408 2.43 1.21])%Left_Hand
setfield(object_nodes(11),'scale',.0325*ones(1,3))%Tennis_Shoe_Right(.0325-->.065)
setfield(object_nodes(11),'rotation',[.7132 .701 .0073 pi/180*179.7101])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[4.8493 2.1378 .6226])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.085;R_scl_min=.085;F_scl_min=.0325;L_scl_max=.171;R_scl_max=.171;F_scl_max=.065;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_KitchenFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

