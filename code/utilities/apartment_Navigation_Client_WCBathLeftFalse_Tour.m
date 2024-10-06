trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[.104 1.272 -4.788])%Station_front
setfield(object_nodes(3),'translation',[.904 1.2 -3.748])%Station_Right
setfield(object_nodes(2),'translation',[-1.496 1.2 -3.748])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.5*ones(1,3))%Right_Hand_Scale_Rot(.5-->1)
setfield(object_nodes(7),'rotation',[0 1 0 -pi/180*144])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.1 2.7 -3.85])%Right_Hand
setfield(object_nodes(9),'scale',.36*ones(1,3))%Left_Hand_Scale_Rot(.36-->.73)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*23.4])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-2.45 2.71 -3.5])%Left_Hand
setfield(object_nodes(11),'scale',.036*ones(1,3))%Tennis_Shoe_Right(.036-->.07)
setfield(object_nodes(11),'rotation',[.4984 .5998 .6259 pi/180*109.535])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-1.1977 1.65 -3.4991])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.36;R_scl_min=.5;F_scl_min=.036;L_scl_max=.73;R_scl_max=1;F_scl_max=.07;
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
        %% Navigation from WCBathLeftFalse to WCBathFront
        L=dist([Viewpoint.pos_WCBathLeftFalse',Viewpoint.pos_WCBathFront']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_WCBathLeftFalse(1),Viewpoint.pos_WCBathFront(1),L);
        y_pos=linspace(Viewpoint.pos_WCBathLeftFalse(2),Viewpoint.pos_WCBathFront(2),L);
        z_pos=linspace(Viewpoint.pos_WCBathLeftFalse(3),Viewpoint.pos_WCBathFront(3),L);
        x_ori=linspace(Viewpoint.ori_WCBathLeftFalse(1),Viewpoint.ori_WCBathFront(1),L);
        y_ori=linspace(Viewpoint.ori_WCBathLeftFalse(2),Viewpoint.ori_WCBathFront(2),L);
        z_ori=linspace(Viewpoint.ori_WCBathLeftFalse(3),Viewpoint.ori_WCBathFront(3),L);
        rot_ori=linspace(Viewpoint.ori_WCBathLeftFalse(4),Viewpoint.ori_WCBathFront(4),L);
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
        %% Navigation from WCBathLeftFalse to WCBath
L=dist([Viewpoint.pos_WCBath',Viewpoint.pos_WCBathLeftFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_WCBathLeftFalse(1),Viewpoint.pos_WCBath(1),L);
y_pos=linspace(Viewpoint.pos_WCBathLeftFalse(2),Viewpoint.pos_WCBath(2),L);
z_pos=linspace(Viewpoint.pos_WCBathLeftFalse(3),Viewpoint.pos_WCBath(3),L);
x_ori=linspace(Viewpoint.ori_WCBathLeftFalse(1),Viewpoint.ori_WCBath(1),L);
y_ori=linspace(Viewpoint.ori_WCBathLeftFalse(2),Viewpoint.ori_WCBath(2),L);
z_ori=linspace(Viewpoint.ori_WCBathLeftFalse(3),Viewpoint.ori_WCBath(3),L);
rot_ori=linspace(Viewpoint.ori_WCBathLeftFalse(4),Viewpoint.ori_WCBath(4),L);
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
        %% Navigation from WCBathLeftFalse to WCBathRight
        L=dist([Viewpoint.pos_WCBathRight',Viewpoint.pos_WCBathLeftFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_WCBathLeftFalse(1),Viewpoint.pos_WCBathRight(1),L);
        y_pos=linspace(Viewpoint.pos_WCBathLeftFalse(2),Viewpoint.pos_WCBathRight(2),L);
        z_pos=linspace(Viewpoint.pos_WCBathLeftFalse(3),Viewpoint.pos_WCBathRight(3),L);
        x_ori=linspace(Viewpoint.ori_WCBathLeftFalse(1),Viewpoint.ori_WCBathRight(1),L);
        y_ori=linspace(Viewpoint.ori_WCBathLeftFalse(2),Viewpoint.ori_WCBathRight(2),L);
        z_ori=linspace(Viewpoint.ori_WCBathLeftFalse(3),Viewpoint.ori_WCBathRight(3),L);
        rot_ori=linspace(Viewpoint.ori_WCBathLeftFalse(4),Viewpoint.ori_WCBathRight(4),L);
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

