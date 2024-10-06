setfield(object_nodes(7),'scale',.25*ones(1,3))%Right_Hand_Scale_Rot(.25-->.5)
setfield(object_nodes(7),'rotation',[-.0224 -.9997 0 pi/180*43.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[6.7707 2.2 2.8])%Right_Hand
setfield(object_nodes(9),'scale',.095*ones(1,3))%Left_Hand_Scale_Rot(.095-->.19)
setfield(object_nodes(9),'rotation',[.0361 .9993 0 pi/180*70])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[6.5 1.78 1.45])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.095;R_scl_min=.25;L_scl_max=.19;R_scl_max=.5;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_KitchenLeft_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

