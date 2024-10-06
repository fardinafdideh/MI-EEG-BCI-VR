setfield(object_nodes(7),'scale',.105*ones(1,3))%Right_Hand_Scale_Rot(.105-->.21)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*59.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.216 2.28 -10.03])%Right_Hand
setfield(object_nodes(9),'scale',.265*ones(1,3))%Left_Hand_Scale_Rot(.265-->.53)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*50])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[2.661 2.471 -11.3])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.265;R_scl_min=.105;L_scl_max=.53;R_scl_max=.21;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_SalonRight_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

