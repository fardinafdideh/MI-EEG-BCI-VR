trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(7),'scale',.35*ones(1,3))%Right_Hand_Scale_Rot(.35-->.7)
setfield(object_nodes(7),'rotation',[-.018 -.9929 .1177 pi/180*12.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.4 2.7 1.8])%Right_Hand
setfield(object_nodes(9),'scale',.2*ones(1,3))%Left_Hand_Scale_Rot(.2-->.4)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*111.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[5.25 2.32 .1])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.2;R_scl_min=.35;L_scl_max=.4;R_scl_max=.7;
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
        setfield(object_nodes(25),'on',1)%Spot_Light_diningtable        
        %% Navigation from Kitchen to KitchenFalse
L=dist([Viewpoint.pos_Kitchen',Viewpoint.pos_KitchenFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_Kitchen(1),Viewpoint.pos_KitchenFalse(1),L);
y_pos=linspace(Viewpoint.pos_Kitchen(2),Viewpoint.pos_KitchenFalse(2),L);
z_pos=linspace(Viewpoint.pos_Kitchen(3),Viewpoint.pos_KitchenFalse(3),L);
x_ori=linspace(Viewpoint.ori_Kitchen(1),Viewpoint.ori_KitchenFalse(1),L);
y_ori=linspace(Viewpoint.ori_Kitchen(2),Viewpoint.ori_KitchenFalse(2),L);
z_ori=linspace(Viewpoint.ori_Kitchen(3),Viewpoint.ori_KitchenFalse(3),L);
rot_ori=linspace(Viewpoint.ori_Kitchen(4),Viewpoint.ori_KitchenFalse(4),L);
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
        %% Navigation from Kitchen to KitchenTrue
    setfield(object_nodes(27),'position',[Viewpoint.pos_KitchenTrue(1) Viewpoint.pos_KitchenTrue(2) Viewpoint.pos_KitchenTrue(3)]);
    setfield(object_nodes(27),'orientation',[Viewpoint.ori_KitchenTrue(1) Viewpoint.ori_KitchenTrue(2) Viewpoint.ori_KitchenTrue(3) Viewpoint.ori_KitchenTrue(4)]);
    vrdrawnow
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        break
    end
end
delete(classPath)
