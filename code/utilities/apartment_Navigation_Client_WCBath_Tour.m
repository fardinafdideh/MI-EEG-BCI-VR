trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(7),'scale',.095*ones(1,3))%Right_Hand_Scale_Rot(.095-->.195)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*163.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.22 2.12 -1.9548])%Right_Hand
setfield(object_nodes(9),'scale',.06*ones(1,3))%Left_Hand_Scale_Rot(.06-->.12)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*82.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.2604 1.93 -1.06])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.06;R_scl_min=.095;L_scl_max=.12;R_scl_max=.195;
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
        setfield(object_nodes(24),'on',0)%Spot_Light_Kitchen
        %% Navigation from WCBath to WCBathFalse
L=dist([Viewpoint.pos_WCBathDoor',Viewpoint.pos_WCBath']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_WCBathDoor(1),Viewpoint.pos_WCBath(1),L);
y_pos=linspace(Viewpoint.pos_WCBathDoor(2),Viewpoint.pos_WCBath(2),L);
z_pos=linspace(Viewpoint.pos_WCBathDoor(3),Viewpoint.pos_WCBath(3),L);
x_ori=linspace(Viewpoint.ori_WCBathDoor(1),Viewpoint.ori_WCBath(1),L);
y_ori=linspace(Viewpoint.ori_WCBathDoor(2),Viewpoint.ori_WCBath(2),L);
z_ori=linspace(Viewpoint.ori_WCBathDoor(3),Viewpoint.ori_WCBath(3),L);
rot_ori=linspace(Viewpoint.ori_WCBathDoor(4),Viewpoint.ori_WCBath(4),L);
for i=floor(L):-1:1
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L=100;
x_pos=linspace(1.4,.904,L);
y_pos=linspace(2,2,L);
z_pos=linspace(-1,-.512,L);
x_ori=linspace(0,0,L);
y_ori=linspace(1,1,L);
z_ori=linspace(0,0,L);
rot_ori=linspace(pi/180*90,pi/180*180,L);
for i=L:-1:1
    setfield(object_nodes(56),'translation',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(56),'rotation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(13),'on',0)%Spot_Light_toilet    
setfield(object_nodes(25),'on',1)%Spot_Light_diningtable
L=dist([Viewpoint.pos_WCBathDoor',Viewpoint.pos_WCBathFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_WCBathFalse(1),Viewpoint.pos_WCBathDoor(1),L);
y_pos=linspace(Viewpoint.pos_WCBathFalse(2),Viewpoint.pos_WCBathDoor(2),L);
z_pos=linspace(Viewpoint.pos_WCBathFalse(3),Viewpoint.pos_WCBathDoor(3),L);
x_ori=linspace(Viewpoint.ori_WCBathFalse(1),Viewpoint.ori_WCBathDoor(1),L);
y_ori=linspace(-Viewpoint.ori_WCBathFalse(2),Viewpoint.ori_WCBathDoor(2),L);
z_ori=linspace(Viewpoint.ori_WCBathFalse(3),Viewpoint.ori_WCBathDoor(3),L);
rot_ori=linspace(-Viewpoint.ori_WCBathFalse(4)+6.283,Viewpoint.ori_WCBathDoor(4),L);
for i=floor(L):-1:1
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
        %% Navigation from WCBath to WCBathTrue
    setfield(object_nodes(27),'position',[Viewpoint.pos_WCBathTrue(1) Viewpoint.pos_WCBathTrue(2) Viewpoint.pos_WCBathTrue(3)]);
    setfield(object_nodes(27),'orientation',[Viewpoint.ori_WCBathTrue(1) Viewpoint.ori_WCBathTrue(2) Viewpoint.ori_WCBathTrue(3) Viewpoint.ori_WCBathTrue(4)]);
    vrdrawnow
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    end
end
delete(classPath)

