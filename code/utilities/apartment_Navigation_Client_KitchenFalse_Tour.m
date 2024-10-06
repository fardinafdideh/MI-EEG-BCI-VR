trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[1.9091 1.2 .9511])%Station_front
setfield(object_nodes(2),'translation',[1.9091 1.2 3.2511])%Station_Left
setfield(object_nodes(3),'translation',[4.0091 1.6 -.9489])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.085*ones(1,3))%Right_Hand_Scale_Rot(.085-->.171)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*120.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[7.1 2.5549 .25])%Right_Hand
setfield(object_nodes(9),'scale',.085*ones(1,3))%Left_Hand_Scale_Rot(.085-->.171)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*115.2])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[7.2408 2.43 1.21])%Left_Hand
setfield(object_nodes(11),'scale',.0325*ones(1,3))%Tennis_Shoe_Right(.0325-->.065)
setfield(object_nodes(11),'rotation',[.7132 .701 .0073 pi/180*179.7101])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[4.8493 2.1378 .6226])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.085;R_scl_min=.085;F_scl_min=.0325;L_scl_max=.171;R_scl_max=.171;F_scl_max=.065;
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
        %% Navigation from KitchenFalse to InputDoor
        L=dist([Viewpoint.pos_InputDoor',Viewpoint.pos_KitchenFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_KitchenFalse(1),Viewpoint.pos_InputDoor(1),L);
        y_pos=linspace(Viewpoint.pos_KitchenFalse(2),Viewpoint.pos_InputDoor(2),L);
        z_pos=linspace(Viewpoint.pos_KitchenFalse(3),Viewpoint.pos_InputDoor(3),L);
        x_ori=linspace(Viewpoint.ori_KitchenFalse(1),Viewpoint.ori_InputDoor(1),L);
        y_ori=linspace(Viewpoint.ori_KitchenFalse(2),-Viewpoint.ori_InputDoor(2),L);
        z_ori=linspace(Viewpoint.ori_KitchenFalse(3),Viewpoint.ori_InputDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_KitchenFalse(4),-Viewpoint.ori_InputDoor(4),L);
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
        %% Navigation from KitchenFalse to DiningTable
        L=dist([Viewpoint.pos_DiningTable',Viewpoint.pos_KitchenFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_KitchenFalse(1),Viewpoint.pos_DiningTable(1),L);
        y_pos=linspace(Viewpoint.pos_KitchenFalse(2),Viewpoint.pos_DiningTable(2),L);
        z_pos=linspace(Viewpoint.pos_KitchenFalse(3),Viewpoint.pos_DiningTable(3),L);
        x_ori=linspace(Viewpoint.ori_KitchenFalse(1),Viewpoint.ori_DiningTable(1),L);
        y_ori=linspace(-Viewpoint.ori_KitchenFalse(2),Viewpoint.ori_DiningTable(2),L);
        z_ori=linspace(Viewpoint.ori_KitchenFalse(3),Viewpoint.ori_DiningTable(3),L);
        rot_ori=linspace(-Viewpoint.ori_KitchenFalse(4),Viewpoint.ori_DiningTable(4),L);
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
        %% Navigation from KitchenFalse to BedBathDoor
        L=dist([Viewpoint.pos_KitchenFalse',Viewpoint.pos_BedBathDoor']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_KitchenFalse(1),Viewpoint.pos_BedBathDoor(1),L);
        y_pos=linspace(Viewpoint.pos_KitchenFalse(2),Viewpoint.pos_BedBathDoor(2),L);
        z_pos=linspace(Viewpoint.pos_KitchenFalse(3),Viewpoint.pos_BedBathDoor(3),L);
        x_ori=linspace(Viewpoint.ori_KitchenFalse(1),Viewpoint.ori_BedBathDoor(1),L);
        y_ori=linspace(Viewpoint.ori_KitchenFalse(2),Viewpoint.ori_BedBathDoor(2),L);
        z_ori=linspace(Viewpoint.ori_KitchenFalse(3),Viewpoint.ori_BedBathDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_KitchenFalse(4),Viewpoint.ori_BedBathDoor(4),L);
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

