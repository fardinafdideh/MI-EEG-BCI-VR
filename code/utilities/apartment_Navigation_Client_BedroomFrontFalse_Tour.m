trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[.6296 1.2 .6])%Station_front
setfield(object_nodes(3),'translation',[1.0616 1.2 4.084])%Station_Right
setfield(object_nodes(2),'translation',[-1.4224 1.2 .8])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.36*ones(1,3))%Right_Hand_Scale_Rot(.36-->.75)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*129.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[.75 2.4 4.4584])%Right_Hand
setfield(object_nodes(9),'scale',.065*ones(1,3))%Left_Hand_Scale_Rot(.065-->.13)
setfield(object_nodes(9),'rotation',[0 1 0 -pi/180*15])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-1.25 1.78 5.8672])%Left_Hand
setfield(object_nodes(11),'scale',.0065*ones(1,3))%Tennis_Shoe_Right(.0065-->.0135)
setfield(object_nodes(11),'rotation',[.5276 .6216 .5798 pi/180*113])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-1.3118 2.1 5.8353])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.065;R_scl_min=.36;F_scl_min=.0065;L_scl_max=.13;R_scl_max=.75;F_scl_max=.0135;
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
        %% Navigation from BedroomFrontFalse to BedroomRight
        L=dist([Viewpoint.pos_BedroomRight',Viewpoint.pos_BedroomFrontFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomFrontFalse(1),Viewpoint.pos_BedroomRight(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomFrontFalse(2),Viewpoint.pos_BedroomRight(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomFrontFalse(3),Viewpoint.pos_BedroomRight(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomFrontFalse(1),Viewpoint.ori_BedroomRight(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomFrontFalse(2),Viewpoint.ori_BedroomRight(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomFrontFalse(3),Viewpoint.ori_BedroomRight(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomFrontFalse(4)-6.283,Viewpoint.ori_BedroomRight(4),L);
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
        %% Navigation from BedroomFrontFalse to BedroomLeft
        L=dist([Viewpoint.pos_BedroomLeft',Viewpoint.pos_BedroomFrontFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomFrontFalse(1),Viewpoint.pos_BedroomLeft(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomFrontFalse(2),Viewpoint.pos_BedroomLeft(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomFrontFalse(3),Viewpoint.pos_BedroomLeft(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomFrontFalse(1),Viewpoint.ori_BedroomLeft(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomFrontFalse(2),Viewpoint.ori_BedroomLeft(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomFrontFalse(3),Viewpoint.ori_BedroomLeft(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomFrontFalse(4),Viewpoint.ori_BedroomLeft(4),L);
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
        %% Navigation from BedroomFrontFalse to Bedroom
        L=dist([Viewpoint.pos_BedroomFrontFalse',Viewpoint.pos_Bedroom']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomFrontFalse(1),Viewpoint.pos_Bedroom(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomFrontFalse(2),Viewpoint.pos_Bedroom(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomFrontFalse(3),Viewpoint.pos_Bedroom(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomFrontFalse(1),Viewpoint.ori_Bedroom(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomFrontFalse(2),Viewpoint.ori_Bedroom(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomFrontFalse(3),Viewpoint.ori_Bedroom(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomFrontFalse(4),Viewpoint.ori_Bedroom(4),L);
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
