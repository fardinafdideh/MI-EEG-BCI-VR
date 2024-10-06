setfield(object_nodes(7),'scale',.3*ones(1,3))%Right_Hand_Scale_Rot(.3-->.6)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*113.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-1.208 2.25 .1])%Right_Hand
setfield(object_nodes(9),'scale',.28*ones(1,3))%Left_Hand_Scale_Rot(.28-->.55)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*120.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-1.208 2.15 2.72])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.28;R_scl_min=.3;L_scl_max=.55;R_scl_max=.6;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_BedroomRight_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

