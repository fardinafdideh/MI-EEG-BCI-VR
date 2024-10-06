trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(7),'scale',.105*ones(1,3))%Right_Hand_Scale_Rot(.105-->.21)
setfield(object_nodes(7),'rotation',[-.0224 -.994 -.0273 -pi/180*180])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.63 1.91 1.226])%Right_Hand
setfield(object_nodes(9),'scale',.275*ones(1,3))%Left_Hand_Scale_Rot(.275-->.55)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*55.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.9 2.15 1.0736])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.275;R_scl_min=.105;L_scl_max=.55;R_scl_max=.21;
L_scl=L_scl_min;R_scl=R_scl_min;%max and min of scales
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
    elseif L_scl>=L_scl_max && R_scl<R_scl_max%moving to left
        delete(trialPath);% end of feature extraction and classification
        pause(1)
        % setting stations to default color and position
setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
        %% Navigation from BedBathDoor to BedBathDoorFalse
L=dist([Viewpoint.pos_BedBathDoor',Viewpoint.pos_BedBathDoorFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_BedBathDoor(1),Viewpoint.pos_BedBathDoorFalse(1),L);
y_pos=linspace(Viewpoint.pos_BedBathDoor(2),Viewpoint.pos_BedBathDoorFalse(2),L);
z_pos=linspace(Viewpoint.pos_BedBathDoor(3),Viewpoint.pos_BedBathDoorFalse(3),L);
x_ori=linspace(Viewpoint.ori_BedBathDoor(1),Viewpoint.ori_BedBathDoorFalse(1),L);
y_ori=linspace(-Viewpoint.ori_BedBathDoor(2),Viewpoint.ori_BedBathDoorFalse(2),L);
z_ori=linspace(Viewpoint.ori_BedBathDoor(3),Viewpoint.ori_BedBathDoorFalse(3),L);
rot_ori=linspace(-Viewpoint.ori_BedBathDoor(4),Viewpoint.ori_BedBathDoorFalse(4),L);
for i=1:floor(L)
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    elseif R_scl>=R_scl_max && L_scl<L_scl_max%moving to right
        delete(trialPath);% end of feature extraction and classification
        pause(1)
        % setting stations to default color and position
        setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
        setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
        %% Navigation from BedBathDoor to BedBathDoorTrue
    setfield(object_nodes(27),'position',[Viewpoint.pos_BedBathDoorTrue(1) Viewpoint.pos_BedBathDoorTrue(2) Viewpoint.pos_BedBathDoorTrue(3)]);
    setfield(object_nodes(27),'orientation',[Viewpoint.ori_BedBathDoorTrue(1) Viewpoint.ori_BedBathDoorTrue(2) Viewpoint.ori_BedBathDoorTrue(3) Viewpoint.ori_BedBathDoorTrue(4)]);
    vrdrawnow
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    end
end
delete(classPath)
