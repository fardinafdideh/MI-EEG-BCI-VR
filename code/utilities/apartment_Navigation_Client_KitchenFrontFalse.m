setfield(object_nodes(1),'translation',[3.5076 1.1892 1.806])%Station_front
setfield(object_nodes(2),'translation',[4.1232 1.1892 3.48])%Station_Left
setfield(object_nodes(3),'translation',[6.5 1.2 2.5])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.13*ones(1,3))%Right_Hand_Scale_Rot(.13-->.27)
setfield(object_nodes(7),'rotation',[-.0224 -.9994 -.0273 pi/180*180])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[6.72 2.07 4.5])%Right_Hand
setfield(object_nodes(9),'scale',.45*ones(1,3))%Left_Hand_Scale_Rot(.45-->.9)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*54.1461])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[3.8 2.6 3.8])%Left_Hand
setfield(object_nodes(11),'scale',.014*ones(1,3))%Tennis_Shoe_Right(.014-->.028)
setfield(object_nodes(11),'rotation',[.7 .6449 .3923 pi/180*141.0476])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[6.05 2 4.5947])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.45;R_scl_min=.13;F_scl_min=.014;L_scl_max=.9;R_scl_max=.27;F_scl_max=.028;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_KitchenFrontFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

