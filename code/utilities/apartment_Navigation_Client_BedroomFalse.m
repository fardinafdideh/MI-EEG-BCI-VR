setfield(object_nodes(1),'translation',[1.5091 1.2 -1.0697])%Station_front
setfield(object_nodes(3),'translation',[1.5091 1.408 -3.4825])%Station_Right
setfield(object_nodes(2),'translation',[1.5091 1.2 1.5511])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.092*ones(1,3))%Right_Hand_Scale_Rot(.092-->.185)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*136.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[5.584 2.27 -.27])%Right_Hand
setfield(object_nodes(9),'scale',.07*ones(1,3))%Left_Hand_Scale_Rot(.07-->.141)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*100.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[5.7216 2.12 .675])%Left_Hand
setfield(object_nodes(11),'scale',.027*ones(1,3))%Tennis_Shoe_Right(.027-->.055)
setfield(object_nodes(11),'rotation',[.7121 .6996 .0589 pi/180*173.7003])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[3.7497 2 .0315])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.07;R_scl_min=.092;F_scl_min=.027;L_scl_max=.141;R_scl_max=.185;F_scl_max=.055;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_BedroomFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

