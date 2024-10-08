trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[1.5091 1.2 .1014])%Station_front
setfield(object_nodes(3),'translation',[1.5091 1.2 -2.4665])%Station_Right
setfield(object_nodes(2),'translation',[1.5091 1.2 1.2203])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.085*ones(1,3))%Right_Hand_Scale_Rot(.085-->.17)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*113.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[4 1.87 -1.95])%Right_Hand
setfield(object_nodes(9),'scale',.065*ones(1,3))%Left_Hand_Scale_Rot(.065-->.136)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*126])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.46 1.71 -1.06])%Left_Hand
setfield(object_nodes(11),'scale',.019*ones(1,3))%Tennis_Shoe_Right(.019-->.038)
setfield(object_nodes(11),'rotation',[-.709 -.6976 .1037 pi/180*167.4])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[2.9489 1.74 -1.15])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.065;R_scl_min=.085;F_scl_min=.019;L_scl_max=.136;R_scl_max=.17;F_scl_max=.038;
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
        %% Navigation from WCBathFalse to BedBathDoor
        L=dist([Viewpoint.pos_BedBathDoor',Viewpoint.pos_WCBathFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_WCBathFalse(1),Viewpoint.pos_BedBathDoor(1),L);
        y_pos=linspace(Viewpoint.pos_WCBathFalse(2),Viewpoint.pos_BedBathDoor(2),L);
        z_pos=linspace(Viewpoint.pos_WCBathFalse(3),Viewpoint.pos_BedBathDoor(3),L);
        x_ori=linspace(Viewpoint.ori_WCBathFalse(1),Viewpoint.ori_BedBathDoor(1),L);
        y_ori=linspace(Viewpoint.ori_WCBathFalse(2),-Viewpoint.ori_BedBathDoor(2),L);
        z_ori=linspace(Viewpoint.ori_WCBathFalse(3),Viewpoint.ori_BedBathDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_WCBathFalse(4),-Viewpoint.ori_BedBathDoor(4)+6.283,L);
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
        %% Navigation from WCBathFalse to Salon
        setfield(object_nodes(26),'on',1);%Spot_Light_salon
setfield(object_nodes(25),'on',0);%Spot_Dining_Table
        L=dist([Viewpoint.pos_Salon',Viewpoint.pos_WCBathFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_WCBathFalse(1),Viewpoint.pos_Salon(1),L);
        y_pos=linspace(Viewpoint.pos_WCBathFalse(2),Viewpoint.pos_Salon(2),L);
        z_pos=linspace(Viewpoint.pos_WCBathFalse(3),Viewpoint.pos_Salon(3),L);
        x_ori=linspace(Viewpoint.ori_WCBathFalse(1),Viewpoint.ori_Salon(1),L);
        y_ori=linspace(-Viewpoint.ori_WCBathFalse(2),Viewpoint.ori_Salon(2),L);
        z_ori=linspace(Viewpoint.ori_WCBathFalse(3),Viewpoint.ori_Salon(3),L);
        rot_ori=linspace(-Viewpoint.ori_WCBathFalse(4)+6.283,Viewpoint.ori_Salon(4),L);
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
        %% Navigation from WCBathFalse to Bedroom
        L=dist([Viewpoint.pos_WCBathFalse',Viewpoint.pos_BedroomDoor']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_WCBathFalse(1),Viewpoint.pos_BedroomDoor(1),L);
        y_pos=linspace(Viewpoint.pos_WCBathFalse(2),Viewpoint.pos_BedroomDoor(2),L);
        z_pos=linspace(Viewpoint.pos_WCBathFalse(3),Viewpoint.pos_BedroomDoor(3),L);
        x_ori=linspace(Viewpoint.ori_WCBathFalse(1),Viewpoint.ori_BedroomDoor(1),L);
        y_ori=linspace(-Viewpoint.ori_WCBathFalse(2),Viewpoint.ori_BedroomDoor(2),L);
        z_ori=linspace(Viewpoint.ori_WCBathFalse(3),Viewpoint.ori_BedroomDoor(3),L);
        rot_ori=linspace(-Viewpoint.ori_WCBathFalse(4)+6.283,Viewpoint.ori_BedroomDoor(4),L);
        for i=1:L
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
for i=1:L
    setfield(object_nodes(55),'translation',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(55),'rotation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        L=dist([Viewpoint.pos_Bedroom',Viewpoint.pos_BedroomDoor']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_Bedroom(1),Viewpoint.pos_BedroomDoor(1),L);
        y_pos=linspace(Viewpoint.pos_Bedroom(2),Viewpoint.pos_BedroomDoor(2),L);
        z_pos=linspace(Viewpoint.pos_Bedroom(3),Viewpoint.pos_BedroomDoor(3),L);
        x_ori=linspace(Viewpoint.ori_Bedroom(1),Viewpoint.ori_BedroomDoor(1),L);
        y_ori=linspace(Viewpoint.ori_Bedroom(2),Viewpoint.ori_BedroomDoor(2),L);
        z_ori=linspace(Viewpoint.ori_Bedroom(3),Viewpoint.ori_BedroomDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_Bedroom(4),Viewpoint.ori_BedroomDoor(4),L);
        for i=floor(L):-1:1
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(23),'on',1)%Spot_Light_Bedroom
setfield(object_nodes(25),'on',0)%Spot_Light_Dining_Table
        break
    end
end
delete(classPath)

