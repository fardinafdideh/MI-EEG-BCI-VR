setfield(object_nodes(1),'translation',[-.9704 1.2 3.7208])%Station_front
setfield(object_nodes(3),'translation',[-1.4704 1.2 1.6208])%Station_Right
setfield(object_nodes(2),'translation',[.6296 1.2 5.0208])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.095*ones(1,3))%Right_Hand_Scale_Rot(.095-->.19)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*81])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[.7 1.93 -.42])%Right_Hand
setfield(object_nodes(9),'scale',.095*ones(1,3))%Left_Hand_Scale_Rot(.095-->.185)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*162])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.58 1.8 .366])%Left_Hand
setfield(object_nodes(11),'scale',.008*ones(1,3))%Tennis_Shoe_Right(.008-->.016)
setfield(object_nodes(11),'rotation',[.7 .7 -.3 -pi/180*145.8])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[.9176 2.03 .1368])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.095;R_scl_min=.095;F_scl_min=.008;L_scl_max=.185;R_scl_max=.19;F_scl_max=.016;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_BedroomTrue_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

