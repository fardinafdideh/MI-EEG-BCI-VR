setfield(object_nodes(1),'translation',[.6296 1.2 .6])%Station_front
setfield(object_nodes(3),'translation',[1.0616 1.2 4.084])%Station_Right
setfield(object_nodes(2),'translation',[-1.4224 1.2 .8])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.36*ones(1,3))%Right_Hand_Scale_Rot(.36-->.75)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*129.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[.75 2.4 4.4584])%Right_Hand
setfield(object_nodes(9),'scale',.065*ones(1,3))%Left_Hand_Scale_Rot(.065-->.13)
setfield(object_nodes(9),'rotation',[0 1 0 -pi/180*15])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-1.25 1.78 5.8672])%Left_Hand
setfield(object_nodes(11),'scale',.0065*ones(1,3))%Tennis_Shoe_Right(.0065-->.0135)
setfield(object_nodes(11),'rotation',[.5276 .6216 .5798 pi/180*113])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-1.3118 2.1 5.8353])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L_scl_min=.065;R_scl_min=.36;F_scl_min=.0065;L_scl_max=.13;R_scl_max=.75;F_scl_max=.0135;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
pauseSaveTrial; % Pause before sending the command (save trial.mat) to BCI workstation to start the classification
while 1
    if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
        loadCheckCorrupt;
        if ~isCorrupt
            apartment_Navigation_Client_BedroomFrontFalse_feedback;
            k=length(C)+1;
            class_ind=class_ind+class_ind_inc;
        end
    end
    if (L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max) || (R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max) || (F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max)
        loadKClass_updateKClassInd;
        break
    end
end

