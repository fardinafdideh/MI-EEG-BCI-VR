setfield(object_nodes(7),'scale',.29*ones(1,3))%Right_Hand_Scale_Rot(.29-->.59)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*34.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.25 2.1416 4.4584])%Right_Hand
setfield(object_nodes(9),'scale',.068*ones(1,3))%Left_Hand_Scale_Rot(.068-->.137)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*156.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-.37 1.62 3.4912])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.068;R_scl_min=.29;L_scl_max=.137;R_scl_max=.59;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_BedroomFront_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

