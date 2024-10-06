for ii=k:length(C)
    leftRightEnlarge;
    if L_scl>=L_scl_max && R_scl<R_scl_max%moving to left
deleteTrialPathSaveSelectedClass(TrialPath, selectedClassPath, 1);
        pause(1)
        % setting stations to default color and position
        setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
        setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
        % Navigation from KitchenLeft to KitchenLeftFalse
        L=dist([Viewpoint.pos_KitchenLeftFalse',Viewpoint.pos_KitchenLeft']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_KitchenLeftFalse(1),Viewpoint.pos_KitchenLeft(1),L);
        y_pos=linspace(Viewpoint.pos_KitchenLeftFalse(2),Viewpoint.pos_KitchenLeft(2),L);
        z_pos=linspace(Viewpoint.pos_KitchenLeftFalse(3),Viewpoint.pos_KitchenLeft(3),L);
        x_ori=linspace(Viewpoint.ori_KitchenLeftFalse(1),Viewpoint.ori_KitchenLeft(1),L);
        y_ori=linspace(Viewpoint.ori_KitchenLeftFalse(2),Viewpoint.ori_KitchenLeft(2),L);
        z_ori=linspace(Viewpoint.ori_KitchenLeftFalse(3),Viewpoint.ori_KitchenLeft(3),L);
        rot_ori=linspace(Viewpoint.ori_KitchenLeftFalse(4),Viewpoint.ori_KitchenLeft(4),L);
        for i=floor(L):-1:1
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    elseif R_scl>=R_scl_max && L_scl<L_scl_max%moving to right
deleteTrialPathSaveSelectedClass(TrialPath, selectedClassPath, 2);
        pause(1)
        % setting stations to default color and position
        setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
        setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
        % Stop Navigation
        Navigation=0;
        break
    end
end
