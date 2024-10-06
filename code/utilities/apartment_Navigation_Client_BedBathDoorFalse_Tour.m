trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[4.1091 1.2 2.0511])%Station_front
setfield(object_nodes(2),'translation',[4.5091 1.5 -.9489])%Station_Left
setfield(object_nodes(3),'translation',[2.8091 1.2 3.0511])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.14*ones(1,3))%Right_Hand_Scale_Rot(.14-->.28)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*5.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[2.18 2.52 -2.1])%Right_Hand
setfield(object_nodes(9),'scale',.2*ones(1,3))%Left_Hand_Scale_Rot(.2-->.4)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*108])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[3.9152 2.54 -2.3])%Left_Hand
setfield(object_nodes(11),'scale',.041*ones(1,3))%Tennis_Shoe_Right(.041-->.082)
setfield(object_nodes(11),'rotation',[-.4 -.5 .8852 pi/180*90])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[4.05 1.85 -.17])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.2;R_scl_min=.14;F_scl_min=.041;L_scl_max=.4;R_scl_max=.28;F_scl_max=.082;
L_scl=L_scl_min;R_scl=R_scl_min;F_scl=F_scl_min;%max and min of scales
while ~exist(classPath, 'file')
end
pause(.2)
load(classPath)
for i=k:length(C)
    if C(i)==1 && L_scl<L_scl_max %left hand enlarging
        setfield(object_nodes(9),'scale',(L_scl+(L_scl_max-L_scl_min)/15)*ones(1,3));pause(eps)%Left_Hand_Scale_Rot(.77-->1.6)
        L_scl=L_scl+(L_scl_max-L_scl_min)/15;
    elseif C(i)==2 && R_scl<R_scl_max  %right hand enlarging
        setfield(object_nodes(7),'scale',(R_scl+(R_scl_max-R_scl_min)/15)*ones(1,3));pause(eps)%Left_Hand_Scale_Rot(.77-->1.6)
        R_scl=R_scl+(R_scl_max-R_scl_min)/15;            
    elseif C(i)==3 && F_scl<F_scl_max  %foot enlarging
        setfield(object_nodes(11),'scale',(F_scl+(F_scl_max-F_scl_min)/15)*ones(1,3));pause(eps)%Left_Hand_Scale_Rot(.77-->1.6)
        F_scl=F_scl+(F_scl_max-F_scl_min)/15;                        
    elseif L_scl>=L_scl_max && R_scl<R_scl_max && F_scl<F_scl_max%moving to left
        delete(trialPath);% end of feature extraction and classification
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
        %% Navigation from BedBathDoorFalse to DiningTable
        L=dist([Viewpoint.pos_DiningTable',Viewpoint.pos_BedBathDoorFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedBathDoorFalse(1),Viewpoint.pos_DiningTable(1),L);
        y_pos=linspace(Viewpoint.pos_BedBathDoorFalse(2),Viewpoint.pos_DiningTable(2),L);
        z_pos=linspace(Viewpoint.pos_BedBathDoorFalse(3),Viewpoint.pos_DiningTable(3),L);
        x_ori=linspace(Viewpoint.ori_BedBathDoorFalse(1),Viewpoint.ori_DiningTable(1),L);
        y_ori=linspace(Viewpoint.ori_BedBathDoorFalse(2),Viewpoint.ori_DiningTable(2),L);
        z_ori=linspace(Viewpoint.ori_BedBathDoorFalse(3),Viewpoint.ori_DiningTable(3),L);
        rot_ori=linspace(Viewpoint.ori_BedBathDoorFalse(4),Viewpoint.ori_DiningTable(4),L);
        for i=1:L
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    elseif R_scl>=R_scl_max && L_scl<L_scl_max && F_scl<F_scl_max%moving to right
        delete(trialPath);% end of feature extraction and classification
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
        %% Navigation from BedBathDoorFalse to InputDoor
        L=dist([Viewpoint.pos_InputDoor',Viewpoint.pos_BedBathDoorFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedBathDoorFalse(1),Viewpoint.pos_InputDoor(1),L);
        y_pos=linspace(Viewpoint.pos_BedBathDoorFalse(2),Viewpoint.pos_InputDoor(2),L);
        z_pos=linspace(Viewpoint.pos_BedBathDoorFalse(3),Viewpoint.pos_InputDoor(3),L);
        x_ori=linspace(Viewpoint.ori_BedBathDoorFalse(1),Viewpoint.ori_InputDoor(1),L);
        y_ori=linspace(Viewpoint.ori_BedBathDoorFalse(2),Viewpoint.ori_InputDoor(2),L);
        z_ori=linspace(Viewpoint.ori_BedBathDoorFalse(3),Viewpoint.ori_InputDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_BedBathDoorFalse(4),Viewpoint.ori_InputDoor(4),L);
        for i=1:L
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');        
        break
    elseif F_scl>=F_scl_max && R_scl<R_scl_max && L_scl<L_scl_max%moving to front
        delete(trialPath);% end of feature extraction and classification
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
        %% Navigation from BedBathDoorFalse to BedBathDoor
        L=dist([Viewpoint.pos_BedBathDoorFalse',Viewpoint.pos_Kitchen']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedBathDoorFalse(1),Viewpoint.pos_Kitchen(1),L);
        y_pos=linspace(Viewpoint.pos_BedBathDoorFalse(2),Viewpoint.pos_Kitchen(2),L);
        z_pos=linspace(Viewpoint.pos_BedBathDoorFalse(3),Viewpoint.pos_Kitchen(3),L);
        x_ori=linspace(Viewpoint.ori_BedBathDoorFalse(1),Viewpoint.ori_Kitchen(1),L);
        y_ori=linspace(-Viewpoint.ori_BedBathDoorFalse(2),Viewpoint.ori_Kitchen(2),L);
        z_ori=linspace(Viewpoint.ori_BedBathDoorFalse(3),Viewpoint.ori_Kitchen(3),L);
        rot_ori=linspace(-Viewpoint.ori_BedBathDoorFalse(4)+6.283,Viewpoint.ori_Kitchen(4),L);
        for i=1:L
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    end
end
delete(classPath)
