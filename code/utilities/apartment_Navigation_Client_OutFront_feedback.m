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
        %% Navigation from OutFront to OutLeft
        L=dist([Viewpoint.pos_OutFront',Viewpoint.pos_OutLeft']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_OutFront(1),Viewpoint.pos_OutLeft(1),L);
        y_pos=linspace(Viewpoint.pos_OutFront(2),Viewpoint.pos_OutLeft(2),L);
        z_pos=linspace(Viewpoint.pos_OutFront(3),Viewpoint.pos_OutLeft(3),L);
        x_ori=linspace(Viewpoint.ori_OutFront(1),Viewpoint.ori_OutLeft(1),L);
        y_ori=linspace(Viewpoint.ori_OutFront(2),-Viewpoint.ori_OutLeft(2),L);
        z_ori=linspace(Viewpoint.ori_OutFront(3),Viewpoint.ori_OutLeft(3),L);
        rot_ori=linspace(Viewpoint.ori_OutFront(4),-Viewpoint.ori_OutLeft(4),L);
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
        %% Navigation from OutFront to OutRight
        L=dist([Viewpoint.pos_OutFront',Viewpoint.pos_OutRight']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_OutFront(1),Viewpoint.pos_OutRight(1),L);
        y_pos=linspace(Viewpoint.pos_OutFront(2),Viewpoint.pos_OutRight(2),L);
        z_pos=linspace(Viewpoint.pos_OutFront(3),Viewpoint.pos_OutRight(3),L);
        x_ori=linspace(Viewpoint.ori_OutFront(1),Viewpoint.ori_OutRight(1),L);
        y_ori=linspace(Viewpoint.ori_OutFront(2),-Viewpoint.ori_OutRight(2),L);
        z_ori=linspace(Viewpoint.ori_OutFront(3),Viewpoint.ori_OutRight(3),L);
        rot_ori=linspace(Viewpoint.ori_OutFront(4),-Viewpoint.ori_OutRight(4)+6.283,L);
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
        %% Navigation from OutFront to InputDoor
        L=dist([Viewpoint.pos_OutFront',Viewpoint.pos_InputDoor2']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_OutFront(1),Viewpoint.pos_InputDoor2(1),L);
        y_pos=linspace(Viewpoint.pos_OutFront(2),Viewpoint.pos_InputDoor2(2),L);
        z_pos=linspace(Viewpoint.pos_OutFront(3),Viewpoint.pos_InputDoor2(3),L);
        x_ori=linspace(Viewpoint.ori_OutFront(1),Viewpoint.ori_InputDoor2(1),L);
        y_ori=linspace(Viewpoint.ori_OutFront(2),-Viewpoint.ori_InputDoor2(2),L);
        z_ori=linspace(Viewpoint.ori_OutFront(3),Viewpoint.ori_InputDoor2(3),L);
        rot_ori=linspace(Viewpoint.ori_OutFront(4),-Viewpoint.ori_InputDoor2(4),L);
        for i=1:L
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        L=100;%open the door
        x_pos=linspace(5500,4785,L);
        y_pos=linspace(1250,1250,L);
        z_pos=linspace(-1500,-2287.8647,L);
        x_ori=linspace(0,0,L);
        y_ori=linspace(1,1,L);
        z_ori=linspace(0,0,L);
        rot_ori=linspace(0,pi/180*80,L);
        for i=1:L
            setfield(object_nodes(54),'translation',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(54),'rotation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        L=dist([Viewpoint.pos_InputDoor',Viewpoint.pos_InputDoor2']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_InputDoor2(1),Viewpoint.pos_InputDoor(1),L);
        y_pos=linspace(Viewpoint.pos_InputDoor2(2),Viewpoint.pos_InputDoor(2),L);
        z_pos=linspace(Viewpoint.pos_InputDoor2(3),Viewpoint.pos_InputDoor(3),L);
        x_ori=linspace(Viewpoint.ori_InputDoor2(1),Viewpoint.ori_InputDoor(1),L);
        y_ori=linspace(Viewpoint.ori_InputDoor2(2),Viewpoint.ori_InputDoor(2),L);
        z_ori=linspace(Viewpoint.ori_InputDoor2(3),Viewpoint.ori_InputDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_InputDoor2(4),Viewpoint.ori_InputDoor(4),L);
        for i=1:L
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        setfield(object_nodes(54),'translation',[5500 1250 -1500]);%Input_Door_rot
        setfield(object_nodes(54),'rotation',[0 1 0 0]);%Input_Door_rot
        setfield(object_nodes(15),'on',0)%Spot_Light_Left3
        setfield(object_nodes(16),'on',0)%Spot_Light_Left2
        setfield(object_nodes(17),'on',0)%Spot_Light_Left1
        setfield(object_nodes(18),'on',0)%Spot_Light_Right1
        setfield(object_nodes(19),'on',0)%Spot_Light_Right2
        setfield(object_nodes(21),'on',0)%Spot_Light_Right3
        setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
        setfield(object_nodes(25),'on',1)%Spot_Light_diningtable
        break
    end
end
