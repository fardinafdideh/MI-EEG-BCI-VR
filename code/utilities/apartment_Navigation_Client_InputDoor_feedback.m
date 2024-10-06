for ii=k:length(C)
    leftRightFootEnlarge;
    if L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max%moving to left
deleteTrialPathSaveSelectedClass(TrialPath, selectedClassPath, 1);
        setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_Left
        setfield(object_nodes(5),'emissiveColor',[0 0 .3]);pause(eps)%Color_Station_Left
        pause(1)
        % setting stations to default color and position
        setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
        setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
        setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
        setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
        setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
        setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
        setfield(object_nodes(4),'diffuseColor',[1 0 0])%Color_Station_Right
        setfield(object_nodes(5),'diffuseColor',[1 0 0])%Color_Station_Left
        setfield(object_nodes(6),'diffuseColor',[1 0 0])%Color_Station_Front
        setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Color_Station_Right
        setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Color_Station_Left
        setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Color_Station_Front
        %% Navigation from Input_Door to Bed_Bath_Door
        L=dist([Viewpoint.pos_InputDoor',Viewpoint.pos_BedBathDoor']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_InputDoor(1),Viewpoint.pos_BedBathDoor(1),L);
        y_pos=linspace(Viewpoint.pos_InputDoor(2),Viewpoint.pos_BedBathDoor(2),L);
        z_pos=linspace(Viewpoint.pos_InputDoor(3),Viewpoint.pos_BedBathDoor(3),L);
        x_ori=linspace(Viewpoint.ori_InputDoor(1),Viewpoint.ori_BedBathDoor(1),L);
        y_ori=linspace(-Viewpoint.ori_InputDoor(2),Viewpoint.ori_BedBathDoor(2),L);
        z_ori=linspace(Viewpoint.ori_InputDoor(3),Viewpoint.ori_BedBathDoor(3),L);
        rot_ori=linspace(-Viewpoint.ori_InputDoor(4),Viewpoint.ori_BedBathDoor(4),L);
        for i=1:L
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    elseif R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max%moving to right
deleteTrialPathSaveSelectedClass(TrialPath, selectedClassPath, 2);
        setfield(object_nodes(4),'diffuseColor',[.8 .8 .01]);pause(eps)%Color_Station_Right
        setfield(object_nodes(4),'emissiveColor',[.3 .3 0]);pause(eps)%Color_Station_Right
        pause(1)
        % setting stations to default color and position
        setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
        setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
        setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
        setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
        setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
        setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
        setfield(object_nodes(4),'diffuseColor',[1 0 0])%Color_Station_Right
        setfield(object_nodes(5),'diffuseColor',[1 0 0])%Color_Station_Left
        setfield(object_nodes(6),'diffuseColor',[1 0 0])%Color_Station_Front
        setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Color_Station_Right
        setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Color_Station_Left
        setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Color_Station_Front
        setfield(object_nodes(25),'on',0)%Spot_Light_diningtable
        setfield(object_nodes(24),'on',1)%Spot_Light_kitchen
        %% Navigation from InputDoor to Kitchen
        L=dist([Viewpoint.pos_InputDoor',Viewpoint.pos_Kitchen']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_InputDoor(1),Viewpoint.pos_Kitchen(1),L);
        y_pos=linspace(Viewpoint.pos_InputDoor(2),Viewpoint.pos_Kitchen(2),L);
        z_pos=linspace(Viewpoint.pos_InputDoor(3),Viewpoint.pos_Kitchen(3),L);
        x_ori=linspace(Viewpoint.ori_InputDoor(1),Viewpoint.ori_Kitchen(1),L);
        y_ori=linspace(Viewpoint.ori_InputDoor(2),-Viewpoint.ori_Kitchen(2),L);
        z_ori=linspace(Viewpoint.ori_InputDoor(3),Viewpoint.ori_Kitchen(3),L);
        rot_ori=linspace(Viewpoint.ori_InputDoor(4),-Viewpoint.ori_Kitchen(4)+6.283,L);
        for i=1:L
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    elseif F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max%moving to front
deleteTrialPathSaveSelectedClass(TrialPath, selectedClassPath, 3);
        setfield(object_nodes(6),'diffuseColor',[.01 .8 .09]);pause(eps)%Color_Station_Front
        setfield(object_nodes(6),'emissiveColor',[0 .3 0]);pause(eps)%Color_Station_Front
        pause(1)
        % setting stations to default color and position
        setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
        setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
        setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
        setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
        setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
        setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
        setfield(object_nodes(4),'diffuseColor',[1 0 0])%Color_Station_Right
        setfield(object_nodes(5),'diffuseColor',[1 0 0])%Color_Station_Left
        setfield(object_nodes(6),'diffuseColor',[1 0 0])%Color_Station_Front
        setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Color_Station_Right
        setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Color_Station_Left
        setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Color_Station_Front
        %% Navigation from InputDoor to DiningTable
        L=dist([Viewpoint.pos_InputDoor',Viewpoint.pos_DiningTable']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_InputDoor(1),Viewpoint.pos_DiningTable(1),L);
        y_pos=linspace(Viewpoint.pos_InputDoor(2),Viewpoint.pos_DiningTable(2),L);
        z_pos=linspace(Viewpoint.pos_InputDoor(3),Viewpoint.pos_DiningTable(3),L);
        x_ori=linspace(Viewpoint.ori_InputDoor(1),Viewpoint.ori_DiningTable(1),L);
        y_ori=linspace(Viewpoint.ori_InputDoor(2),Viewpoint.ori_DiningTable(2),L);
        z_ori=linspace(Viewpoint.ori_InputDoor(3),Viewpoint.ori_DiningTable(3),L);
        rot_ori=linspace(Viewpoint.ori_InputDoor(4),Viewpoint.ori_DiningTable(4),L);
        for i=1:L
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    end
end
