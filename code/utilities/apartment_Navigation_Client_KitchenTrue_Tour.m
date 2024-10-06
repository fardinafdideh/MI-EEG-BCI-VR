trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[5.75 1.2 4.4])%Station_front
setfield(object_nodes(2),'translation',[6.5 1.2 2.5])%Station_Left
setfield(object_nodes(3),'translation',[4.4 1.2 3.8])%Station_right
vrdrawnow;
setfield(object_nodes(7),'scale',.35*ones(1,3))%Right_Hand_Scale_Rot(.35-->.7)
setfield(object_nodes(7),'rotation',[-.018 -.9929 .1177 pi/180*12.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.4 2.7 1.8])%Right_Hand
setfield(object_nodes(9),'scale',.2*ones(1,3))%Left_Hand_Scale_Rot(.2-->.4)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*111.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[5.25 2.32 .1])%Left_Hand
setfield(object_nodes(11),'scale',.045*ones(1,3))%Tennis_Shoe_Right(.045-->.09)
setfield(object_nodes(11),'rotation',[-.5 -.5 1 pi/180*96.7152])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[5.2 1.6 2.5])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.2;R_scl_min=.35;F_scl_min=.045;L_scl_max=.4;R_scl_max=.7;F_scl_max=.09;
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
        %% Navigation from Kitchen to KitchenLeft
        L=dist([Viewpoint.pos_Kitchen',Viewpoint.pos_KitchenLeft']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_Kitchen(1),Viewpoint.pos_KitchenLeft(1),L);
        y_pos=linspace(Viewpoint.pos_Kitchen(2),Viewpoint.pos_KitchenLeft(2),L);
        z_pos=linspace(Viewpoint.pos_Kitchen(3),Viewpoint.pos_KitchenLeft(3),L);
        x_ori=linspace(Viewpoint.ori_Kitchen(1),Viewpoint.ori_KitchenLeft(1),L);
        y_ori=linspace(Viewpoint.ori_Kitchen(2),Viewpoint.ori_KitchenLeft(2),L);
        z_ori=linspace(Viewpoint.ori_Kitchen(3),Viewpoint.ori_KitchenLeft(3),L);
        rot_ori=linspace(Viewpoint.ori_Kitchen(4),Viewpoint.ori_KitchenLeft(4),L);
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
        %% Navigation from Kitchen to KitchenRight
        L=dist([Viewpoint.pos_Kitchen',Viewpoint.pos_KitchenRight']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_Kitchen(1),Viewpoint.pos_KitchenRight(1),L);
        y_pos=linspace(Viewpoint.pos_Kitchen(2),Viewpoint.pos_KitchenRight(2),L);
        z_pos=linspace(Viewpoint.pos_Kitchen(3),Viewpoint.pos_KitchenRight(3),L);
        x_ori=linspace(Viewpoint.ori_Kitchen(1),Viewpoint.ori_KitchenRight(1),L);
        y_ori=linspace(Viewpoint.ori_Kitchen(2),Viewpoint.ori_KitchenRight(2),L);
        z_ori=linspace(Viewpoint.ori_Kitchen(3),Viewpoint.ori_KitchenRight(3),L);
        rot_ori=linspace(Viewpoint.ori_Kitchen(4),Viewpoint.ori_KitchenRight(4),L);
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
        %% Navigation from Kitchen to KitchenFront
        L=dist([Viewpoint.pos_Kitchen',Viewpoint.pos_KitchenFront']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_Kitchen(1),Viewpoint.pos_KitchenFront(1),L);
        y_pos=linspace(Viewpoint.pos_Kitchen(2),Viewpoint.pos_KitchenFront(2),L);
        z_pos=linspace(Viewpoint.pos_Kitchen(3),Viewpoint.pos_KitchenFront(3),L);
        x_ori=linspace(Viewpoint.ori_Kitchen(1),Viewpoint.ori_KitchenFront(1),L);
        y_ori=linspace(Viewpoint.ori_Kitchen(2),Viewpoint.ori_KitchenFront(2),L);
        z_ori=linspace(Viewpoint.ori_Kitchen(3),Viewpoint.ori_KitchenFront(3),L);
        rot_ori=linspace(Viewpoint.ori_Kitchen(4),Viewpoint.ori_KitchenFront(4),L);
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
