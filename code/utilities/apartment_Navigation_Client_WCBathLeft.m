setfield(object_nodes(7),'scale',.24*ones(1,3))%Right_Hand_Scale_Rot(.24-->.48)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*126])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.8 2.39 -2.95])%Right_Hand
setfield(object_nodes(9),'scale',.175*ones(1,3))%Left_Hand_Scale_Rot(.175-->.35)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*113.4])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-2.4416 2.17 -.9])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.175;R_scl_min=.24;L_scl_max=.35;R_scl_max=.48;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_WCBathLeft_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

