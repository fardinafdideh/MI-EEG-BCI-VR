setfield(object_nodes(1),'translation',[0 1.2 9])%Station_front
setfield(object_nodes(2),'translation',[2.35 1.2 10.8])%Station_Left
setfield(object_nodes(3),'translation',[2.4 1.2 6.3])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.47*ones(1,3))%Right_Hand_Scale_Rot(.47-->.95)
setfield(object_nodes(7),'rotation',[.018 .9929 -.1177 pi/180*126])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[4.1 2.65 6.6])%Right_Hand
setfield(object_nodes(9),'scale',.25*ones(1,3))%Left_Hand_Scale_Rot(.25-->.47)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*95.4])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.9 2.07 10.3])%Left_Hand
setfield(object_nodes(11),'scale',.009*ones(1,3))%Tennis_Shoe_Right(.009-->.0165)
setfield(object_nodes(11),'rotation',[.7064 .7064 .0433 pi/180*174.8076])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[5.7 2 9.55])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.25;R_scl_min=.47;F_scl_min=.009;L_scl_max=.47;R_scl_max=.95;F_scl_max=.0165;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_OutRight_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

