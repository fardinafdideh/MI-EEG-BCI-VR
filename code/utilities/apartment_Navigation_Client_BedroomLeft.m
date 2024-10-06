setfield(object_nodes(7),'scale',.19*ones(1,3))%Right_Hand_Scale_Rot(.19-->.4)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*34.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-.3 1.5 4.34])%Right_Hand
setfield(object_nodes(9),'scale',.16*ones(1,3))%Left_Hand_Scale_Rot(.16-->.325)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*156.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.47 1.34 4.57])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.16;R_scl_min=.19;L_scl_max=.325;R_scl_max=.4;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_BedroomLeft_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

