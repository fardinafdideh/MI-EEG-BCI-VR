trialClassPath;

        save(trialPath,'i');% start of feature extraction and classification
        setfield(object_nodes(1),'translation',[-2.2704 1.2 -2.9952])%Station_front
        setfield(object_nodes(3),'translation',[-1.32 1.2 -4.8268])%Station_Right
        setfield(object_nodes(2),'translation',[-2.2704 1.2 -1.7792])%Station_Left
        vrdrawnow;
        setfield(object_nodes(7),'scale',.095*ones(1,3))%Right_Hand_Scale_Rot(.095-->.195)
        setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*163.8])%Right_Hand_Scale_Rot
        setfield(object_nodes(8),'translation',[1.22 2.12 -1.9548])%Right_Hand
        setfield(object_nodes(9),'scale',.06*ones(1,3))%Left_Hand_Scale_Rot(.06-->.12)
        setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*82.8])%Left_Hand_Scale_Rot
        setfield(object_nodes(10),'translation',[1.2604 1.93 -1.06])%Left_Hand
        setfield(object_nodes(11),'scale',.01*ones(1,3))%Tennis_Shoe_Right(.01-->.02)
        setfield(object_nodes(11),'rotation',[.6957 .6928 .1896 pi/180*158.0915])%Tennis_Shoe_Right
        setfield(object_nodes(11),'translation',[.7385 2.18 -1.5067])%Tennis_Shoe_Right
        vrdrawnow;set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
        k=1;L_scl_min=.06;R_scl_min=.095;F_scl_min=.01;L_scl_max=.12;R_scl_max=.195;F_scl_max=.02;
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
                %% Navigation from WCBath to WCBathLeft
                L=100;
                x_pos=linspace(Viewpoint.pos_WCBath(1),Viewpoint.pos_WCBathLeft(1),L);
                y_pos=linspace(Viewpoint.pos_WCBath(2),Viewpoint.pos_WCBathLeft(2),L);
                z_pos=linspace(Viewpoint.pos_WCBath(3),Viewpoint.pos_WCBathLeft(3),L);
                x_ori=linspace(Viewpoint.ori_WCBath(1),Viewpoint.ori_WCBathLeft(1),L);
                y_ori=linspace(Viewpoint.ori_WCBath(2),Viewpoint.ori_WCBathLeft(2),L);
                z_ori=linspace(Viewpoint.ori_WCBath(3),Viewpoint.ori_WCBathLeft(3),L);
                rot_ori=linspace(Viewpoint.ori_WCBath(4),Viewpoint.ori_WCBathLeft(4),L);
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
                %% Navigation from WCBath to WCBathRight
                L=100;
                x_pos=linspace(Viewpoint.pos_WCBathRight(1),Viewpoint.pos_WCBath(1),L);
                y_pos=linspace(Viewpoint.pos_WCBathRight(2),Viewpoint.pos_WCBath(2),L);
                z_pos=linspace(Viewpoint.pos_WCBathRight(3),Viewpoint.pos_WCBath(3),L);
                x_ori=linspace(Viewpoint.ori_WCBathRight(1),Viewpoint.ori_WCBath(1),L);
                y_ori=linspace(Viewpoint.ori_WCBathRight(2),Viewpoint.ori_WCBath(2),L);
                z_ori=linspace(Viewpoint.ori_WCBathRight(3),Viewpoint.ori_WCBath(3),L);
                rot_ori=linspace(Viewpoint.ori_WCBathRight(4),Viewpoint.ori_WCBath(4),L);
                for i=L:-1:1
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
                %% Navigation from WCBath to WCBathFront
                L=100;
                x_pos=linspace(Viewpoint.pos_WCBath(1),Viewpoint.pos_WCBathFront(1),L);
                y_pos=linspace(Viewpoint.pos_WCBath(2),Viewpoint.pos_WCBathFront(2),L);
                z_pos=linspace(Viewpoint.pos_WCBath(3),Viewpoint.pos_WCBathFront(3),L);
                x_ori=linspace(Viewpoint.ori_WCBath(1),Viewpoint.ori_WCBathFront(1),L);
                y_ori=linspace(Viewpoint.ori_WCBath(2),Viewpoint.ori_WCBathFront(2),L);
                z_ori=linspace(Viewpoint.ori_WCBath(3),Viewpoint.ori_WCBathFront(3),L);
                rot_ori=linspace(Viewpoint.ori_WCBath(4),Viewpoint.ori_WCBathFront(4),L);
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
