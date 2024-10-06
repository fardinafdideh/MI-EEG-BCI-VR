setfield(object_nodes(1),'translation',[3.55 1.2 -1.2])%Station_front
setfield(object_nodes(2),'translation',[1.75 1.2 -1.6])%Station_Left
setfield(object_nodes(3),'translation',[4 1.2 1])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.135*ones(1,3))%Right_Hand_Scale_Rot(.135-->.27)
setfield(object_nodes(7),'rotation',[-.018 -.9929 .1177 pi/180*151.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[2.92 2.25 3.3])%Right_Hand
setfield(object_nodes(9),'scale',.1*ones(1,3))%Left_Hand_Scale_Rot(.1-->.21)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*1.8001])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[2.12 2.06 3.4])%Left_Hand
setfield(object_nodes(11),'scale',.009*ones(1,3))%Tennis_Shoe_Right(.009-->.018)
setfield(object_nodes(11),'rotation',[.7 .5774 .8 pi/180*120])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[2.25 2.25 3.5])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.1;R_scl_min=.135;F_scl_min=.009;L_scl_max=.21;R_scl_max=.27;F_scl_max=.018;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_InputDoor_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

