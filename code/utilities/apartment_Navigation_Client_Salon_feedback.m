for ii=k:length(C)
    leftRightEnlarge;
    if L_scl>=L_scl_max && R_scl<R_scl_max%moving to left
        deleteTrialPathSaveSelectedClass(TrialPath, selectedClassPath, 1);
        pause(1)
        % setting stations to default color and position
        setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
        setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
        %% Navigation from salon to salonFalse
        setfield(object_nodes(26),'on',0)%Spot_Light_salon
        setfield(object_nodes(25),'on',1)%Spot_Light_diningtable
        L=dist([Viewpoint.pos_SalonFalse',Viewpoint.pos_Salon']);
        L=L(1,2)/.005;%exception
        x_pos=linspace(Viewpoint.pos_SalonFalse(1),Viewpoint.pos_Salon(1),L);
        y_pos=linspace(Viewpoint.pos_SalonFalse(2),Viewpoint.pos_Salon(2),L);
        z_pos=linspace(Viewpoint.pos_SalonFalse(3),Viewpoint.pos_Salon(3),L);
        x_ori=linspace(Viewpoint.ori_SalonFalse(1),Viewpoint.ori_Salon(1),L);
        y_ori=linspace(-Viewpoint.ori_SalonFalse(2),Viewpoint.ori_Salon(2),L);
        z_ori=linspace(Viewpoint.ori_SalonFalse(3),Viewpoint.ori_Salon(3),L);
        rot_ori=linspace(-Viewpoint.ori_SalonFalse(4)+6.283,Viewpoint.ori_Salon(4),L);
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
        %% Navigation from Salon to SalonTrue
        setfield(object_nodes(27),'position',[Viewpoint.pos_SalonTrue(1) Viewpoint.pos_SalonTrue(2) Viewpoint.pos_SalonTrue(3)]);
        setfield(object_nodes(27),'orientation',[Viewpoint.ori_SalonTrue(1) Viewpoint.ori_SalonTrue(2) Viewpoint.ori_SalonTrue(3) Viewpoint.ori_SalonTrue(4)]);
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    end
end
