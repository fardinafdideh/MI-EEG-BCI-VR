setfield(object_nodes(7),'scale',.53*ones(1,3))%Right_Hand_Scale_Rot(.53-->1)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*126])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.4 2.18 -5.4])%Right_Hand
setfield(object_nodes(9),'scale',.4*ones(1,3))%Left_Hand_Scale_Rot(.4-->.8)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*113.4])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-2.1776 1.95 -2.35])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.4;R_scl_min=.53;L_scl_max=.8;R_scl_max=1;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_WCBathFront_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

