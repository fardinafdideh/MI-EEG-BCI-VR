trialClassPath;

save(trialPath,'i');% start of feature extraction and classification
setfield(object_nodes(7),'scale',.29*ones(1,3))%Right_Hand_Scale_Rot(.29-->.59)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*34.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.25 2.1416 4.4584])%Right_Hand
setfield(object_nodes(9),'scale',.068*ones(1,3))%Left_Hand_Scale_Rot(.068-->.137)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*156.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-.37 1.62 3.4912])%Left_Hand
vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
k=1;L_scl_min=.068;R_scl_min=.29;L_scl_max=.137;R_scl_max=.59;
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
        %% Navigation from BedroomFront to BedroomFrontFalse
        L=dist([Viewpoint.pos_BedroomFront',Viewpoint.pos_BedroomFrontFalse']);
        L=L(1,2)/.034;
        x_pos=linspace(Viewpoint.pos_BedroomFront(1),Viewpoint.pos_BedroomFrontFalse(1),L);
        y_pos=linspace(Viewpoint.pos_BedroomFront(2),Viewpoint.pos_BedroomFrontFalse(2),L);
        z_pos=linspace(Viewpoint.pos_BedroomFront(3),Viewpoint.pos_BedroomFrontFalse(3),L);
        x_ori=linspace(Viewpoint.ori_BedroomFront(1),Viewpoint.ori_BedroomFrontFalse(1),L);
        y_ori=linspace(Viewpoint.ori_BedroomFront(2),Viewpoint.ori_BedroomFrontFalse(2),L);
        z_ori=linspace(Viewpoint.ori_BedroomFront(3),Viewpoint.ori_BedroomFrontFalse(3),L);
        rot_ori=linspace(Viewpoint.ori_BedroomFront(4),Viewpoint.ori_BedroomFrontFalse(4),L);
        for i=1:L
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
        % Stop Navigation
        Navigation=0;                
        break
    end
end
delete(classPath)
