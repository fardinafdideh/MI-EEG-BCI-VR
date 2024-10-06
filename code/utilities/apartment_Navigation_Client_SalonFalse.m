setfield(object_nodes(1),'translation',[1.584 1.2 .176])%Station_front
setfield(object_nodes(3),'translation',[1.496 1.2 -1.256])%Station_Right
setfield(object_nodes(2),'translation',[1.872 1.2 1.936])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.065*ones(1,3))%Right_Hand_Scale_Rot(.065-->.135)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*39.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[2.78 2.141 -5.2])%Right_Hand
setfield(object_nodes(9),'scale',.07*ones(1,3))%Left_Hand_Scale_Rot(.07-->.14)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*153])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[3.61 2.025 -4.7905])%Left_Hand
setfield(object_nodes(11),'scale',.016*ones(1,3))%Tennis_Shoe_Right(.016-->.032)
setfield(object_nodes(11),'rotation',[-.5611 -.5621 .6077 pi/180*115.552])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[2.92 2.15 -3.9927])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.07;R_scl_min=.065;F_scl_min=.016;L_scl_max=.14;R_scl_max=.135;F_scl_max=.032;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_SalonFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

