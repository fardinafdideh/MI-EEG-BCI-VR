setfield(object_nodes(1),'translation',[-1.6654 1.2 .844])%Station_front
setfield(object_nodes(3),'translation',[1.0562 1.2 .3176])%Station_Right
setfield(object_nodes(2),'translation',[-1.6654 1.2 2.7368])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.165*ones(1,3))%Right_Hand_Scale_Rot(.165-->.34)
setfield(object_nodes(7),'rotation',[0 1 0 -pi/180*163.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.12 2.0 4.4])%Right_Hand
setfield(object_nodes(9),'scale',.2*ones(1,3))%Left_Hand_Scale_Rot(.2-->.4)
setfield(object_nodes(9),'rotation',[0 1 0 -pi/180*37.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-.2 1.97 4.6704])%Left_Hand
setfield(object_nodes(11),'scale',.006*ones(1,3))%Tennis_Shoe_Right(.006-->.012)
setfield(object_nodes(11),'rotation',[.593 .669 .4481 pi/180*123.154])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[.49 2.03 5.3352])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.2;R_scl_min=.165;F_scl_min=.006;L_scl_max=.4;R_scl_max=.34;F_scl_max=.012;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_BedroomLeftFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

