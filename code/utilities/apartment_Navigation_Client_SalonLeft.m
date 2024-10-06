setfield(object_nodes(7),'scale',.115*ones(1,3))%Right_Hand_Scale_Rot(.115-->.23)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*32.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-1.08 1.36 -8.9])%Right_Hand
setfield(object_nodes(9),'scale',.34*ones(1,3))%Left_Hand_Scale_Rot(.34-->.68)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*145.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.1 1.66 -7.1173])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.34;R_scl_min=.115;L_scl_max=.68;R_scl_max=.23;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_SalonLeft_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

