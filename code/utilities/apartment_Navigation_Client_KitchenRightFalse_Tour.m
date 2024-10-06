trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[6.5 1.2 2.9])%Station_front
setfield(object_nodes(2),'translation',[4.4 1.2 1])%Station_Left
setfield(object_nodes(3),'translation',[6.6304 1.1892 4.28])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.3*ones(1,3))%Right_Hand_Scale_Rot(.3-->.6)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 -pi/180*111])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[6.037 2.38 4.95])%Right_Hand
setfield(object_nodes(9),'scale',.05*ones(1,3))%Left_Hand_Scale_Rot(.05-->.105)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*0])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.255 1.83 5.5])%Left_Hand
setfield(object_nodes(11),'scale',.045*ones(1,3))%Tennis_Shoe_Right(.045-->.09)
setfield(object_nodes(11),'rotation',[.4756 .4429 .76 pi/180*108])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[6 1.4 3])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.05;R_scl_min=.3;F_scl_min=.045;L_scl_max=.105;R_scl_max=.6;F_scl_max=.09;
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
        %% Navigation from KitchenRightFalse to InputDoor
        L=dist([Viewpoint.pos_KitchenRightFalse',Viewpoint.pos_Kitchen']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_KitchenRightFalse(1),Viewpoint.pos_Kitchen(1),L);
        y_pos=linspace(Viewpoint.pos_KitchenRightFalse(2),Viewpoint.pos_Kitchen(2),L);
        z_pos=linspace(Viewpoint.pos_KitchenRightFalse(3),Viewpoint.pos_Kitchen(3),L);
        x_ori=linspace(Viewpoint.ori_KitchenRightFalse(1),Viewpoint.ori_Kitchen(1),L);
        y_ori=linspace(-Viewpoint.ori_KitchenRightFalse(2),Viewpoint.ori_Kitchen(2),L);
        z_ori=linspace(Viewpoint.ori_KitchenRightFalse(3),Viewpoint.ori_Kitchen(3),L);
        rot_ori=linspace(-Viewpoint.ori_KitchenRightFalse(4),Viewpoint.ori_Kitchen(4)-6.283,L);
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
        %% Navigation from KitchenRightFalse to KitchenFront
        L=dist([Viewpoint.pos_KitchenRightFalse',Viewpoint.pos_KitchenFront']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_KitchenRightFalse(1),Viewpoint.pos_KitchenFront(1),L);
        y_pos=linspace(Viewpoint.pos_KitchenRightFalse(2),Viewpoint.pos_KitchenFront(2),L);
        z_pos=linspace(Viewpoint.pos_KitchenRightFalse(3),Viewpoint.pos_KitchenFront(3),L);
        x_ori=linspace(Viewpoint.ori_KitchenRightFalse(1),Viewpoint.ori_KitchenFront(1),L);
        y_ori=linspace(Viewpoint.ori_KitchenRightFalse(2),-Viewpoint.ori_KitchenFront(2),L);
        z_ori=linspace(Viewpoint.ori_KitchenRightFalse(3),Viewpoint.ori_KitchenFront(3),L);
        rot_ori=linspace(Viewpoint.ori_KitchenRightFalse(4),-Viewpoint.ori_KitchenFront(4)+6.283,L);
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
        %% Navigation from KitchenRightFalse to KitchenLeft
        L=dist([Viewpoint.pos_KitchenRightFalse',Viewpoint.pos_KitchenLeft']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_KitchenRightFalse(1),Viewpoint.pos_KitchenLeft(1),L);
        y_pos=linspace(Viewpoint.pos_KitchenRightFalse(2),Viewpoint.pos_KitchenLeft(2),L);
        z_pos=linspace(Viewpoint.pos_KitchenRightFalse(3),Viewpoint.pos_KitchenLeft(3),L);
        x_ori=linspace(Viewpoint.ori_KitchenRightFalse(1),Viewpoint.ori_KitchenLeft(1),L);
        y_ori=linspace(-Viewpoint.ori_KitchenRightFalse(2),Viewpoint.ori_KitchenLeft(2),L);
        z_ori=linspace(Viewpoint.ori_KitchenRightFalse(3),Viewpoint.ori_KitchenLeft(3),L);
        rot_ori=linspace(-Viewpoint.ori_KitchenRightFalse(4),Viewpoint.ori_KitchenLeft(4)-6.283,L);
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

