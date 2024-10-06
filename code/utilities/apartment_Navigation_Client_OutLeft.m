setfield(object_nodes(1),'translation',[5 1.2 10])%Station_front
setfield(object_nodes(2),'translation',[2.4 1.2 6.3])%Station_Left
setfield(object_nodes(3),'translation',[2.35 1.2 10.8])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.81*ones(1,3))%Right_Hand_Scale_Rot(.81-->1.5)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*70.2])%Right_Hand_Scale_Rot
setfield(object_nodes(9),'scale',.37*ones(1,3))%Left_Hand_Scale_Rot(.37-->.74)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*55.8])%Left_Hand_Scale_Rot
setfield(object_nodes(11),'scale',.015*ones(1,3))%Tennis_Shoe_Right(.015-->.032)
setfield(object_nodes(11),'rotation',[.1755 .18 1 pi/180*87.3868])%Tennis_Shoe_Right
setfield(object_nodes(8),'translation',[3.5 3.3 11.3])%Right_Hand
setfield(object_nodes(10),'translation',[.6 2.55 7.5])%Left_Hand
setfield(object_nodes(11),'translation',[-0.5 2.1 9.4])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.37;R_scl_min=.81;F_scl_min=.015;L_scl_max=.74;R_scl_max=1.5;F_scl_max=.032;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_OutLeft_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

