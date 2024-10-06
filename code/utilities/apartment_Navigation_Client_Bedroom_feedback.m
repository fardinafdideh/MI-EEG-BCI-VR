for ii=k:length(C)
    leftRightEnlarge;
    if L_scl>=L_scl_max && R_scl<R_scl_max%moving to left
deleteTrialPathSaveSelectedClass(TrialPath, selectedClassPath, 1);
        pause(1)
        % setting stations to default color and position
        setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
        setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
        %% Navigation from Bedroom to BedroomFalse
        L=dist([Viewpoint.pos_BedroomDoor',Viewpoint.pos_Bedroom']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomDoor(1),Viewpoint.pos_Bedroom(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomDoor(2),Viewpoint.pos_Bedroom(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomDoor(3),Viewpoint.pos_Bedroom(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomDoor(1),Viewpoint.ori_Bedroom(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomDoor(2),Viewpoint.ori_Bedroom(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomDoor(3),Viewpoint.ori_Bedroom(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomDoor(4),Viewpoint.ori_Bedroom(4),L);
        for i=floor(L):-1:1
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        L=100;
        x_pos=linspace(1.392,.955,L);
        y_pos=linspace(2,2,L);
        z_pos=linspace(.003,-.39,L);
        x_ori=linspace(0,0,L);
        y_ori=linspace(1,1,L);
        z_ori=linspace(0,0,L);
        rot_ori=linspace(pi/180*90,pi/180*0,L);
        for i=L:-1:1
            setfield(object_nodes(55),'translation',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(55),'rotation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        setfield(object_nodes(23),'on',0)%Spot_Light_bedroom
        setfield(object_nodes(25),'on',1)%Spot_Light_diningtable
        L=dist([Viewpoint.pos_BedroomDoor',Viewpoint.pos_BedroomFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomDoor(1),Viewpoint.pos_BedroomFalse(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomDoor(2),Viewpoint.pos_BedroomFalse(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomDoor(3),Viewpoint.pos_BedroomFalse(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomDoor(1),Viewpoint.ori_BedroomFalse(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomDoor(2),Viewpoint.ori_BedroomFalse(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomDoor(3),Viewpoint.ori_BedroomFalse(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomDoor(4),Viewpoint.ori_BedroomFalse(4),L);
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
        %% Navigation from Bedroom to BedroomTrue
        setfield(object_nodes(27),'position',[Viewpoint.pos_BedroomTrue(1) Viewpoint.pos_BedroomTrue(2) Viewpoint.pos_BedroomTrue(3)]);
        setfield(object_nodes(27),'orientation',[Viewpoint.ori_BedroomTrue(1) Viewpoint.ori_BedroomTrue(2) Viewpoint.ori_BedroomTrue(3) Viewpoint.ori_BedroomTrue(4)]);
        vrdrawnow
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    end
end
