setfield(object_nodes(1),'translation',[.6296 1.2 5.02])%Station_front
setfield(object_nodes(3),'translation',[-.9704 1.2 3.72])%Station_Right
setfield(object_nodes(2),'translation',[.6296 1.2 .6])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.202*ones(1,3))%Right_Hand_Scale_Rot(.202-->.41)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*25.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.4 2.35 .7424])%Right_Hand
setfield(object_nodes(9),'scale',.18*ones(1,3))%Left_Hand_Scale_Rot(.18-->.36)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*99])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-1.208 2.2 -.28])%Left_Hand
setfield(object_nodes(11),'scale',.0055*ones(1,3))%Tennis_Shoe_Right(.0055-->.011)
setfield(object_nodes(11),'rotation',[-.3441 -.2373 .9085 pi/180*103.5739])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-2.6078 2.34 -.12])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.18;R_scl_min=.202;F_scl_min=.0055;L_scl_max=.36;R_scl_max=.41;F_scl_max=.011;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_BedroomRightFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

