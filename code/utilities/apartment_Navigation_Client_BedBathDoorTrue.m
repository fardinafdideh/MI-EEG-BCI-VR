setfield(object_nodes(1),'translation',[1.568 1.2 -.8376])%Station_front
setfield(object_nodes(2),'translation',[1.568 1.2 .1624])%Station_Left
setfield(object_nodes(3),'translation',[1.768 1.2 -7.0376])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.105*ones(1,3))%Right_Hand_Scale_Rot(.105-->.21)
setfield(object_nodes(7),'rotation',[-.0224 -.994 -.0273 -pi/180*180])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.63 1.91 1.226])%Right_Hand
setfield(object_nodes(9),'scale',.275*ones(1,3))%Left_Hand_Scale_Rot(.275-->.55)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*55.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.9 2.15 1.0736])%Left_Hand
setfield(object_nodes(11),'scale',.0105*ones(1,3))%Tennis_Shoe_Right(.0105-->.021)
setfield(object_nodes(11),'rotation',[.6559 .6449 .3923 pi/180*141.0473])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[3.1 1.95 1.4327])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.275;R_scl_min=.105;F_scl_min=.0105;L_scl_max=.55;R_scl_max=.21;F_scl_max=.021;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_BedBathDoorTrue_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

