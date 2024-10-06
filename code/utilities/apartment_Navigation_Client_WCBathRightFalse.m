setfield(object_nodes(1),'translation',[-1.592 1.2 -2.348])%Station_front
setfield(object_nodes(3),'translation',[-2.6 1.2 -.748])%Station_Right
setfield(object_nodes(2),'translation',[1.1296 1.2 -1.0376])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.255*ones(1,3))%Right_Hand_Scale_Rot(.255-->.51)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*32.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.45 2.5 -4.36])%Right_Hand
setfield(object_nodes(9),'scale',.3*ones(1,3))%Left_Hand_Scale_Rot(.3-->.6)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*144])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[0.12 2.5 -3.714])%Left_Hand
setfield(object_nodes(11),'scale',.0225*ones(1,3))%Tennis_Shoe_Right(.0225-->.045)
setfield(object_nodes(11),'rotation',[-.5641 -.5 .6565 pi/180*118.4381])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-1.4502 2 -3.8408])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.3;R_scl_min=.255;F_scl_min=.0225;L_scl_max=.6;R_scl_max=.51;F_scl_max=.045;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_WCBathRightFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end