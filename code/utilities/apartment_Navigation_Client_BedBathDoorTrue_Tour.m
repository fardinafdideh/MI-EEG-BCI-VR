trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[1.568 1.2 -.8376])%Station_front
setfield(object_nodes(2),'translation',[1.568 1.2 .1624])%Station_Left
setfield(object_nodes(3),'translation',[1.768 1.2 -7.0376])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.105*ones(1,3))%Right_Hand_Scale_Rot(.105-->.21)
setfield(object_nodes(7),'rotation',[-.0224 -.994 -.0273 -pi/180*180])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.63 1.91 1.226])%Right_Hand
setfield(object_nodes(9),'scale',.275*ones(1,3))%Left_Hand_Scale_Rot(.275-->.55)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*55.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.9 2.15 1.0736])%Left_Hand
setfield(object_nodes(11),'scale',.0105*ones(1,3))%Tennis_Shoe_Right(.0105-->.021)
setfield(object_nodes(11),'rotation',[.6559 .6449 .3923 pi/180*141.0473])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[3.1 1.95 1.4327])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.275;R_scl_min=.105;F_scl_min=.0105;L_scl_max=.55;R_scl_max=.21;F_scl_max=.021;
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
        %% Navigation from BedBathDoor to Bedroom
        L=dist([Viewpoint.pos_BedroomDoor',Viewpoint.pos_BedBathDoor']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomDoor(1),Viewpoint.pos_BedBathDoor(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomDoor(2),Viewpoint.pos_BedBathDoor(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomDoor(3),Viewpoint.pos_BedBathDoor(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomDoor(1),Viewpoint.ori_BedBathDoor(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomDoor(2),Viewpoint.ori_BedBathDoor(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomDoor(3),Viewpoint.ori_BedBathDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomDoor(4),Viewpoint.ori_BedBathDoor(4),L);
        for i=floor(L):-1:1
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        L=100;%opening bedroom door
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
         setfield(object_nodes(26),'on',1)%Spot_Light_salon        
        %% Navigation from BedBathDoor to salon
        L=dist([Viewpoint.pos_BedroomDoor',Viewpoint.pos_Salon']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_Salon(1),Viewpoint.pos_BedBathDoor(1),L);
        y_pos=linspace(Viewpoint.pos_Salon(2),Viewpoint.pos_BedBathDoor(2),L);
        z_pos=linspace(Viewpoint.pos_Salon(3),Viewpoint.pos_BedBathDoor(3),L);
        x_ori=linspace(Viewpoint.ori_Salon(1),Viewpoint.ori_BedBathDoor(1),L);
        y_ori=linspace(Viewpoint.ori_Salon(2),Viewpoint.ori_BedBathDoor(2),L);
        z_ori=linspace(Viewpoint.ori_Salon(3),Viewpoint.ori_BedBathDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_Salon(4),Viewpoint.ori_BedBathDoor(4),L);
        for i=floor(L):-1:1
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
        %% Navigation from BedBathDoor to WCBath
        L=dist([Viewpoint.pos_BedBathDoor',Viewpoint.pos_WCBathDoor']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedBathDoor(1),Viewpoint.pos_WCBathDoor(1),L);
        y_pos=linspace(Viewpoint.pos_BedBathDoor(2),Viewpoint.pos_WCBathDoor(2),L);
        z_pos=linspace(Viewpoint.pos_BedBathDoor(3),Viewpoint.pos_WCBathDoor(3),L);
        x_ori=linspace(Viewpoint.ori_BedBathDoor(1),Viewpoint.ori_WCBathDoor(1),L);
        y_ori=linspace(Viewpoint.ori_BedBathDoor(2),Viewpoint.ori_WCBathDoor(2),L);
        z_ori=linspace(Viewpoint.ori_BedBathDoor(3),Viewpoint.ori_WCBathDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_BedBathDoor(4),Viewpoint.ori_WCBathDoor(4),L);
        for i=1:L
            setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
            setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
            vrdrawnow
        end
        set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        L=100;%opening the door
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
        L=dist([Viewpoint.pos_WCBath',Viewpoint.pos_WCBathDoor']);
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
delete(classPath)

