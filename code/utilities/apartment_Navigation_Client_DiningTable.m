setfield(object_nodes(7),'scale',.075*ones(1,3))%Right_Hand_Scale_Rot(.075-->.15)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*113.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.3 2.13 -.3748])%Right_Hand
setfield(object_nodes(9),'scale',.13*ones(1,3))%Left_Hand_Scale_Rot(.13-->.26)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*1.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[3.05 2.114 -.95])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.13;R_scl_min=.075;L_scl_max=.26;R_scl_max=.15;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_DiningTable_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max ) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

