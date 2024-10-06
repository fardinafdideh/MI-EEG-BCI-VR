setfield(object_nodes(1),'translation',[1.104 1.2 -.648])%Station_front
setfield(object_nodes(3),'translation',[-2.296 1.2 -.748])%Station_Right
setfield(object_nodes(2),'translation',[1.104 1.2 -2.5])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.355*ones(1,3))%Right_Hand_Scale_Rot(.355-->.71)
setfield(object_nodes(7),'rotation',[0 1 0 -pi/180*0])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.6 2.6 -2])%Right_Hand
setfield(object_nodes(9),'scale',.35*ones(1,3))%Left_Hand_Scale_Rot(.35-->.7)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*120])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[.38 2.73 -3.1])%Left_Hand
setfield(object_nodes(11),'scale',.024*ones(1,3))%Tennis_Shoe_Right(.024-->.048)
setfield(object_nodes(11),'rotation',[-.4419 -.4351 .7845 pi/180*113.5282])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-1.5 2.1 -2.8])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.35;R_scl_min=.355;F_scl_min=.024;L_scl_max=.7;R_scl_max=.71;F_scl_max=.048;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_WCBathFrontFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

