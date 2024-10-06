trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[1.584 1.2 .176])%Station_front
setfield(object_nodes(3),'translation',[1.496 1.2 -1.256])%Station_Right
setfield(object_nodes(2),'translation',[1.872 1.2 1.936])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.065*ones(1,3))%Right_Hand_Scale_Rot(.065-->.135)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*39.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[2.78 2.141 -5.2])%Right_Hand
setfield(object_nodes(9),'scale',.07*ones(1,3))%Left_Hand_Scale_Rot(.07-->.14)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*153])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[3.61 2.025 -4.7905])%Left_Hand
setfield(object_nodes(11),'scale',.016*ones(1,3))%Tennis_Shoe_Right(.016-->.032)
setfield(object_nodes(11),'rotation',[-.5611 -.5621 .6077 pi/180*115.552])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[2.92 2.15 -3.9927])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.07;R_scl_min=.065;F_scl_min=.016;L_scl_max=.14;R_scl_max=.135;F_scl_max=.032;
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
        %% Navigation from SalonFalse to BedBathDoor
        L=dist([Viewpoint.pos_BedBathDoor',Viewpoint.pos_SalonFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_SalonFalse(1),Viewpoint.pos_BedBathDoor(1),L);
        y_pos=linspace(Viewpoint.pos_SalonFalse(2),Viewpoint.pos_BedBathDoor(2),L);
        z_pos=linspace(Viewpoint.pos_SalonFalse(3),Viewpoint.pos_BedBathDoor(3),L);
        x_ori=linspace(Viewpoint.ori_SalonFalse(1),Viewpoint.ori_BedBathDoor(1),L);
        y_ori=linspace(Viewpoint.ori_SalonFalse(2),-Viewpoint.ori_BedBathDoor(2),L);
        z_ori=linspace(Viewpoint.ori_SalonFalse(3),Viewpoint.ori_BedBathDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_SalonFalse(4),-Viewpoint.ori_BedBathDoor(4),L);
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
        %% Navigation from SalonFalse to WCBath
        L=dist([Viewpoint.pos_WCBathDoor',Viewpoint.pos_SalonFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_SalonFalse(1),Viewpoint.pos_WCBathDoor(1),L);
        y_pos=linspace(Viewpoint.pos_SalonFalse(2),Viewpoint.pos_WCBathDoor(2),L);
        z_pos=linspace(Viewpoint.pos_SalonFalse(3),Viewpoint.pos_WCBathDoor(3),L);
        x_ori=linspace(Viewpoint.ori_SalonFalse(1),Viewpoint.ori_WCBathDoor(1),L);
        y_ori=linspace(-Viewpoint.ori_SalonFalse(2),Viewpoint.ori_WCBathDoor(2),L);
        z_ori=linspace(Viewpoint.ori_SalonFalse(3),Viewpoint.ori_WCBathDoor(3),L);
        rot_ori=linspace(-Viewpoint.ori_SalonFalse(4)+6.283,Viewpoint.ori_WCBathDoor(4),L);
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
        %% Navigation from SalonFalse to Bedroom
        L=dist([Viewpoint.pos_SalonFalse',Viewpoint.pos_BedroomDoor']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_SalonFalse(1),Viewpoint.pos_BedroomDoor(1),L);
        y_pos=linspace(Viewpoint.pos_SalonFalse(2),Viewpoint.pos_BedroomDoor(2),L);
        z_pos=linspace(Viewpoint.pos_SalonFalse(3),Viewpoint.pos_BedroomDoor(3),L);
        x_ori=linspace(Viewpoint.ori_SalonFalse(1),Viewpoint.ori_BedroomDoor(1),L);
        y_ori=linspace(Viewpoint.ori_SalonFalse(2),Viewpoint.ori_BedroomDoor(2),L);
        z_ori=linspace(Viewpoint.ori_SalonFalse(3),Viewpoint.ori_BedroomDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_SalonFalse(4),Viewpoint.ori_BedroomDoor(4),L);
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
L=dist([Viewpoint.pos_BedroomDoor',Viewpoint.pos_Bedroom']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_BedroomDoor(1),Viewpoint.pos_Bedroom(1),L);
y_pos=linspace(Viewpoint.pos_BedroomDoor(2),Viewpoint.pos_Bedroom(2),L);
z_pos=linspace(Viewpoint.pos_BedroomDoor(3),Viewpoint.pos_Bedroom(3),L);
x_ori=linspace(Viewpoint.ori_BedroomDoor(1),Viewpoint.ori_Bedroom(1),L);
y_ori=linspace(Viewpoint.ori_BedroomDoor(2),Viewpoint.ori_Bedroom(2),L);
z_ori=linspace(Viewpoint.ori_BedroomDoor(3),Viewpoint.ori_Bedroom(3),L);
rot_ori=linspace(Viewpoint.ori_BedroomDoor(4),Viewpoint.ori_Bedroom(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(23),'on',1)%Spot_Light_bedroom 
setfield(object_nodes(25),'on',0)%Spot_Light_diningtable
        break
    end
end
delete(classPath)
