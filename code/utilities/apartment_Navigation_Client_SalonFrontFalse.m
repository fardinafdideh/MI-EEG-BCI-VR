setfield(object_nodes(1),'translation',[1.9486 1.2 -6.788])%Station_front
setfield(object_nodes(3),'translation',[-.8354 1.2 -7.484])%Station_Right
setfield(object_nodes(2),'translation',[3.1186 1.2 -10.415])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.155*ones(1,3))%Right_Hand_Scale_Rot(.155-->.31)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*16.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.579 1.88 -11.7])%Right_Hand
setfield(object_nodes(9),'scale',.335*ones(1,3))%Left_Hand_Scale_Rot(.335-->.67)
setfield(object_nodes(9),'rotation',[0 -1 0 -pi/180*99])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[.016 2.1 -12.1])%Left_Hand
setfield(object_nodes(11),'scale',.025*ones(1,3))%Tennis_Shoe_Right(.025-->.05)
setfield(object_nodes(11),'rotation',[-.3175 -.2752 .9075 pi/180*99.0467])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-1.446 1.55 -11.1])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.335;R_scl_min=.155;F_scl_min=.025;L_scl_max=.67;R_scl_max=.31;F_scl_max=.05;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_SalonFrontFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

