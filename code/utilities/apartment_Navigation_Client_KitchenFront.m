setfield(object_nodes(7),'scale',.335*ones(1,3))%Right_Hand_Scale_Rot(.335-->.65)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*36])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[4.5 2.15 4.5])%Right_Hand
setfield(object_nodes(9),'scale',.43*ones(1,3))%Left_Hand_Scale_Rot(.43-->.85)
setfield(object_nodes(9),'rotation',[-.036 -.9993 0 -pi/180*140])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[7.15 2.15 5.4])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.43;R_scl_min=.335;L_scl_max=.85;R_scl_max=.65;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_KitchenFront_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

