trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[3.1646 1.2 -9.584])%Station_front
setfield(object_nodes(3),'translation',[1.4646 1.2 -7.784])%Station_Right
setfield(object_nodes(2),'translation',[.1646  1.2 -11.784])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.155*ones(1,3))%Right_Hand_Scale_Rot(.155-->.31)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*93.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-1 2.16 -7.53])%Right_Hand
setfield(object_nodes(9),'scale',.295*ones(1,3))%Left_Hand_Scale_Rot(.295-->.59)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*27])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-1 2.3 -9.4093])%Left_Hand
setfield(object_nodes(11),'scale',.03*ones(1,3))%Tennis_Shoe_Right(.03-->.06)
setfield(object_nodes(11),'rotation',[.3477 .3243 .8798 pi/180*96.6378])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-.2434 1.75 -8.5])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.295;R_scl_min=.155;F_scl_min=.03;L_scl_max=.59;R_scl_max=.31;F_scl_max=.06;
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
        %% Navigation from SalonLeftFalse to SalonFront
L=dist([Viewpoint.pos_SalonFront',Viewpoint.pos_SalonLeftFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_SalonLeftFalse(1),Viewpoint.pos_SalonFront(1),L);
y_pos=linspace(Viewpoint.pos_SalonLeftFalse(2),Viewpoint.pos_SalonFront(2),L);
z_pos=linspace(Viewpoint.pos_SalonLeftFalse(3),Viewpoint.pos_SalonFront(3),L);
x_ori=linspace(Viewpoint.ori_SalonLeftFalse(1),Viewpoint.ori_SalonFront(1),L);
y_ori=linspace(Viewpoint.ori_SalonLeftFalse(2),Viewpoint.ori_SalonFront(2),L);
z_ori=linspace(Viewpoint.ori_SalonLeftFalse(3),Viewpoint.ori_SalonFront(3),L);
rot_ori=linspace(Viewpoint.ori_SalonLeftFalse(4),Viewpoint.ori_SalonFront(4),L);
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
        %% Navigation from SalonLeftFalse to Salon
        L=dist([Viewpoint.pos_Salon',Viewpoint.pos_SalonLeftFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_SalonLeftFalse(1),Viewpoint.pos_Salon(1),L);
        y_pos=linspace(Viewpoint.pos_SalonLeftFalse(2),Viewpoint.pos_Salon(2),L);
        z_pos=linspace(Viewpoint.pos_SalonLeftFalse(3),Viewpoint.pos_Salon(3),L);
        x_ori=linspace(Viewpoint.ori_SalonLeftFalse(1),Viewpoint.ori_Salon(1),L);
        y_ori=linspace(Viewpoint.ori_SalonLeftFalse(2),Viewpoint.ori_Salon(2),L);
        z_ori=linspace(Viewpoint.ori_SalonLeftFalse(3),Viewpoint.ori_Salon(3),L);
        rot_ori=linspace(Viewpoint.ori_SalonLeftFalse(4)-6.283,Viewpoint.ori_Salon(4),L);
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
        %% Navigation from SalonLeftFalse to SalonRight
        L=dist([Viewpoint.pos_SalonRight',Viewpoint.pos_SalonLeftFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_SalonLeftFalse(1),Viewpoint.pos_SalonRight(1),L);
        y_pos=linspace(Viewpoint.pos_SalonLeftFalse(2),Viewpoint.pos_SalonRight(2),L);
        z_pos=linspace(Viewpoint.pos_SalonLeftFalse(3),Viewpoint.pos_SalonRight(3),L);
        x_ori=linspace(Viewpoint.ori_SalonLeftFalse(1),Viewpoint.ori_SalonRight(1),L);
        y_ori=linspace(-Viewpoint.ori_SalonLeftFalse(2),Viewpoint.ori_SalonRight(2),L);
        z_ori=linspace(Viewpoint.ori_SalonLeftFalse(3),Viewpoint.ori_SalonRight(3),L);
        rot_ori=linspace(-Viewpoint.ori_SalonLeftFalse(4)+6.283,Viewpoint.ori_SalonRight(4),L);
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

