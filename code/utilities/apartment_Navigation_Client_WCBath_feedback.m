for ii=k:length(C)
    leftRightEnlarge;
    if L_scl>=L_scl_max && R_scl<R_scl_max%moving to left
        deleteTrialPathSaveSelectedClass(TrialPath, selectedClassPath, 1);
        pause(1)
        % setting stations to default color and position
        setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
        setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
        setfield(object_nodes(24),'on',0)%Spot_Light_Kitchen
        %% Navigation from WCBath to WCBathFalse
        L=dist([Viewpoint.pos_WCBathDoor',Viewpoint.pos_WCBath']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_WCBathDoor(1),Viewpoint.pos_WCBath(1),L);
        y_pos=linspace(Viewpoint.pos_WCBathDoor(2),Viewpoint.pos_WCBath(2),L);
        z_pos=linspace(Viewpoint.pos_WCBathDoor(3),Viewpoint.pos_WCBath(3),L);
        x_ori=linspace(Viewpoint.ori_WCBathDoor(1),Viewpoint.ori_WCBath(1),L);
        y_ori=linspace(Viewpoint.ori_WCBathDoor(2),Viewpoint.ori_WCBath(2),L);
        z_ori=linspace(Viewpoint.ori_WCBathDoor(3),Viewpoint.ori_WCBath(3),L);
        rot_ori=linspace(Viewpoint.ori_WCBathDoor(4),Viewpoint.ori_WCBath(4),L);
        for i=floor(L):-1:1
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        L=100;
        x_pos=linspace(1.4,.904,L);
        y_pos=linspace(2,2,L);
        z_pos=linspace(-1,-.512,L);
        x_ori=linspace(0,0,L);
        y_ori=linspace(1,1,L);
        z_ori=linspace(0,0,L);
        rot_ori=linspace(pi/180*90,pi/180*180,L);
        for i=L:-1:1
            setfield(object_nodes(56),'translation',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(56),'rotation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        setfield(object_nodes(13),'on',0)%Spot_Light_toilet
        setfield(object_nodes(25),'on',1)%Spot_Light_diningtable
        L=dist([Viewpoint.pos_WCBathDoor',Viewpoint.pos_WCBathFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_WCBathFalse(1),Viewpoint.pos_WCBathDoor(1),L);
        y_pos=linspace(Viewpoint.pos_WCBathFalse(2),Viewpoint.pos_WCBathDoor(2),L);
        z_pos=linspace(Viewpoint.pos_WCBathFalse(3),Viewpoint.pos_WCBathDoor(3),L);
        x_ori=linspace(Viewpoint.ori_WCBathFalse(1),Viewpoint.ori_WCBathDoor(1),L);
        y_ori=linspace(-Viewpoint.ori_WCBathFalse(2),Viewpoint.ori_WCBathDoor(2),L);
        z_ori=linspace(Viewpoint.ori_WCBathFalse(3),Viewpoint.ori_WCBathDoor(3),L);
        rot_ori=linspace(-Viewpoint.ori_WCBathFalse(4)+6.283,Viewpoint.ori_WCBathDoor(4),L);
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
        %% Navigation from WCBath to WCBathTrue
        setfield(object_nodes(27),'position',[Viewpoint.pos_WCBathTrue(1) Viewpoint.pos_WCBathTrue(2) Viewpoint.pos_WCBathTrue(3)]);
        setfield(object_nodes(27),'orientation',[Viewpoint.ori_WCBathTrue(1) Viewpoint.ori_WCBathTrue(2) Viewpoint.ori_WCBathTrue(3) Viewpoint.ori_WCBathTrue(4)]);
        vrdrawnow
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    end
end
