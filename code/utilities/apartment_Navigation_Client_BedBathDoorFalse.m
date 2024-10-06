setfield(object_nodes(1),'translation',[4.1091 1.2 2.0511])%Station_front
setfield(object_nodes(2),'translation',[4.5091 1.5 -.9489])%Station_Left
setfield(object_nodes(3),'translation',[2.8091 1.2 3.0511])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.14*ones(1,3))%Right_Hand_Scale_Rot(.14-->.28)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*5.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[2.18 2.52 -2.1])%Right_Hand
setfield(object_nodes(9),'scale',.2*ones(1,3))%Left_Hand_Scale_Rot(.2-->.4)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*108])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[3.9152 2.54 -2.3])%Left_Hand
setfield(object_nodes(11),'scale',.041*ones(1,3))%Tennis_Shoe_Right(.041-->.082)
setfield(object_nodes(11),'rotation',[-.4 -.5 .8852 pi/180*90])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[4.05 1.85 -.17])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.2;R_scl_min=.14;F_scl_min=.041;L_scl_max=.4;R_scl_max=.28;F_scl_max=.082;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_BedBathDoorFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

