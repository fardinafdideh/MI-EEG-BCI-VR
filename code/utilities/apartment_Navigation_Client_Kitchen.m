setfield(object_nodes(7),'scale',.35*ones(1,3))%Right_Hand_Scale_Rot(.35-->.7)
setfield(object_nodes(7),'rotation',[-.018 -.9929 .1177 pi/180*12.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.4 2.7 1.8])%Right_Hand
setfield(object_nodes(9),'scale',.2*ones(1,3))%Left_Hand_Scale_Rot(.2-->.4)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*111.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[5.25 2.32 .1])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.2;R_scl_min=.35;L_scl_max=.4;R_scl_max=.7;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_Kitchen_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

