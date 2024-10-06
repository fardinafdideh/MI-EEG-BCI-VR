trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(1),'translation',[.6296 1.2 5.02])%Station_front
setfield(object_nodes(3),'translation',[-.9704 1.2 3.72])%Station_Right
setfield(object_nodes(2),'translation',[.6296 1.2 .6])%Station_Left
vrdrawnow;
setfield(object_nodes(7),'scale',.202*ones(1,3))%Right_Hand_Scale_Rot(.202-->.41)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*25.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.4 2.35 .7424])%Right_Hand
setfield(object_nodes(9),'scale',.18*ones(1,3))%Left_Hand_Scale_Rot(.18-->.36)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*99])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-1.208 2.2 -.28])%Left_Hand
setfield(object_nodes(11),'scale',.0055*ones(1,3))%Tennis_Shoe_Right(.0055-->.011)
setfield(object_nodes(11),'rotation',[-.3441 -.2373 .9085 pi/180*103.5739])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-2.6078 2.34 -.12])%Tennis_Shoe_Right
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.18;R_scl_min=.202;F_scl_min=.0055;L_scl_max=.36;R_scl_max=.41;F_scl_max=.011;
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
        %% Navigation from BedroomRightFalse to Bedroom
        L=dist([Viewpoint.pos_BedroomRightFalse',Viewpoint.pos_Bedroom']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomRightFalse(1),Viewpoint.pos_Bedroom(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomRightFalse(2),Viewpoint.pos_Bedroom(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomRightFalse(3),Viewpoint.pos_Bedroom(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomRightFalse(1),Viewpoint.ori_Bedroom(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomRightFalse(2),Viewpoint.ori_Bedroom(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomRightFalse(3),Viewpoint.ori_Bedroom(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomRightFalse(4),Viewpoint.ori_Bedroom(4),L);
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
        %% Navigation from BedroomRightFalse to BedroomFront
        L=dist([Viewpoint.pos_BedroomFront',Viewpoint.pos_BedroomRightFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomRightFalse(1),Viewpoint.pos_BedroomFront(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomRightFalse(2),Viewpoint.pos_BedroomFront(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomRightFalse(3),Viewpoint.pos_BedroomFront(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomRightFalse(1),Viewpoint.ori_BedroomFront(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomRightFalse(2),Viewpoint.ori_BedroomFront(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomRightFalse(3),Viewpoint.ori_BedroomFront(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomRightFalse(4),Viewpoint.ori_BedroomFront(4),L);
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
        %% Navigation from BedroomRightFalse to BedroomLeft
        L=dist([Viewpoint.pos_BedroomLeft',Viewpoint.pos_BedroomRightFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomRightFalse(1),Viewpoint.pos_BedroomLeft(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomRightFalse(2),Viewpoint.pos_BedroomLeft(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomRightFalse(3),Viewpoint.pos_BedroomLeft(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomRightFalse(1),Viewpoint.ori_BedroomLeft(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomRightFalse(2),Viewpoint.ori_BedroomLeft(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomRightFalse(3),Viewpoint.ori_BedroomLeft(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomRightFalse(4),Viewpoint.ori_BedroomLeft(4),L);
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
