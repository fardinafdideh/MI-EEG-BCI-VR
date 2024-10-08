trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[3.55 1.2 -1.2])%Station_front
setfield(object_nodes(2),'translation',[1.75 1.2 -1.6])%Station_Left
setfield(object_nodes(3),'translation',[4 1.2 1])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.135*ones(1,3))%Right_Hand_Scale_Rot(.135-->.27)
setfield(object_nodes(7),'rotation',[-.018 -.9929 .1177 pi/180*151.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[2.92 2.25 3.3])%Right_Hand
setfield(object_nodes(9),'scale',.1*ones(1,3))%Left_Hand_Scale_Rot(.1-->.21)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*1.8001])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[2.12 2.06 3.4])%Left_Hand
setfield(object_nodes(11),'scale',.009*ones(1,3))%Tennis_Shoe_Right(.009-->.018)
setfield(object_nodes(11),'rotation',[.7 .5774 .8 pi/180*120])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[2.25 2.25 3.5])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.1;R_scl_min=.135;F_scl_min=.009;L_scl_max=.21;R_scl_max=.27;F_scl_max=.018;
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
delete(classPath)

