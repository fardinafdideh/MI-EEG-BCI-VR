setfield(object_nodes(7),'scale',.6*ones(1,3))%Right_Hand_Scale_Rot(.6-->1.2)
setfield(object_nodes(7),'rotation',[0 1 0 -pi/180*149.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.5 2.5 -12.66])%Right_Hand
setfield(object_nodes(9),'scale',.455*ones(1,3))%Left_Hand_Scale_Rot(.455-->.95)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*30.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-2.6 2.2 -12])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.455;R_scl_min=.6;L_scl_max=.95;R_scl_max=1.2;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_SalonFront_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

