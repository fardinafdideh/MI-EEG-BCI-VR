setfield(object_nodes(1),'translation',[4.6 1.2 4])%Station_front
setfield(object_nodes(2),'translation',[5.75 1.2 4.4])%Station_Left
setfield(object_nodes(3),'translation',[3.168 1.2 2])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.29*ones(1,3))%Right_Hand_Scale_Rot(.29-->.58)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*99])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[5.3 2.47 1.33])%Right_Hand
setfield(object_nodes(9),'scale',.165*ones(1,3))%Left_Hand_Scale_Rot(.165-->.33)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*160])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[7.04 2.15 2.95])%Left_Hand
setfield(object_nodes(11),'scale',.019*ones(1,3))%Tennis_Shoe_Right(.019-->.038)
setfield(object_nodes(11),'rotation',[.6957 .6962 -.177 -pi/180*160.2])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[6.01 2.05 2.5])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.165;R_scl_min=.29;F_scl_min=.019;L_scl_max=.33;R_scl_max=.58;F_scl_max=.038;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_KitchenLeftFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

