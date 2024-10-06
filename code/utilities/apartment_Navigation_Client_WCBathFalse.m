setfield(object_nodes(1),'translation',[1.5091 1.2 .1014])%Station_front
setfield(object_nodes(3),'translation',[1.5091 1.2 -2.4665])%Station_Right
setfield(object_nodes(2),'translation',[1.5091 1.2 1.2203])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.085*ones(1,3))%Right_Hand_Scale_Rot(.085-->.17)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*113.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[4 1.87 -1.95])%Right_Hand
setfield(object_nodes(9),'scale',.065*ones(1,3))%Left_Hand_Scale_Rot(.065-->.136)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*126])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.46 1.71 -1.06])%Left_Hand
setfield(object_nodes(11),'scale',.019*ones(1,3))%Tennis_Shoe_Right(.019-->.038)
setfield(object_nodes(11),'rotation',[-.709 -.6976 .1037 pi/180*167.4])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[2.9489 1.74 -1.15])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.065;R_scl_min=.085;F_scl_min=.019;L_scl_max=.136;R_scl_max=.17;F_scl_max=.038;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_WCBathFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

