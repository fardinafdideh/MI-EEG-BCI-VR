setfield(object_nodes(1),'translation',[.104 1.272 -4.788])%Station_front
setfield(object_nodes(3),'translation',[.904 1.2 -3.748])%Station_Right
setfield(object_nodes(2),'translation',[-1.496 1.2 -3.748])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.5*ones(1,3))%Right_Hand_Scale_Rot(.5-->1)
setfield(object_nodes(7),'rotation',[0 1 0 -pi/180*144])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.1 2.7 -3.85])%Right_Hand
setfield(object_nodes(9),'scale',.36*ones(1,3))%Left_Hand_Scale_Rot(.36-->.73)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*23.4])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-2.45 2.71 -3.5])%Left_Hand
setfield(object_nodes(11),'scale',.036*ones(1,3))%Tennis_Shoe_Right(.036-->.07)
setfield(object_nodes(11),'rotation',[.4984 .5998 .6259 pi/180*109.535])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-1.1977 1.65 -3.4991])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.36;R_scl_min=.5;F_scl_min=.036;L_scl_max=.73;R_scl_max=1;F_scl_max=.07;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_WCBathLeftFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

