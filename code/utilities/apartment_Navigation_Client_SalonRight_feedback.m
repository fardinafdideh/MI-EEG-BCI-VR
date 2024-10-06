for ii=k:length(C)
    leftRightEnlarge;
    if L_scl>=L_scl_max && R_scl<R_scl_max%moving to left
deleteTrialPathSaveSelectedClass(TrialPath, selectedClassPath, 1);
        pause(1)
        % setting stations to default color and position
        setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
        setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
        %% Navigation from SalonRight to SalonRightFalse
        L=dist([Viewpoint.pos_SalonRight',Viewpoint.pos_SalonRightFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_SalonRight(1),Viewpoint.pos_SalonRightFalse(1),L);
        y_pos=linspace(Viewpoint.pos_SalonRight(2),Viewpoint.pos_SalonRightFalse(2),L);
        z_pos=linspace(Viewpoint.pos_SalonRight(3),Viewpoint.pos_SalonRightFalse(3),L);
        x_ori=linspace(Viewpoint.ori_SalonRight(1),Viewpoint.ori_SalonRightFalse(1),L);
        y_ori=linspace(-Viewpoint.ori_SalonRight(2),Viewpoint.ori_SalonRightFalse(2),L);
        z_ori=linspace(Viewpoint.ori_SalonRight(3),Viewpoint.ori_SalonRightFalse(3),L);
        rot_ori=linspace(-Viewpoint.ori_SalonRight(4),Viewpoint.ori_SalonRightFalse(4),L);
        for i=1:L
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
