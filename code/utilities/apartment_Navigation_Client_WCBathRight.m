setfield(object_nodes(7),'scale',.205*ones(1,3))%Right_Hand_Scale_Rot(.205-->.41)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*129.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[.19 2.24 -6.8])%Right_Hand
setfield(object_nodes(9),'scale',.25*ones(1,3))%Left_Hand_Scale_Rot(.25-->.5)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*117])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[.0224 2.22 -4.7])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.25;R_scl_min=.205;L_scl_max=.5;R_scl_max=.41;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_WCBathRight_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

