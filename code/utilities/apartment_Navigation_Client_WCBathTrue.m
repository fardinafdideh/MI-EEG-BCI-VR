setfield(object_nodes(1),'translation',[-2.2704 1.2 -2.9952])%Station_front
setfield(object_nodes(3),'translation',[-1.32 1.2 -4.8268])%Station_Right
setfield(object_nodes(2),'translation',[-2.2704 1.2 -1.7792])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.095*ones(1,3))%Right_Hand_Scale_Rot(.095-->.195)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*163.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.22 2.12 -1.9548])%Right_Hand
setfield(object_nodes(9),'scale',.06*ones(1,3))%Left_Hand_Scale_Rot(.06-->.12)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*82.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.2604 1.93 -1.06])%Left_Hand
setfield(object_nodes(11),'scale',.01*ones(1,3))%Tennis_Shoe_Right(.01-->.02)
setfield(object_nodes(11),'rotation',[.6957 .6928 .1896 pi/180*158.0915])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[.7385 2.18 -1.5067])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.06;R_scl_min=.095;F_scl_min=.01;L_scl_max=.12;R_scl_max=.195;F_scl_max=.02;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_WCBathTrue_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

