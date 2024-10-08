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
        %% Navigation from WCBath to WCBathLeft
        L=100;
        x_pos=linspace(Viewpoint.pos_WCBath(1),Viewpoint.pos_WCBathLeft(1),L);
        y_pos=linspace(Viewpoint.pos_WCBath(2),Viewpoint.pos_WCBathLeft(2),L);
        z_pos=linspace(Viewpoint.pos_WCBath(3),Viewpoint.pos_WCBathLeft(3),L);
        x_ori=linspace(Viewpoint.ori_WCBath(1),Viewpoint.ori_WCBathLeft(1),L);
        y_ori=linspace(Viewpoint.ori_WCBath(2),Viewpoint.ori_WCBathLeft(2),L);
        z_ori=linspace(Viewpoint.ori_WCBath(3),Viewpoint.ori_WCBathLeft(3),L);
        rot_ori=linspace(Viewpoint.ori_WCBath(4),Viewpoint.ori_WCBathLeft(4),L);
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
        %% Navigation from WCBath to WCBathRight
        L=100;
        x_pos=linspace(Viewpoint.pos_WCBathRight(1),Viewpoint.pos_WCBath(1),L);
        y_pos=linspace(Viewpoint.pos_WCBathRight(2),Viewpoint.pos_WCBath(2),L);
        z_pos=linspace(Viewpoint.pos_WCBathRight(3),Viewpoint.pos_WCBath(3),L);
        x_ori=linspace(Viewpoint.ori_WCBathRight(1),Viewpoint.ori_WCBath(1),L);
        y_ori=linspace(Viewpoint.ori_WCBathRight(2),Viewpoint.ori_WCBath(2),L);
        z_ori=linspace(Viewpoint.ori_WCBathRight(3),Viewpoint.ori_WCBath(3),L);
        rot_ori=linspace(Viewpoint.ori_WCBathRight(4),Viewpoint.ori_WCBath(4),L);
        for i=L:-1:1
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
        %% Navigation from WCBath to WCBathFront
        L=100;
        x_pos=linspace(Viewpoint.pos_WCBath(1),Viewpoint.pos_WCBathFront(1),L);
        y_pos=linspace(Viewpoint.pos_WCBath(2),Viewpoint.pos_WCBathFront(2),L);
        z_pos=linspace(Viewpoint.pos_WCBath(3),Viewpoint.pos_WCBathFront(3),L);
        x_ori=linspace(Viewpoint.ori_WCBath(1),Viewpoint.ori_WCBathFront(1),L);
        y_ori=linspace(Viewpoint.ori_WCBath(2),Viewpoint.ori_WCBathFront(2),L);
        z_ori=linspace(Viewpoint.ori_WCBath(3),Viewpoint.ori_WCBathFront(3),L);
        rot_ori=linspace(Viewpoint.ori_WCBath(4),Viewpoint.ori_WCBathFront(4),L);
        for i=1:L
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    end
end
