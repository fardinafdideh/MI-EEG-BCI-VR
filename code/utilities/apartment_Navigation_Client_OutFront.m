setfield(object_nodes(1),'translation',[2.35 1.2 6])%Station_front
setfield(object_nodes(2),'translation',[0 1.2 9])%Station_Left
setfield(object_nodes(3),'translation',[5 1.2 10])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.72*ones(1,3))%Right_Hand_Scale_Rot(.72-->1.5)
setfield(object_nodes(7),'rotation',[.018 1 -.1177 -pi/180*160])%Right_Hand_Scale_Rot
setfield(object_nodes(9),'scale',.77*ones(1,3))%Left_Hand_Scale_Rot(.77-->1.6)
setfield(object_nodes(9),'rotation',[0 1 0 -pi/180*25.2])%Left_Hand_Scale_Rot
setfield(object_nodes(11),'scale',.03*ones(1,3))%Tennis_Shoe_Right(.03-->.05)
setfield(object_nodes(11),'rotation',[.5774 .5774 .5774 pi/180*119.9997])%Tennis_Shoe_Right
setfield(object_nodes(8),'translation',[5.72 3.35 10])%Right_Hand
setfield(object_nodes(10),'translation',[-.7 3.3 10])%Left_Hand
setfield(object_nodes(11),'translation',[2.49 1.9 13])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.77;R_scl_min=.72;F_scl_min=.03;L_scl_max=1.6;R_scl_max=1.5;F_scl_max=.05;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_OutFront_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end


