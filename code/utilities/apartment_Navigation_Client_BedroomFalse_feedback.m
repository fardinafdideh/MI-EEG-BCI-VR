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
        %% Navigation from BedroomFalse to BedBathDoor
        L=dist([Viewpoint.pos_BedBathDoor',Viewpoint.pos_BedroomFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomFalse(1),Viewpoint.pos_BedBathDoor(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomFalse(2),Viewpoint.pos_BedBathDoor(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomFalse(3),Viewpoint.pos_BedBathDoor(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomFalse(1),Viewpoint.ori_BedBathDoor(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomFalse(2),Viewpoint.ori_BedBathDoor(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomFalse(3),Viewpoint.ori_BedBathDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomFalse(4),Viewpoint.ori_BedBathDoor(4),L);
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
        %% Navigation from BedroomFalse to Salon
        setfield(object_nodes(26),'on',1);%Spot_Light_Salon
        setfield(object_nodes(25),'on',0);%Spot_Light_diningtable
        L=dist([Viewpoint.pos_Salon',Viewpoint.pos_BedroomFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomFalse(1),Viewpoint.pos_Salon(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomFalse(2),Viewpoint.pos_Salon(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomFalse(3),Viewpoint.pos_Salon(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomFalse(1),Viewpoint.ori_Salon(1),L);
        y_ori=linspace(-Viewpoint.ori_BedroomFalse(2),Viewpoint.ori_Salon(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomFalse(3),Viewpoint.ori_Salon(3),L);
        rot_ori=linspace(-Viewpoint.ori_BedroomFalse(4),Viewpoint.ori_Salon(4),L);
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
        %% Navigation from BedroomFalse to WCBathDoor
        L=dist([Viewpoint.pos_BedroomFalse',Viewpoint.pos_WCBathDoor']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomFalse(1),Viewpoint.pos_WCBathDoor(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomFalse(2),Viewpoint.pos_WCBathDoor(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomFalse(3),Viewpoint.pos_WCBathDoor(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomFalse(1),Viewpoint.ori_WCBathDoor(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomFalse(2),Viewpoint.ori_WCBathDoor(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomFalse(3),Viewpoint.ori_WCBathDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomFalse(4),Viewpoint.ori_WCBathDoor(4),L);
        for i=1:L
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
        for i=1:L
            setfield(object_nodes(56),'translation',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(56),'rotation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        L=dist([Viewpoint.pos_WCBathDoor',Viewpoint.pos_WCBath']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_WCBathDoor(1),Viewpoint.pos_WCBath(1),L);
        y_pos=linspace(Viewpoint.pos_WCBathDoor(2),Viewpoint.pos_WCBath(2),L);
        z_pos=linspace(Viewpoint.pos_WCBathDoor(3),Viewpoint.pos_WCBath(3),L);
        x_ori=linspace(Viewpoint.ori_WCBathDoor(1),Viewpoint.ori_WCBath(1),L);
        y_ori=linspace(Viewpoint.ori_WCBathDoor(2),Viewpoint.ori_WCBath(2),L);
        z_ori=linspace(Viewpoint.ori_WCBathDoor(3),Viewpoint.ori_WCBath(3),L);
        rot_ori=linspace(Viewpoint.ori_WCBathDoor(4),Viewpoint.ori_WCBath(4),L);
        for i=1:L
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        setfield(object_nodes(13),'on',1)%Spot_Light_toilet
        setfield(object_nodes(25),'on',0)%Spot_Light_diningtable
        break
    end
end
