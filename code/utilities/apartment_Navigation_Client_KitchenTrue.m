setfield(object_nodes(1),'translation',[5.75 1.2 4.4])%Station_front
setfield(object_nodes(2),'translation',[6.5 1.2 2.5])%Station_Left
setfield(object_nodes(3),'translation',[4.4 1.2 3.8])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.35*ones(1,3))%Right_Hand_Scale_Rot(.35-->.7)
setfield(object_nodes(7),'rotation',[-.018 -.9929 .1177 pi/180*12.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.4 2.7 1.8])%Right_Hand
setfield(object_nodes(9),'scale',.2*ones(1,3))%Left_Hand_Scale_Rot(.2-->.4)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*111.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[5.25 2.32 .1])%Left_Hand
setfield(object_nodes(11),'scale',.045*ones(1,3))%Tennis_Shoe_Right(.045-->.09)
setfield(object_nodes(11),'rotation',[-.5 -.5 1 pi/180*96.7152])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[5.2 1.6 2.5])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.2;R_scl_min=.35;F_scl_min=.045;L_scl_max=.4;R_scl_max=.7;F_scl_max=.09;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_KitchenTrue_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

