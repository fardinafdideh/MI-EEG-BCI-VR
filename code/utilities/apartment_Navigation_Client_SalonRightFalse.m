setfield(object_nodes(1),'translation',[-.2354 1.2 -7.484])%Station_front
setfield(object_nodes(3),'translation',[-1.1354 1.2 -11.684])%Station_Right
setfield(object_nodes(2),'translation',[1.5646 1.2 -7.484])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.095*ones(1,3))%Right_Hand_Scale_Rot(.095-->.19)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*100.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[4.916 2.37 -11.87])%Right_Hand
setfield(object_nodes(9),'scale',.29*ones(1,3))%Left_Hand_Scale_Rot(.29-->.58)
setfield(object_nodes(9),'rotation',[0 1 0 -pi/180*156.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.679 2.6 -9.6])%Left_Hand
setfield(object_nodes(11),'scale',.031*ones(1,3))%Tennis_Shoe_Right(.031-->.062)
setfield(object_nodes(11),'rotation',[.6959 .6991 -.1642 -pi/180*158.4])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[3.3454 2.08 -10.5449])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.29;R_scl_min=.095;F_scl_min=.031;L_scl_max=.58;R_scl_max=.19;F_scl_max=.062;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_SalonRightFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

