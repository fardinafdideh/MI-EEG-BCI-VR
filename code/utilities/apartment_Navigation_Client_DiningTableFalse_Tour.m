trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[2.568 1.2 3.232])%Station_front
setfield(object_nodes(2),'translation',[3.768 1.2 2.232])%Station_Left
setfield(object_nodes(3),'translation',[2.1 1.2 -.9])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.105*ones(1,3))%Right_Hand_Scale_Rot(.105-->.21)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*68.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[4 2.26 -3.41])%Right_Hand
setfield(object_nodes(9),'scale',.043*ones(1,3))%Left_Hand_Scale_Rot(.043-->.087)
setfield(object_nodes(9),'rotation',[.036 .9969 -.0706 -pi/180*163.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.94 2.035 -3])%Left_Hand
setfield(object_nodes(11),'scale',.0095*ones(1,3))%Tennis_Shoe_Right(.0095-->.019)
setfield(object_nodes(11),'rotation',[-.6749 -.6349 .3761 pi/180*140.4])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[4.1699 2.32 -2.75])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.043;R_scl_min=.105;F_scl_min=.0095;L_scl_max=.087;R_scl_max=.21;F_scl_max=.019;
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
        %% Navigation from DiningTableFalse to Kitchen
                setfield(object_nodes(25),'on',0)%Spot_Light_diningtable          
                setfield(object_nodes(24),'on',1)%Spot_Light_kitchen
        L=dist([Viewpoint.pos_Kitchen',Viewpoint.pos_DiningTableFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_Kitchen(1),Viewpoint.pos_DiningTableFalse(1),L);
        y_pos=linspace(Viewpoint.pos_Kitchen(2),Viewpoint.pos_DiningTableFalse(2),L);
        z_pos=linspace(Viewpoint.pos_Kitchen(3),Viewpoint.pos_DiningTableFalse(3),L);
        x_ori=linspace(Viewpoint.ori_Kitchen(1),Viewpoint.ori_DiningTableFalse(1),L);
        y_ori=linspace(-Viewpoint.ori_Kitchen(2),Viewpoint.ori_DiningTableFalse(2),L);
        z_ori=linspace(Viewpoint.ori_Kitchen(3),Viewpoint.ori_DiningTableFalse(3),L);
        rot_ori=linspace(-Viewpoint.ori_Kitchen(4)+6.283,Viewpoint.ori_DiningTableFalse(4),L);
        for i=floor(L):-1:1
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
        %% Navigation from DiningTableFalse to BedBathDoor
        L=dist([Viewpoint.pos_BedBathDoor',Viewpoint.pos_DiningTableFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_DiningTableFalse(1),Viewpoint.pos_BedBathDoor(1),L);
        y_pos=linspace(Viewpoint.pos_DiningTableFalse(2),Viewpoint.pos_BedBathDoor(2),L);
        z_pos=linspace(Viewpoint.pos_DiningTableFalse(3),Viewpoint.pos_BedBathDoor(3),L);
        x_ori=linspace(Viewpoint.ori_DiningTableFalse(1),Viewpoint.ori_BedBathDoor(1),L);
        y_ori=linspace(Viewpoint.ori_DiningTableFalse(2),-Viewpoint.ori_BedBathDoor(2),L);
        z_ori=linspace(Viewpoint.ori_DiningTableFalse(3),Viewpoint.ori_BedBathDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_DiningTableFalse(4)-6.283,-Viewpoint.ori_BedBathDoor(4),L);
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
        %% Navigation from DiningTableFalse to InputDoor
        L=dist([Viewpoint.pos_InputDoor',Viewpoint.pos_DiningTableFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_DiningTableFalse(1),Viewpoint.pos_InputDoor(1),L);
        y_pos=linspace(Viewpoint.pos_DiningTableFalse(2),Viewpoint.pos_InputDoor(2),L);
        z_pos=linspace(Viewpoint.pos_DiningTableFalse(3),Viewpoint.pos_InputDoor(3),L);
        x_ori=linspace(Viewpoint.ori_DiningTableFalse(1),Viewpoint.ori_InputDoor(1),L);
        y_ori=linspace(Viewpoint.ori_DiningTableFalse(2),Viewpoint.ori_InputDoor(2),L);
        z_ori=linspace(Viewpoint.ori_DiningTableFalse(3),Viewpoint.ori_InputDoor(3),L);
        rot_ori=linspace(Viewpoint.ori_DiningTableFalse(4),Viewpoint.ori_InputDoor(4),L);
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

