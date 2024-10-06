setfield(object_nodes(1),'translation',[3.1646 1.2 -9.584])%Station_front
setfield(object_nodes(3),'translation',[1.4646 1.2 -7.784])%Station_Right
setfield(object_nodes(2),'translation',[.1646  1.2 -11.784])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.155*ones(1,3))%Right_Hand_Scale_Rot(.155-->.31)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*93.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-1 2.16 -7.53])%Right_Hand
setfield(object_nodes(9),'scale',.295*ones(1,3))%Left_Hand_Scale_Rot(.295-->.59)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*27])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-1 2.3 -9.4093])%Left_Hand
setfield(object_nodes(11),'scale',.03*ones(1,3))%Tennis_Shoe_Right(.03-->.06)
setfield(object_nodes(11),'rotation',[.3477 .3243 .8798 pi/180*96.6378])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-.2434 1.75 -8.5])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.295;R_scl_min=.155;F_scl_min=.03;L_scl_max=.59;R_scl_max=.31;F_scl_max=.06;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_SalonLeftFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end