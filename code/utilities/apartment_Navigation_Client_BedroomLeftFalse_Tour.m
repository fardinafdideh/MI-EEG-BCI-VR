trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[-1.6654 1.2 .844])%Station_front
setfield(object_nodes(3),'translation',[1.0562 1.2 .3176])%Station_Right
setfield(object_nodes(2),'translation',[-1.6654 1.2 2.7368])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.165*ones(1,3))%Right_Hand_Scale_Rot(.165-->.34)
setfield(object_nodes(7),'rotation',[0 1 0 -pi/180*163.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.12 2.0 4.4])%Right_Hand
setfield(object_nodes(9),'scale',.2*ones(1,3))%Left_Hand_Scale_Rot(.2-->.4)
setfield(object_nodes(9),'rotation',[0 1 0 -pi/180*37.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-.2 1.97 4.6704])%Left_Hand
setfield(object_nodes(11),'scale',.006*ones(1,3))%Tennis_Shoe_Right(.006-->.012)
setfield(object_nodes(11),'rotation',[.593 .669 .4481 pi/180*123.154])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[.49 2.03 5.3352])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.2;R_scl_min=.165;F_scl_min=.006;L_scl_max=.4;R_scl_max=.34;F_scl_max=.012;
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
        %% Navigation from BedroomLeftFalse to BedroomFront
        L=dist([Viewpoint.pos_BedroomFront',Viewpoint.pos_BedroomLeftFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomLeftFalse(1),Viewpoint.pos_BedroomFront(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomLeftFalse(2),Viewpoint.pos_BedroomFront(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomLeftFalse(3),Viewpoint.pos_BedroomFront(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomLeftFalse(1),Viewpoint.ori_BedroomFront(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomLeftFalse(2),Viewpoint.ori_BedroomFront(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomLeftFalse(3),Viewpoint.ori_BedroomFront(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomLeftFalse(4),Viewpoint.ori_BedroomFront(4),L);
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
        %% Navigation from BedroomLeftFalse to Bedroom
        L=dist([Viewpoint.pos_BedroomLeftFalse',Viewpoint.pos_Bedroom']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomLeftFalse(1),Viewpoint.pos_Bedroom(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomLeftFalse(2),Viewpoint.pos_Bedroom(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomLeftFalse(3),Viewpoint.pos_Bedroom(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomLeftFalse(1),Viewpoint.ori_Bedroom(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomLeftFalse(2),Viewpoint.ori_Bedroom(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomLeftFalse(3),Viewpoint.ori_Bedroom(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomLeftFalse(4),Viewpoint.ori_Bedroom(4),L);
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
        %% Navigation from BedroomLeftFalse to BedroomRight
        L=dist([Viewpoint.pos_BedroomRight',Viewpoint.pos_BedroomLeftFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomLeftFalse(1),Viewpoint.pos_BedroomRight(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomLeftFalse(2),Viewpoint.pos_BedroomRight(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomLeftFalse(3),Viewpoint.pos_BedroomRight(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomLeftFalse(1),Viewpoint.ori_BedroomRight(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomLeftFalse(2),Viewpoint.ori_BedroomRight(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomLeftFalse(3),Viewpoint.ori_BedroomRight(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomLeftFalse(4),Viewpoint.ori_BedroomRight(4),L);
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
