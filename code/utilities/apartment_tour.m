% clear;%Clear variables and functions from memory.(1569)
% vrclose;%Closes Virtual Reality figures.
% vrclear;%Purge closed virtual worlds from memory. 
%% VR Setup
myworld=vrworld(fullfile(pwd, 'utilities', 'VR_virtualHouseNavigation.wrl'));%Create a virtual world.
open(myworld)%Open files by extension.
vrfigure_object=vrfigure(myworld);%Create a new Virtual Reality figure. [get(vrfigure_object)]
reload(myworld);%Load the most recently used program file into the target.
set(vrfigure_object,'NavMode','walk');
pause(eps)
set(vrfigure_object,'NavPanel','none');
pause(eps)
set(vrfigure_object,'StatusBar','off');
pause(eps)
set(vrfigure_object,'ToolBar','off');
pause(eps)
set(vrfigure_object, 'Antialiasing', 'on');
pause(eps)
% set(vrfigure_object,'Fullscreen','off');
% pause(eps)
set(vrfigure_object,'Position',[0 79 696 696*768/1366]);%Set object properties.
pause(eps)
object_nodes=nodes(myworld,'-full');%List VRML nodes in a virtual world.
% Selecting necessary nodes
node1= vrnode(myworld,'Station_front');
node2= vrnode(myworld,'Station_Left');
node3= vrnode(myworld,'Station_right');
node4= vrnode(myworld,'Color_Station_Right');
node5= vrnode(myworld,'Color_Station_Left');
node6= vrnode(myworld,'Color_Station_Front');
node7= vrnode(myworld,'Right_Hand_Scale_Rot');
node8= vrnode(myworld,'Right_Hand');
node9= vrnode(myworld,'Left_Hand_Scale_Rot');
node10= vrnode(myworld,'Left_Hand');
node11= vrnode(myworld,'Tennis_Shoe_Right');
node12= vrnode(myworld,'Spot_Light_toilet');
node13= vrnode(myworld,'Spot_Light_toilet');
node14= vrnode(myworld,'Spot_Light_inputdoor');
node15= vrnode(myworld,'Spot_Light_Left3');
node16= vrnode(myworld,'Spot_Light_Left2');
node17= vrnode(myworld,'Spot_Light_Left1');
node18= vrnode(myworld,'Spot_Light_Right1');
node19= vrnode(myworld,'Spot_Light_Right2');
node20= vrnode(myworld,'Spot_Light_Salon_Light');
node21= vrnode(myworld,'Spot_Light_Right3');
node22= vrnode(myworld,'Spot_Light_Front');
node23= vrnode(myworld,'Spot_Light_bedroom');
node24= vrnode(myworld,'Spot_Light_kitchen');
node25= vrnode(myworld,'Spot_Light_diningtable');
node26= vrnode(myworld,'Spot_Light_salon');
node27=vrnode(myworld,'Subject_Viewpoint');
node28=vrnode(myworld,'Front_Top_Viewpoint');
node29=vrnode(myworld,'Kitchen_Viewpoint');
node30=vrnode(myworld,'Dining_Table_Viewpoint');
node31=vrnode(myworld,'Bed_Bath_Door_Viewpoint');
node32=vrnode(myworld,'Kitchen_Front_Viewpoint');
node33=vrnode(myworld,'Kitchen_Right_Viewpoint');
node34=vrnode(myworld,'Out_Right_Viewpoint');
node35=vrnode(myworld,'Out_Left_Viewpoint');
node36=vrnode(myworld,'Out_Front_Viewpoint');
node37=vrnode(myworld,'Input_Door_Viewpoint');
node38=vrnode(myworld,'Kitchen_Left_Viewpoint');
node39=vrnode(myworld,'Bedroom_Viewpoint');
node40=vrnode(myworld,'WC_Bath_Viewpoint');
node41=vrnode(myworld,'Bedroom_Right_Viewpoint');
node42=vrnode(myworld,'Bedroom_Front_Viewpoint');
node43=vrnode(myworld,'Bedroom_Left_Viewpoint');
node44=vrnode(myworld,'WC_Bathroom_Left_Viewpoint');
node45=vrnode(myworld,'WC_Bathroom_Front_Viewpoint');
node46=vrnode(myworld,'WC_Bathroom_Right_Viewpoint');
node47=vrnode(myworld,'Salon_Viewpoint');
node48=vrnode(myworld,'Salon_Left_Viewpoint');
node49=vrnode(myworld,'Salon_Front_Viewpoint');
node50=vrnode(myworld,'Salon_Right_Viewpoint');
node51=vrnode(myworld,'Input_Door2_Viewpoint');
node52=vrnode(myworld,'WC_Bath_Door_Viewpoint');
node53=vrnode(myworld,'Bedroom_Door_Viewpoint');
node54=vrnode(myworld,'Input_Door_rot');
node55=vrnode(myworld,'Bedroom_Door_rot');
node56=vrnode(myworld,'WC_Bath_Door_rot');
node57=vrnode(myworld,'Salon_Right_False_Viewpoint');
node58=vrnode(myworld,'Salon_Front_False_Viewpoint');
node59=vrnode(myworld,'Salon_Left_False_Viewpoint');
node60=vrnode(myworld,'WC_Bathroom_Right_False_Viewpoint');
node61=vrnode(myworld,'WC_Bathroom_Front_False_Viewpoint');
node62=vrnode(myworld,'WC_Bathroom_Left_False_Viewpoint');
node63=vrnode(myworld,'bedroom_Left_False_Viewpoint');
node64=vrnode(myworld,'Bedroom_Front_False_Viewpoint');
node65=vrnode(myworld,'Bedroom_Right_False_Viewpoint');
node66=vrnode(myworld,'Kitchen_Left_False_Viewpoint');
node67=vrnode(myworld,'Kitchen_Right_False_Viewpoint');
node68=vrnode(myworld,'Kitchen_Front_False_Viewpoint');
node69=vrnode(myworld,'Dining_Table_False_Viewpoint');
node70=vrnode(myworld,'Salon_False_Viewpoint');
node71=vrnode(myworld,'Salon_True_Viewpoint');
node72=vrnode(myworld,'WC_Bath_False_Viewpoint');
node73=vrnode(myworld,'WC_Bath_True_Viewpoint');
node74=vrnode(myworld,'Bedroom_False_Viewpoint');
node75=vrnode(myworld,'Bedroom_True_Viewpoint');
node76=vrnode(myworld,'Bed_Bath_Door_False_Viewpoint');
node77=vrnode(myworld,'Bed_Bath_Door_True_Viewpoint');
node78=vrnode(myworld,'Kitchen_False_Viewpoint');
node79=vrnode(myworld,'Kitchen_True_Viewpoint');
% node80=vrnode(myworld,'navigationMap');
object_nodes_necessary=node1;
clear node1
for i=2:79
    eval(['object_nodes_necessary=[object_nodes_necessary;node',num2str(i),'];'])
    eval(['clear node',num2str(i),''])
end
clear object_nodes
object_nodes=object_nodes_necessary;
clear object_nodes_necessary
% saving Viewpoints positions & orientations
    Viewpoint.pos_FrontTop= getfield(object_nodes(28),'position');
    Viewpoint.ori_FrontTop=getfield(object_nodes(28),'orientation');
    Viewpoint.pos_OutFront= getfield(object_nodes(36),'position');
    Viewpoint.ori_OutFront=getfield(object_nodes(36),'orientation');
    Viewpoint.pos_OutLeft= getfield(object_nodes(35),'position');
    Viewpoint.ori_OutLeft=getfield(object_nodes(35),'orientation');
    Viewpoint.pos_OutRight= getfield(object_nodes(34),'position');
    Viewpoint.ori_OutRight=getfield(object_nodes(34),'orientation');
    Viewpoint.pos_InputDoor= getfield(object_nodes(37),'position');
    Viewpoint.ori_InputDoor=getfield(object_nodes(37),'orientation');
    Viewpoint.pos_InputDoor2= getfield(object_nodes(51),'position');
    Viewpoint.ori_InputDoor2=getfield(object_nodes(51),'orientation');
    Viewpoint.pos_Kitchen= getfield(object_nodes(29),'position');
    Viewpoint.ori_Kitchen=getfield(object_nodes(29),'orientation');
    Viewpoint.pos_KitchenTrue= getfield(object_nodes(79),'position');
    Viewpoint.ori_KitchenTrue=getfield(object_nodes(79),'orientation');
    Viewpoint.pos_KitchenFalse= getfield(object_nodes(78),'position');
    Viewpoint.ori_KitchenFalse=getfield(object_nodes(78),'orientation');
    Viewpoint.pos_KitchenRight= getfield(object_nodes(33),'position');
    Viewpoint.ori_KitchenRight=getfield(object_nodes(33),'orientation');
    Viewpoint.pos_KitchenRightFalse= getfield(object_nodes(67),'position');
    Viewpoint.ori_KitchenRightFalse=getfield(object_nodes(67),'orientation');
    Viewpoint.pos_KitchenLeft= getfield(object_nodes(38),'position');
    Viewpoint.ori_KitchenLeft=getfield(object_nodes(38),'orientation');
    Viewpoint.pos_KitchenLeftFalse= getfield(object_nodes(66),'position');
    Viewpoint.ori_KitchenLeftFalse=getfield(object_nodes(66),'orientation');
    Viewpoint.pos_KitchenFront= getfield(object_nodes(32),'position');
    Viewpoint.ori_KitchenFront=getfield(object_nodes(32),'orientation');
    Viewpoint.pos_KitchenFrontFalse= getfield(object_nodes(68),'position');
    Viewpoint.ori_KitchenFrontFalse=getfield(object_nodes(68),'orientation');
    Viewpoint.pos_DiningTable= getfield(object_nodes(30),'position');
    Viewpoint.ori_DiningTable=getfield(object_nodes(30),'orientation');
    Viewpoint.pos_DiningTableFalse= getfield(object_nodes(69),'position');
    Viewpoint.ori_DiningTableFalse=getfield(object_nodes(69),'orientation');
    Viewpoint.pos_BedBathDoor= getfield(object_nodes(31),'position');
    Viewpoint.ori_BedBathDoor=getfield(object_nodes(31),'orientation');
    Viewpoint.pos_BedBathDoorTrue= getfield(object_nodes(77),'position');
    Viewpoint.ori_BedBathDoorTrue=getfield(object_nodes(77),'orientation');
    Viewpoint.pos_BedBathDoorFalse= getfield(object_nodes(76),'position');
    Viewpoint.ori_BedBathDoorFalse=getfield(object_nodes(76),'orientation');
    Viewpoint.pos_Bedroom= getfield(object_nodes(39),'position');
    Viewpoint.ori_Bedroom=getfield(object_nodes(39),'orientation');
    Viewpoint.pos_BedroomTrue= getfield(object_nodes(75),'position');
    Viewpoint.ori_BedroomTrue=getfield(object_nodes(75),'orientation');
    Viewpoint.pos_BedroomFalse= getfield(object_nodes(74),'position');
    Viewpoint.ori_BedroomFalse=getfield(object_nodes(74),'orientation');
    Viewpoint.pos_BedroomDoor= getfield(object_nodes(53),'position');
    Viewpoint.ori_BedroomDoor=getfield(object_nodes(53),'orientation');
    Viewpoint.pos_BedroomRight= getfield(object_nodes(41),'position');
    Viewpoint.ori_BedroomRight=getfield(object_nodes(41),'orientation');
    Viewpoint.pos_BedroomRightFalse= getfield(object_nodes(65),'position');
    Viewpoint.ori_BedroomRightFalse=getfield(object_nodes(65),'orientation');    
    Viewpoint.pos_BedroomLeft= getfield(object_nodes(43),'position');
    Viewpoint.ori_BedroomLeft=getfield(object_nodes(43),'orientation');
    Viewpoint.pos_BedroomLeftFalse= getfield(object_nodes(63),'position');
    Viewpoint.ori_BedroomLeftFalse=getfield(object_nodes(63),'orientation');
    Viewpoint.pos_BedroomFront= getfield(object_nodes(42),'position');
    Viewpoint.ori_BedroomFront=getfield(object_nodes(42),'orientation');
    Viewpoint.pos_BedroomFrontFalse= getfield(object_nodes(64),'position');
    Viewpoint.ori_BedroomFrontFalse=getfield(object_nodes(64),'orientation');
    Viewpoint.pos_WCBath= getfield(object_nodes(40),'position');
    Viewpoint.ori_WCBath=getfield(object_nodes(40),'orientation');
    Viewpoint.pos_WCBathTrue= getfield(object_nodes(73),'position');
    Viewpoint.ori_WCBathTrue=getfield(object_nodes(73),'orientation');
    Viewpoint.pos_WCBathFalse= getfield(object_nodes(72),'position');
    Viewpoint.ori_WCBathFalse=getfield(object_nodes(72),'orientation');
    Viewpoint.pos_WCBathDoor= getfield(object_nodes(52),'position');
    Viewpoint.ori_WCBathDoor=getfield(object_nodes(52),'orientation');    
    Viewpoint.pos_WCBathLeft= getfield(object_nodes(44),'position');
    Viewpoint.ori_WCBathLeft=getfield(object_nodes(44),'orientation');
    Viewpoint.pos_WCBathLeftFalse= getfield(object_nodes(62),'position');
    Viewpoint.ori_WCBathLeftFalse=getfield(object_nodes(62),'orientation');
    Viewpoint.pos_WCBathRight= getfield(object_nodes(46),'position');
    Viewpoint.ori_WCBathRight=getfield(object_nodes(46),'orientation');
    Viewpoint.pos_WCBathRightFalse= getfield(object_nodes(60),'position');
    Viewpoint.ori_WCBathRightFalse=getfield(object_nodes(60),'orientation');
    Viewpoint.pos_WCBathFront= getfield(object_nodes(45),'position');
    Viewpoint.ori_WCBathFront=getfield(object_nodes(45),'orientation');
    Viewpoint.pos_WCBathFrontFalse= getfield(object_nodes(61),'position');
    Viewpoint.ori_WCBathFrontFalse=getfield(object_nodes(61),'orientation');
    Viewpoint.pos_Salon= getfield(object_nodes(47),'position');
    Viewpoint.ori_Salon=getfield(object_nodes(47),'orientation');
    Viewpoint.pos_SalonTrue= getfield(object_nodes(71),'position');
    Viewpoint.ori_SalonTrue=getfield(object_nodes(71),'orientation');
    Viewpoint.pos_SalonFalse= getfield(object_nodes(70),'position');
    Viewpoint.ori_SalonFalse=getfield(object_nodes(70),'orientation');
    Viewpoint.pos_SalonRight= getfield(object_nodes(50),'position');
    Viewpoint.ori_SalonRight=getfield(object_nodes(50),'orientation');
    Viewpoint.pos_SalonRightFalse= getfield(object_nodes(57),'position');
    Viewpoint.ori_SalonRightFalse=getfield(object_nodes(57),'orientation');
    Viewpoint.pos_SalonLeft= getfield(object_nodes(48),'position');
    Viewpoint.ori_SalonLeft=getfield(object_nodes(48),'orientation');
    Viewpoint.pos_SalonLeftFalse= getfield(object_nodes(59),'position');
    Viewpoint.ori_SalonLeftFalse=getfield(object_nodes(59),'orientation');
    Viewpoint.pos_SalonFront= getfield(object_nodes(49),'position');
    Viewpoint.ori_SalonFront=getfield(object_nodes(49),'orientation');
    Viewpoint.pos_SalonFrontFalse= getfield(object_nodes(58),'position');
    Viewpoint.ori_SalonFrontFalse=getfield(object_nodes(58),'orientation');
    
 %%   Apartment tour
reload(myworld);%Load the most recently used program file into the target.
set(vrfigure_object,'Headlight','off');pause(eps)
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');pause(1)

%% Navigation from FrontTop to OutFront(test)
    L=100;
    x_pos=linspace(Viewpoint.pos_FrontTop(1),Viewpoint.pos_OutFront(1),L);
    y_pos=linspace(Viewpoint.pos_FrontTop(2),Viewpoint.pos_OutFront(2),L);
    z_pos=linspace(Viewpoint.pos_FrontTop(3),Viewpoint.pos_OutFront(3),L);
    x_ori=linspace(Viewpoint.ori_FrontTop(1),Viewpoint.ori_OutFront(1),L);
    y_ori=linspace(-Viewpoint.ori_FrontTop(2),Viewpoint.ori_OutFront(2),L);
    z_ori=linspace(Viewpoint.ori_FrontTop(3),Viewpoint.ori_OutFront(3),L);
    rot_ori=linspace(-Viewpoint.ori_FrontTop(4),Viewpoint.ori_OutFront(4),L);
    viewMapDist = 5;
    for i=1:L
        setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
        setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
        vrdrawnow
    end
    set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
%% Navigation from FrontTop to OutFront 
% set(vrfigure_object,'Fullscreen','off');
pause(5)
    L=dist([Viewpoint.pos_FrontTop',Viewpoint.pos_OutFront']);
    L=L(1,2)/.034;
    x_pos=linspace(Viewpoint.pos_FrontTop(1),Viewpoint.pos_OutFront(1),L);
    y_pos=linspace(Viewpoint.pos_FrontTop(2),Viewpoint.pos_OutFront(2),L);
    z_pos=linspace(Viewpoint.pos_FrontTop(3),Viewpoint.pos_OutFront(3),L);
    x_ori=linspace(Viewpoint.ori_FrontTop(1),Viewpoint.ori_OutFront(1),L);
    y_ori=linspace(Viewpoint.ori_FrontTop(2),-Viewpoint.ori_OutFront(2),L);
    z_ori=linspace(Viewpoint.ori_FrontTop(3),Viewpoint.ori_OutFront(3),L);
    rot_ori=linspace(Viewpoint.ori_FrontTop(4),-Viewpoint.ori_OutFront(4),L);
    for i=1:L
        setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
        setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);        
        vrdrawnow
    end
    set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
    setfield(object_nodes(1),'translation',[2.35 1.2 6])%Station_front
    setfield(object_nodes(2),'translation',[0 1.2 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 1.2 10])%Station_right
    vrdrawnow;pause(1)
    setfield(object_nodes(7),'scale',.72*ones(1,3))%Right_Hand_Scale_Rot(.72-->1.5)
    setfield(object_nodes(7),'rotation',[.018 1 -.1177 -pi/180*160])%Right_Hand_Scale_Rot
    setfield(object_nodes(9),'scale',.77*ones(1,3))%Left_Hand_Scale_Rot(.77-->1.6)
    setfield(object_nodes(9),'rotation',[0 1 0 -pi/180*25.2])%Left_Hand_Scale_Rot
    setfield(object_nodes(11),'scale',.03*ones(1,3))%Tennis_Shoe_Right(.03-->.05)
    setfield(object_nodes(11),'rotation',[.5774 .5774 .5774 pi/180*119.9997])%Tennis_Shoe_Right
    setfield(object_nodes(8),'translation',[5.72 3.35 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 3.3 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 1.9 13])%Tennis_Shoe_Right
    vrdrawnow;pause(3)
    for i=.77:(1.6-.77)/15:1.6%Left Hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%Left_Hand_Scale_Rot(.77-->1.6)
    end
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
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from OutFront to OutLeft
    L=dist([Viewpoint.pos_OutFront',Viewpoint.pos_OutLeft']);
    L=L(1,2)/.034;
    x_pos=linspace(Viewpoint.pos_OutFront(1),Viewpoint.pos_OutLeft(1),L);
    y_pos=linspace(Viewpoint.pos_OutFront(2),Viewpoint.pos_OutLeft(2),L);
    z_pos=linspace(Viewpoint.pos_OutFront(3),Viewpoint.pos_OutLeft(3),L);
    x_ori=linspace(Viewpoint.ori_OutFront(1),Viewpoint.ori_OutLeft(1),L);
    y_ori=linspace(Viewpoint.ori_OutFront(2),-Viewpoint.ori_OutLeft(2),L);
    z_ori=linspace(Viewpoint.ori_OutFront(3),Viewpoint.ori_OutLeft(3),L);
    rot_ori=linspace(Viewpoint.ori_OutFront(4),-Viewpoint.ori_OutLeft(4),L);
    for i=1:L
        setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
        setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
        vrdrawnow
    end
    set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
    setfield(object_nodes(1),'translation',[5 1.2 10])%Station_front
    setfield(object_nodes(2),'translation',[2.4 1.2 6.3])%Station_Left
    setfield(object_nodes(3),'translation',[2.35 1.2 10.8])%Station_right
    vrdrawnow;pause(1)
    setfield(object_nodes(7),'scale',.81*ones(1,3))%Right_Hand_Scale_Rot(.81-->1.5)
    setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*70.2])%Right_Hand_Scale_Rot
    setfield(object_nodes(9),'scale',.37*ones(1,3))%Left_Hand_Scale_Rot(.37-->.74)
    setfield(object_nodes(9),'rotation',[0 1 0 pi/180*55.8])%Left_Hand_Scale_Rot
    setfield(object_nodes(11),'scale',.015*ones(1,3))%Tennis_Shoe_Right(.015-->.032)
    setfield(object_nodes(11),'rotation',[.1755 .18 1 pi/180*87.3868])%Tennis_Shoe_Right
    setfield(object_nodes(8),'translation',[3.5 3.3 11.3])%Right_Hand
    setfield(object_nodes(10),'translation',[.6 2.55 7.5])%Left_Hand
    setfield(object_nodes(11),'translation',[-0.5 2.1 9.4])%Tennis_Shoe_Right
    vrdrawnow;pause(3)
    for i=.015:(.032-.015)/15:.032%Foot enlarging
        setfield(object_nodes(11),'scale',i*ones(1,3));pause(eps)%Left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(6),'diffuseColor',[0.01 .8 .09]);pause(eps)%Color_Station_Left
    setfield(object_nodes(6),'emissiveColor',[0 .3 0]);pause(eps)%Color_Station_Left
    pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from OutLeft to OutRight
    L=dist([Viewpoint.pos_OutLeft',Viewpoint.pos_OutRight']);
    L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_OutLeft(1),Viewpoint.pos_OutRight(1),L);
y_pos=linspace(Viewpoint.pos_OutLeft(2),Viewpoint.pos_OutRight(2),L);
z_pos=linspace(Viewpoint.pos_OutLeft(3),Viewpoint.pos_OutRight(3),L);
x_ori=linspace(Viewpoint.ori_OutLeft(1),Viewpoint.ori_OutRight(1),L);
y_ori=linspace(Viewpoint.ori_OutLeft(2),Viewpoint.ori_OutRight(2),L);
z_ori=linspace(Viewpoint.ori_OutLeft(3),Viewpoint.ori_OutRight(3),L);
rot_ori=linspace(Viewpoint.ori_OutLeft(4),Viewpoint.ori_OutRight(4)-6.283,L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
    setfield(object_nodes(1),'translation',[0 1.2 9])%Station_front
    setfield(object_nodes(2),'translation',[2.35 1.2 10.8])%Station_Left
    setfield(object_nodes(3),'translation',[2.4 1.2 6.3])%Station_right
    vrdrawnow;pause(1)
    setfield(object_nodes(7),'scale',.47*ones(1,3))%Right_Hand_Scale_Rot(.47-->.95)
    setfield(object_nodes(7),'rotation',[.018 .9929 -.1177 pi/180*126])%Right_Hand_Scale_Rot
    setfield(object_nodes(8),'translation',[4.1 2.65 6.6])%Right_Hand
    setfield(object_nodes(9),'scale',.25*ones(1,3))%Left_Hand_Scale_Rot(.25-->.47)
    setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*95.4])%Left_Hand_Scale_Rot
    setfield(object_nodes(10),'translation',[4.9 2.07 10.3])%Left_Hand
    setfield(object_nodes(11),'scale',.009*ones(1,3))%Tennis_Shoe_Right(.015-->.0165)
    setfield(object_nodes(11),'rotation',[.7064 .7064 .0433 pi/180*174.8076])%Tennis_Shoe_Right
    setfield(object_nodes(11),'translation',[5.7 2 9.55])%Tennis_Shoe_Right
    vrdrawnow;pause(3)
    for i=.47:(.95-.47)/15:.95%Right hand enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%right_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(4),'diffuseColor',[.8 .8 .01]);pause(eps)%Color_Station_Left
    setfield(object_nodes(4),'emissiveColor',[.3 .3 0]);pause(eps)%Color_Station_Left
    pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from OutRight to Input_Door
L=dist([Viewpoint.pos_OutRight',Viewpoint.pos_InputDoor2']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_OutRight(1),Viewpoint.pos_InputDoor2(1),L);
y_pos=linspace(Viewpoint.pos_OutRight(2),Viewpoint.pos_InputDoor2(2),L);
z_pos=linspace(Viewpoint.pos_OutRight(3),Viewpoint.pos_InputDoor2(3),L);
x_ori=linspace(Viewpoint.ori_OutRight(1),Viewpoint.ori_InputDoor2(1),L);
y_ori=linspace(Viewpoint.ori_OutRight(2),Viewpoint.ori_InputDoor2(2),L);
z_ori=linspace(Viewpoint.ori_OutRight(3),Viewpoint.ori_InputDoor2(3),L);
rot_ori=linspace(Viewpoint.ori_OutRight(4)-6.283,Viewpoint.ori_InputDoor2(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
%open the door
L=100;
x_pos=linspace(5500,4785,L);
y_pos=linspace(1250,1250,L);
z_pos=linspace(-1500,-2287.8647,L);
x_ori=linspace(0,0,L);
y_ori=linspace(1,1,L);
z_ori=linspace(0,0,L);
rot_ori=linspace(0,pi/180*80,L);
for i=1:L
    setfield(object_nodes(54),'translation',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(54),'rotation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L=dist([Viewpoint.pos_InputDoor',Viewpoint.pos_InputDoor2']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_InputDoor2(1),Viewpoint.pos_InputDoor(1),L);
y_pos=linspace(Viewpoint.pos_InputDoor2(2),Viewpoint.pos_InputDoor(2),L);
z_pos=linspace(Viewpoint.pos_InputDoor2(3),Viewpoint.pos_InputDoor(3),L);
x_ori=linspace(Viewpoint.ori_InputDoor2(1),Viewpoint.ori_InputDoor(1),L);
y_ori=linspace(Viewpoint.ori_InputDoor2(2),Viewpoint.ori_InputDoor(2),L);
z_ori=linspace(Viewpoint.ori_InputDoor2(3),Viewpoint.ori_InputDoor(3),L);
rot_ori=linspace(Viewpoint.ori_InputDoor2(4),Viewpoint.ori_InputDoor(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
    setfield(object_nodes(54),'translation',[5500 1250 -1500]);
    setfield(object_nodes(54),'rotation',[0 1 0 0]);
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(25),'on',1)%Spot_Light_diningtable
    setfield(object_nodes(1),'translation',[3.55 1.2 -1.2])%Station_front
    setfield(object_nodes(2),'translation',[1.75 1.2 -1.6])%Station_Left
    setfield(object_nodes(3),'translation',[4 1.2 1])%Station_right
    vrdrawnow;pause(1)
    setfield(object_nodes(7),'scale',.135*ones(1,3))%Right_Hand_Scale_Rot(.135-->.27)
    setfield(object_nodes(7),'rotation',[-.018 -.9929 .1177 pi/180*151.2])%Right_Hand_Scale_Rot
    setfield(object_nodes(8),'translation',[2.92 2.25 3.3])%Right_Hand
    setfield(object_nodes(9),'scale',.1*ones(1,3))%Left_Hand_Scale_Rot(.1-->.21)
    setfield(object_nodes(9),'rotation',[0 1 0 pi/180*1.8001])%Left_Hand_Scale_Rot
    setfield(object_nodes(10),'translation',[2.12 2.06 3.4])%Left_Hand
    setfield(object_nodes(11),'scale',.009*ones(1,3))%Tennis_Shoe_Right(.009-->.018)
    setfield(object_nodes(11),'rotation',[.7 .5774 .8 pi/180*120])%Tennis_Shoe_Right
    setfield(object_nodes(11),'translation',[2.25 2.25 3.5])%Tennis_Shoe_Right
    vrdrawnow;pause(3)
    for i=.135:(.27-.135)/15:.27%Right hand enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%right_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(4),'diffuseColor',[.8 .8 .01]);pause(eps)%Color_Station_Left
    setfield(object_nodes(4),'emissiveColor',[.3 .3 0]);pause(eps)%Color_Station_Left
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from Input_Door to Kitchen
setfield(object_nodes(25),'on',0)%Spot_Light_diningtable
setfield(object_nodes(24),'on',1)%Spot_Light_kitchen
L=dist([Viewpoint.pos_InputDoor',Viewpoint.pos_Kitchen']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_InputDoor(1),Viewpoint.pos_Kitchen(1),L);
y_pos=linspace(Viewpoint.pos_InputDoor(2),Viewpoint.pos_Kitchen(2),L);
z_pos=linspace(Viewpoint.pos_InputDoor(3),Viewpoint.pos_Kitchen(3),L);
x_ori=linspace(Viewpoint.ori_InputDoor(1),Viewpoint.ori_Kitchen(1),L);
y_ori=linspace(Viewpoint.ori_InputDoor(2),-Viewpoint.ori_Kitchen(2),L);
z_ori=linspace(Viewpoint.ori_InputDoor(3),Viewpoint.ori_Kitchen(3),L);
rot_ori=linspace(Viewpoint.ori_InputDoor(4),-Viewpoint.ori_Kitchen(4)+6.283,L);
for i=1:floor(L)
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(24),'on',1)%Spot_Light_kitchen
setfield(object_nodes(7),'scale',.35*ones(1,3))%Right_Hand_Scale_Rot(.35-->.7)
setfield(object_nodes(7),'rotation',[-.018 -.9929 .1177 pi/180*12.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.4 2.7 1.8])%Right_Hand
setfield(object_nodes(9),'scale',.2*ones(1,3))%Left_Hand_Scale_Rot(.2-->.4)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*111.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[5.25 2.32 .1])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.35:(.7-.35)/15:.7%right hand enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
pause(1)
setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(27),'position',[Viewpoint.pos_KitchenTrue(1) Viewpoint.pos_KitchenTrue(2) Viewpoint.pos_KitchenTrue(3)]);
    setfield(object_nodes(27),'orientation',[Viewpoint.ori_KitchenTrue(1) Viewpoint.ori_KitchenTrue(2) Viewpoint.ori_KitchenTrue(3) Viewpoint.ori_KitchenTrue(4)]);
    vrdrawnow
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[5.75 1.2 4.4])%Station_front
setfield(object_nodes(2),'translation',[6.5 1.2 2.5])%Station_Left
setfield(object_nodes(3),'translation',[4.4 1.2 3.8])%Station_right
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.35*ones(1,3))%Right_Hand_Scale_Rot(.35-->.7)
setfield(object_nodes(7),'rotation',[-.018 -.9929 .1177 pi/180*12.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.4 2.7 1.8])%Right_Hand
setfield(object_nodes(9),'scale',.2*ones(1,3))%Left_Hand_Scale_Rot(.2-->.4)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*111.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[5.25 2.32 .1])%Left_Hand
setfield(object_nodes(11),'scale',.045*ones(1,3))%Tennis_Shoe_Right(.045-->.09)
setfield(object_nodes(11),'rotation',[-.5 -.5 1 pi/180*96.7152])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[5.2 1.6 2.5])%Tennis_Shoe_Right
vrdrawnow;pause(3)
    for i=.2:(.4-.2)/15:.4%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%right_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_Left
    setfield(object_nodes(5),'emissiveColor',[0 0 .3]);pause(eps)%Color_Station_Left
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right

%% Navigation from Kitchen to Kitchen_Left
L=dist([Viewpoint.pos_Kitchen',Viewpoint.pos_KitchenLeft']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_Kitchen(1),Viewpoint.pos_KitchenLeft(1),L);
y_pos=linspace(Viewpoint.pos_Kitchen(2),Viewpoint.pos_KitchenLeft(2),L);
z_pos=linspace(Viewpoint.pos_Kitchen(3),Viewpoint.pos_KitchenLeft(3),L);
x_ori=linspace(Viewpoint.ori_Kitchen(1),Viewpoint.ori_KitchenLeft(1),L);
y_ori=linspace(Viewpoint.ori_Kitchen(2),Viewpoint.ori_KitchenLeft(2),L);
z_ori=linspace(Viewpoint.ori_Kitchen(3),Viewpoint.ori_KitchenLeft(3),L);
rot_ori=linspace(Viewpoint.ori_Kitchen(4),Viewpoint.ori_KitchenLeft(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
setfield(object_nodes(7),'scale',.25*ones(1,3))%Right_Hand_Scale_Rot(.25-->.5)
setfield(object_nodes(7),'rotation',[-.0224 -.9997 0 pi/180*43.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[6.7707 2.2 2.8])%Right_Hand
setfield(object_nodes(9),'scale',.095*ones(1,3))%Left_Hand_Scale_Rot(.095-->.19)
setfield(object_nodes(9),'rotation',[.0361 .9993 0 pi/180*70])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[6.5 1.78 1.45])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.095:(.19-.095)/15:.19%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
pause(1)
setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_KitchenLeftFalse',Viewpoint.pos_KitchenLeft']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_KitchenLeftFalse(1),Viewpoint.pos_KitchenLeft(1),L);
y_pos=linspace(Viewpoint.pos_KitchenLeftFalse(2),Viewpoint.pos_KitchenLeft(2),L);
z_pos=linspace(Viewpoint.pos_KitchenLeftFalse(3),Viewpoint.pos_KitchenLeft(3),L);
x_ori=linspace(Viewpoint.ori_KitchenLeftFalse(1),Viewpoint.ori_KitchenLeft(1),L);
y_ori=linspace(Viewpoint.ori_KitchenLeftFalse(2),Viewpoint.ori_KitchenLeft(2),L);
z_ori=linspace(Viewpoint.ori_KitchenLeftFalse(3),Viewpoint.ori_KitchenLeft(3),L);
rot_ori=linspace(Viewpoint.ori_KitchenLeftFalse(4),Viewpoint.ori_KitchenLeft(4),L);
for i=floor(L):-1:1
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[4.6 1.2 4])%Station_front
setfield(object_nodes(2),'translation',[5.75 1.2 4.4])%Station_Left
setfield(object_nodes(3),'translation',[3.168 1.2 2])%Station_right
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.29*ones(1,3))%Right_Hand_Scale_Rot(.29-->.58)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*99])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[5.3 2.47 1.33])%Right_Hand
setfield(object_nodes(9),'scale',.165*ones(1,3))%Left_Hand_Scale_Rot(.165-->.33)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*160])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[7.04 2.15 2.95])%Left_Hand
setfield(object_nodes(11),'scale',.019*ones(1,3))%Tennis_Shoe_Right(.019-->.038)
setfield(object_nodes(11),'rotation',[.6957 .6962 -.177 -pi/180*160.2])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[6.01 2.05 2.5])%Tennis_Shoe_Right
vrdrawnow;pause(3)
    for i=.165:(.33-.165)/15:.33%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_Left
    setfield(object_nodes(5),'emissiveColor',[0 0 .3]);pause(eps)%Color_Station_Left
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from Kitchen_Left to Kitchen_Front
L=dist([Viewpoint.pos_KitchenLeftFalse',Viewpoint.pos_KitchenFront']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_KitchenLeftFalse(1),Viewpoint.pos_KitchenFront(1),L);
y_pos=linspace(Viewpoint.pos_KitchenLeftFalse(2),Viewpoint.pos_KitchenFront(2),L);
z_pos=linspace(Viewpoint.pos_KitchenLeftFalse(3),Viewpoint.pos_KitchenFront(3),L);
x_ori=linspace(Viewpoint.ori_KitchenLeftFalse(1),Viewpoint.ori_KitchenFront(1),L);
y_ori=linspace(Viewpoint.ori_KitchenLeftFalse(2),Viewpoint.ori_KitchenFront(2),L);
z_ori=linspace(Viewpoint.ori_KitchenLeftFalse(3),Viewpoint.ori_KitchenFront(3),L);
rot_ori=linspace(Viewpoint.ori_KitchenLeftFalse(4),Viewpoint.ori_KitchenFront(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(7),'scale',.335*ones(1,3))%Right_Hand_Scale_Rot(.335-->.65)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*36])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[4.5 2.15 4.5])%Right_Hand
setfield(object_nodes(9),'scale',.43*ones(1,3))%Left_Hand_Scale_Rot(.43-->.85)
setfield(object_nodes(9),'rotation',[-.036 -.9993 0 -pi/180*140])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[7.15 2.15 5.4])%Left_Hand
vrdrawnow;pause(3)
    for i=.43:(.85-.43)/15:.85%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
pause(1)
setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_KitchenFrontFalse',Viewpoint.pos_KitchenFront']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_KitchenFrontFalse(1),Viewpoint.pos_KitchenFront(1),L);
y_pos=linspace(Viewpoint.pos_KitchenFrontFalse(2),Viewpoint.pos_KitchenFront(2),L);
z_pos=linspace(Viewpoint.pos_KitchenFrontFalse(3),Viewpoint.pos_KitchenFront(3),L);
x_ori=linspace(Viewpoint.ori_KitchenFrontFalse(1),Viewpoint.ori_KitchenFront(1),L);
y_ori=linspace(Viewpoint.ori_KitchenFrontFalse(2),Viewpoint.ori_KitchenFront(2),L);
z_ori=linspace(Viewpoint.ori_KitchenFrontFalse(3),Viewpoint.ori_KitchenFront(3),L);
rot_ori=linspace(Viewpoint.ori_KitchenFrontFalse(4),Viewpoint.ori_KitchenFront(4),L);
for i=floor(L):-1:1
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[3.5076 1.1892 1.806])%Station_front
setfield(object_nodes(2),'translation',[4.1232 1.1892 3.48])%Station_Left
setfield(object_nodes(3),'translation',[6.5 1.2 2.5])%Station_right
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.13*ones(1,3))%Right_Hand_Scale_Rot(.13-->.27)
setfield(object_nodes(7),'rotation',[-.0224 -.9994 -.0273 pi/180*180])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[6.72 2.07 4.5])%Right_Hand
setfield(object_nodes(9),'scale',.45*ones(1,3))%Left_Hand_Scale_Rot(.45-->.9)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*54.1461])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[3.8 2.6 3.8])%Left_Hand
setfield(object_nodes(11),'scale',.014*ones(1,3))%Tennis_Shoe_Right(.019-->.028)
setfield(object_nodes(11),'rotation',[.7 .6449 .3923 pi/180*141.0476])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[6.05 2 4.5947])%Tennis_Shoe_Right
vrdrawnow;pause(3)
    for i=.45:(.9-.45)/15:.9%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_Left
    setfield(object_nodes(5),'emissiveColor',[0 0 .3]);pause(eps)%Color_Station_Left
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from Kitchen_Front to Kitchen_Right
L=dist([Viewpoint.pos_KitchenFrontFalse',Viewpoint.pos_KitchenRight']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_KitchenFrontFalse(1),Viewpoint.pos_KitchenRight(1),L);
y_pos=linspace(Viewpoint.pos_KitchenFrontFalse(2),Viewpoint.pos_KitchenRight(2),L);
z_pos=linspace(Viewpoint.pos_KitchenFrontFalse(3),Viewpoint.pos_KitchenRight(3),L);
x_ori=linspace(Viewpoint.ori_KitchenFrontFalse(1),Viewpoint.ori_KitchenRight(1),L);
y_ori=linspace(Viewpoint.ori_KitchenFrontFalse(2),Viewpoint.ori_KitchenRight(2),L);
z_ori=linspace(Viewpoint.ori_KitchenFrontFalse(3),Viewpoint.ori_KitchenRight(3),L);
rot_ori=linspace(Viewpoint.ori_KitchenFrontFalse(4),Viewpoint.ori_KitchenRight(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(7),'scale',.24*ones(1,3))%Right_Hand_Scale_Rot(.24-->.48)
setfield(object_nodes(7),'rotation',[-.0224 -.9997 0 -pi/180*126])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[4.4 2.06 3])%Right_Hand
setfield(object_nodes(9),'scale',.23*ones(1,3))%Left_Hand_Scale_Rot(.23-->.46)
setfield(object_nodes(9),'rotation',[-.0361 -.9993 0 pi/180*110])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.4 1.96 5.22])%Left_Hand
vrdrawnow;pause(3);
    for i=.23:(.46-.23)/15:.46%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_KitchenRightFalse',Viewpoint.pos_KitchenRight']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_KitchenRightFalse(1),Viewpoint.pos_KitchenRight(1),L);
y_pos=linspace(Viewpoint.pos_KitchenRightFalse(2),Viewpoint.pos_KitchenRight(2),L);
z_pos=linspace(Viewpoint.pos_KitchenRightFalse(3),Viewpoint.pos_KitchenRight(3),L);
x_ori=linspace(Viewpoint.ori_KitchenRightFalse(1),Viewpoint.ori_KitchenRight(1),L);
y_ori=linspace(Viewpoint.ori_KitchenRightFalse(2),-Viewpoint.ori_KitchenRight(2),L);
z_ori=linspace(Viewpoint.ori_KitchenRightFalse(3),Viewpoint.ori_KitchenRight(3),L);
rot_ori=linspace(Viewpoint.ori_KitchenRightFalse(4),-Viewpoint.ori_KitchenRight(4),L);
for i=floor(L):-1:1
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[6.5 1.2 2.9])%Station_front
setfield(object_nodes(2),'translation',[4.4 1.2 1])%Station_Left
setfield(object_nodes(3),'translation',[6.6304 1.1892 4.28])%Station_right
vrdrawnow;pause(1);
setfield(object_nodes(7),'scale',.3*ones(1,3))%Right_Hand_Scale_Rot(.3-->.6)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 -pi/180*111])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[6.037 2.38 4.95])%Right_Hand
setfield(object_nodes(9),'scale',.05*ones(1,3))%Left_Hand_Scale_Rot(.05-->.105)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*0])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.255 1.83 5.5])%Left_Hand
setfield(object_nodes(11),'scale',.045*ones(1,3))%Tennis_Shoe_Right(.045-->.09)
setfield(object_nodes(11),'rotation',[.4756 .4429 .76 pi/180*108])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[6 1.4 3])%Tennis_Shoe_Right
vrdrawnow;pause(3);
    for i=.05:(.105-.05)/15:.105%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_Left
    setfield(object_nodes(5),'emissiveColor',[0 0 .3]);pause(eps)%Color_Station_Left
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from KitchenRight to Kitchen
L=dist([Viewpoint.pos_KitchenRightFalse',Viewpoint.pos_Kitchen']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_KitchenRightFalse(1),Viewpoint.pos_Kitchen(1),L);
y_pos=linspace(Viewpoint.pos_KitchenRightFalse(2),Viewpoint.pos_Kitchen(2),L);
z_pos=linspace(Viewpoint.pos_KitchenRightFalse(3),Viewpoint.pos_Kitchen(3),L);
x_ori=linspace(Viewpoint.ori_KitchenRightFalse(1),Viewpoint.ori_Kitchen(1),L);
y_ori=linspace(-Viewpoint.ori_KitchenRightFalse(2),Viewpoint.ori_Kitchen(2),L);
z_ori=linspace(Viewpoint.ori_KitchenRightFalse(3),Viewpoint.ori_Kitchen(3),L);
rot_ori=linspace(-Viewpoint.ori_KitchenRightFalse(4),Viewpoint.ori_Kitchen(4)-6.283,L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(7),'scale',.35*ones(1,3))%Right_Hand_Scale_Rot(.35-->.7)
setfield(object_nodes(7),'rotation',[-.018 -.9929 .1177 pi/180*12.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.4 2.7 1.8])%Right_Hand
setfield(object_nodes(9),'scale',.2*ones(1,3))%Left_Hand_Scale_Rot(.2-->.4)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*111.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[5.25 2.32 .1])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.2:(.4-.2)/15:.4%Left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
pause(1)
setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
setfield(object_nodes(24),'on',0)%Spot_Light_Kitchen
setfield(object_nodes(25),'on',1)%Spot_Light_DiningTable
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
setfield(object_nodes(1),'translation',[1.9091 1.2 .9511])%Station_front
setfield(object_nodes(2),'translation',[1.9091 1.2 3.2511])%Station_Left
setfield(object_nodes(3),'translation',[4.0091 1.6 -.9489])%Station_right
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.085*ones(1,3))%Right_Hand_Scale_Rot(.085-->.171)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*120.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[7.1 2.5549 .25])%Right_Hand
setfield(object_nodes(9),'scale',.085*ones(1,3))%Left_Hand_Scale_Rot(.085-->.171)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*115.2])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[7.2408 2.43 1.21])%Left_Hand
setfield(object_nodes(11),'scale',.0325*ones(1,3))%Tennis_Shoe_Right(.0325-->.065)
setfield(object_nodes(11),'rotation',[.7132 .701 .0073 pi/180*179.7101])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[4.8493 2.1378 .6226])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.085:(.171-.085)/15:.171%right hand enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%right_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(4),'diffuseColor',[.8 .8 .01]);pause(eps)%Color_Station_Left
    setfield(object_nodes(4),'emissiveColor',[.3 .3 0]);pause(eps)%Color_Station_Left
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from KitchenFalse to DiningTable
L=dist([Viewpoint.pos_KitchenFalse',Viewpoint.pos_DiningTable']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_DiningTable(1),Viewpoint.pos_KitchenFalse(1),L);
y_pos=linspace(Viewpoint.pos_DiningTable(2),Viewpoint.pos_KitchenFalse(2),L);
z_pos=linspace(Viewpoint.pos_DiningTable(3),Viewpoint.pos_KitchenFalse(3),L);
x_ori=linspace(Viewpoint.ori_DiningTable(1),Viewpoint.ori_KitchenFalse(1),L);
y_ori=linspace(-Viewpoint.ori_DiningTable(2),Viewpoint.ori_KitchenFalse(2),L);
z_ori=linspace(Viewpoint.ori_DiningTable(3),Viewpoint.ori_KitchenFalse(3),L);
rot_ori=linspace(-Viewpoint.ori_DiningTable(4),Viewpoint.ori_KitchenFalse(4),L);
for i=floor(L):-1:1
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
setfield(object_nodes(7),'scale',.075*ones(1,3))%Right_Hand_Scale_Rot(.075-->.15)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*113.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.3 2.13 -.3748])%Right_Hand
setfield(object_nodes(9),'scale',.13*ones(1,3))%Left_Hand_Scale_Rot(.13-->.26)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*1.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[3.05 2.114 -.95])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.13:(.26-.13)/15:.26%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_DiningTableFalse',Viewpoint.pos_DiningTable']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_DiningTable(1),Viewpoint.pos_DiningTableFalse(1),L);
y_pos=linspace(Viewpoint.pos_DiningTable(2),Viewpoint.pos_DiningTableFalse(2),L);
z_pos=linspace(Viewpoint.pos_DiningTable(3),Viewpoint.pos_DiningTableFalse(3),L);
x_ori=linspace(Viewpoint.ori_DiningTable(1),Viewpoint.ori_DiningTableFalse(1),L);
y_ori=linspace(Viewpoint.ori_DiningTable(2),Viewpoint.ori_DiningTableFalse(2),L);
z_ori=linspace(Viewpoint.ori_DiningTable(3),Viewpoint.ori_DiningTableFalse(3),L);
rot_ori=linspace(Viewpoint.ori_DiningTable(4)+6.283,Viewpoint.ori_DiningTableFalse(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[2.568 1.2 3.232])%Station_front
setfield(object_nodes(2),'translation',[3.768 1.2 2.232])%Station_Left
setfield(object_nodes(3),'translation',[2.1 1.2 -.9])%Station_right
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.105*ones(1,3))%Right_Hand_Scale_Rot(.105-->.21)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*68.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[4 2.26 -3.41])%Right_Hand
setfield(object_nodes(9),'scale',.043*ones(1,3))%Left_Hand_Scale_Rot(.043-->.087)
setfield(object_nodes(9),'rotation',[.036 .9969 -.0706 -pi/180*163.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.94 2.035 -3])%Left_Hand
setfield(object_nodes(11),'scale',.0095*ones(1,3))%Tennis_Shoe_Right(.0095-->.019)
setfield(object_nodes(11),'rotation',[-.6749 -.6349 .3761 pi/180*140.4])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[4.1699 2.32 -2.75])%Tennis_Shoe_Right
vrdrawnow;pause(3)
    for i=.105:(.21-.105)/15:.21%right hand enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(4),'diffuseColor',[.8 .8 .01]);pause(eps)%Color_Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 .3 0]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from Dining_Table to Bed_Bath_Door
L=dist([Viewpoint.pos_DiningTableFalse',Viewpoint.pos_BedBathDoor']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_DiningTableFalse(1),Viewpoint.pos_BedBathDoor(1),L);
y_pos=linspace(Viewpoint.pos_DiningTableFalse(2),Viewpoint.pos_BedBathDoor(2),L);
z_pos=linspace(Viewpoint.pos_DiningTableFalse(3),Viewpoint.pos_BedBathDoor(3),L);
x_ori=linspace(Viewpoint.ori_DiningTableFalse(1),Viewpoint.ori_BedBathDoor(1),L);
y_ori=linspace(-Viewpoint.ori_DiningTableFalse(2),Viewpoint.ori_BedBathDoor(2),L);
z_ori=linspace(Viewpoint.ori_DiningTableFalse(3),Viewpoint.ori_BedBathDoor(3),L);
rot_ori=linspace(-Viewpoint.ori_DiningTableFalse(4)+6.283,Viewpoint.ori_BedBathDoor(4),L);
for i=1:floor(L)
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(7),'scale',.105*ones(1,3))%Right_Hand_Scale_Rot(.105-->.21)
setfield(object_nodes(7),'rotation',[-.0224 -.994 -.0273 -pi/180*180])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.63 1.91 1.226])%Right_Hand
setfield(object_nodes(9),'scale',.275*ones(1,3))%Left_Hand_Scale_Rot(.275-->.55)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*55.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.9 2.15 1.0736])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.105:(.21-.105)/15:.21%Right hand enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(27),'position',[Viewpoint.pos_BedBathDoorTrue(1) Viewpoint.pos_BedBathDoorTrue(2) Viewpoint.pos_BedBathDoorTrue(3)]);
    setfield(object_nodes(27),'orientation',[Viewpoint.ori_BedBathDoorTrue(1) Viewpoint.ori_BedBathDoorTrue(2) Viewpoint.ori_BedBathDoorTrue(3) Viewpoint.ori_BedBathDoorTrue(4)]);
    vrdrawnow
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[1.568 1.2 -.8376])%Station_front
setfield(object_nodes(2),'translation',[1.568 1.2 .1624])%Station_Left
setfield(object_nodes(3),'translation',[1.768 1.2 -7.0376])%Station_right
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.105*ones(1,3))%Right_Hand_Scale_Rot(.105-->.21)
setfield(object_nodes(7),'rotation',[-.0224 -.994 -.0273 -pi/180*180])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[3.63 1.91 1.226])%Right_Hand
setfield(object_nodes(9),'scale',.275*ones(1,3))%Left_Hand_Scale_Rot(.275-->.55)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*55.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.9 2.15 1.0736])%Left_Hand
setfield(object_nodes(11),'scale',.0105*ones(1,3))%Tennis_Shoe_Right(.0105-->.021)
setfield(object_nodes(11),'rotation',[.6559 .6449 .3923 pi/180*141.0473])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[3.1 1.95 1.4327])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.24:(.46-.24)/15:.46%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_right
    setfield(object_nodes(5),'emissiveColor',[0 0 0.3]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right

%% Navigation from Bed_Bath_Door to Bedroom
L=dist([Viewpoint.pos_BedroomDoor',Viewpoint.pos_BedBathDoor']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_BedBathDoor(1),Viewpoint.pos_BedroomDoor(1),L);
y_pos=linspace(Viewpoint.pos_BedBathDoor(2),Viewpoint.pos_BedroomDoor(2),L);
z_pos=linspace(Viewpoint.pos_BedBathDoor(3),Viewpoint.pos_BedroomDoor(3),L);
x_ori=linspace(Viewpoint.ori_BedBathDoor(1),Viewpoint.ori_BedroomDoor(1),L);
y_ori=linspace(Viewpoint.ori_BedBathDoor(2),Viewpoint.ori_BedroomDoor(2),L);
z_ori=linspace(Viewpoint.ori_BedBathDoor(3),Viewpoint.ori_BedroomDoor(3),L);
rot_ori=linspace(Viewpoint.ori_BedBathDoor(4),Viewpoint.ori_BedroomDoor(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L=100;
x_pos=linspace(1.392,.955,L);
y_pos=linspace(2,2,L);
z_pos=linspace(.003,-.39,L);
x_ori=linspace(0,0,L);
y_ori=linspace(1,1,L);
z_ori=linspace(0,0,L);
rot_ori=linspace(pi/180*90,pi/180*0,L);
for i=1:L
    setfield(object_nodes(55),'translation',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(55),'rotation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L=dist([Viewpoint.pos_BedroomDoor',Viewpoint.pos_Bedroom']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_BedroomDoor(1),Viewpoint.pos_Bedroom(1),L);
y_pos=linspace(Viewpoint.pos_BedroomDoor(2),Viewpoint.pos_Bedroom(2),L);
z_pos=linspace(Viewpoint.pos_BedroomDoor(3),Viewpoint.pos_Bedroom(3),L);
x_ori=linspace(Viewpoint.ori_BedroomDoor(1),Viewpoint.ori_Bedroom(1),L);
y_ori=linspace(Viewpoint.ori_BedroomDoor(2),Viewpoint.ori_Bedroom(2),L);
z_ori=linspace(Viewpoint.ori_BedroomDoor(3),Viewpoint.ori_Bedroom(3),L);
rot_ori=linspace(Viewpoint.ori_BedroomDoor(4),Viewpoint.ori_Bedroom(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(23),'on',1)%Spot_Light_bedroom
setfield(object_nodes(25),'on',0)%Spot_Light_diningtable
setfield(object_nodes(7),'scale',.095*ones(1,3))%Right_Hand_Scale_Rot(.095-->.19)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*81])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[.7 1.93 -.42])%Right_Hand
setfield(object_nodes(9),'scale',.095*ones(1,3))%Left_Hand_Scale_Rot(.095-->.185)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*162])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.58 1.8 .366])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.095:(.19-.095)/15:.19%right hand enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(27),'position',[Viewpoint.pos_BedroomTrue(1) Viewpoint.pos_BedroomTrue(2) Viewpoint.pos_BedroomTrue(3)]);
    setfield(object_nodes(27),'orientation',[Viewpoint.ori_BedroomTrue(1) Viewpoint.ori_BedroomTrue(2) Viewpoint.ori_BedroomTrue(3) Viewpoint.ori_BedroomTrue(4)]);
    vrdrawnow
set(vrfigure_object,'Viewpoint','Subject_Viewpoint'); 
setfield(object_nodes(1),'translation',[-.9704 1.2 3.7208])%Station_front
setfield(object_nodes(3),'translation',[-1.4704 1.2 1.6208])%Station_Right
setfield(object_nodes(2),'translation',[.6296 1.2 5.0208])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.095*ones(1,3))%Right_Hand_Scale_Rot(.095-->.19)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*81])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[.7 1.93 -.42])%Right_Hand
setfield(object_nodes(9),'scale',.095*ones(1,3))%Left_Hand_Scale_Rot(.095-->.185)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*162])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.58 1.8 .366])%Left_Hand
setfield(object_nodes(11),'scale',.008*ones(1,3))%Tennis_Shoe_Right(.008-->.016)
setfield(object_nodes(11),'rotation',[.7 .7 -.3 -pi/180*145.8])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[.9176 2.03 .1368])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.095:(.185-.095)/15:.185%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_right
    setfield(object_nodes(5),'emissiveColor',[0 0 0.3]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right

%% Navigation from Bedroom to Bedroom_Left
L=dist([Viewpoint.pos_BedroomLeft',Viewpoint.pos_Bedroom']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_Bedroom(1),Viewpoint.pos_BedroomLeft(1),L);
y_pos=linspace(Viewpoint.pos_Bedroom(2),Viewpoint.pos_BedroomLeft(2),L);
z_pos=linspace(Viewpoint.pos_Bedroom(3),Viewpoint.pos_BedroomLeft(3),L);
x_ori=linspace(Viewpoint.ori_Bedroom(1),Viewpoint.ori_BedroomLeft(1),L);
y_ori=linspace(Viewpoint.ori_Bedroom(2),Viewpoint.ori_BedroomLeft(2),L);
z_ori=linspace(Viewpoint.ori_Bedroom(3),Viewpoint.ori_BedroomLeft(3),L);
rot_ori=linspace(Viewpoint.ori_Bedroom(4),Viewpoint.ori_BedroomLeft(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(7),'scale',.19*ones(1,3))%Right_Hand_Scale_Rot(.19-->.4)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*34.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-.3 1.5 4.34])%Right_Hand
setfield(object_nodes(9),'scale',.16*ones(1,3))%Left_Hand_Scale_Rot(.16-->.325)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*156.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.47 1.34 4.57])%Left_Hand
vrdrawnow;pause(3)
    for i=.16:(.325-.16)/15:.325%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_BedroomLeft',Viewpoint.pos_BedroomLeftFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_BedroomLeft(1),Viewpoint.pos_BedroomLeftFalse(1),L);
y_pos=linspace(Viewpoint.pos_BedroomLeft(2),Viewpoint.pos_BedroomLeftFalse(2),L);
z_pos=linspace(Viewpoint.pos_BedroomLeft(3),Viewpoint.pos_BedroomLeftFalse(3),L);
x_ori=linspace(Viewpoint.ori_BedroomLeft(1),Viewpoint.ori_BedroomLeftFalse(1),L);
y_ori=linspace(Viewpoint.ori_BedroomLeft(2),Viewpoint.ori_BedroomLeftFalse(2),L);
z_ori=linspace(Viewpoint.ori_BedroomLeft(3),Viewpoint.ori_BedroomLeftFalse(3),L);
rot_ori=linspace(Viewpoint.ori_BedroomLeft(4),Viewpoint.ori_BedroomLeftFalse(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[-1.6654 1.2 .844])%Station_front
setfield(object_nodes(3),'translation',[1.0562 1.2 .3176])%Station_Right
setfield(object_nodes(2),'translation',[-1.6654 1.2 2.7368])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.165*ones(1,3))%Right_Hand_Scale_Rot(.165-->.34)
setfield(object_nodes(7),'rotation',[0 1 0 -pi/180*163.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.12 2.0 4.4])%Right_Hand
setfield(object_nodes(9),'scale',.2*ones(1,3))%Left_Hand_Scale_Rot(.2-->.4)
setfield(object_nodes(9),'rotation',[0 1 0 -pi/180*37.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-.2 1.97 4.6704])%Left_Hand
setfield(object_nodes(11),'scale',.006*ones(1,3))%Tennis_Shoe_Right(.006-->.012)
setfield(object_nodes(11),'rotation',[.593 .669 .4481 pi/180*123.154])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[.49 2.03 5.3352])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.2:(.4-.2)/15:.4%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_right
    setfield(object_nodes(5),'emissiveColor',[0 0 .3]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from Bedroom_Left to BedroomFront
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
setfield(object_nodes(7),'scale',.29*ones(1,3))%Right_Hand_Scale_Rot(.29-->.59)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*34.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.25 2.1416 4.4584])%Right_Hand
setfield(object_nodes(9),'scale',.068*ones(1,3))%Left_Hand_Scale_Rot(.068-->.137)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*156.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-.37 1.62 3.4912])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.068:(.137-.068)/15:.137%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
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
setfield(object_nodes(1),'translation',[.6296 1.2 .6])%Station_front
setfield(object_nodes(3),'translation',[1.0616 1.2 4.084])%Station_Right
setfield(object_nodes(2),'translation',[-1.4224 1.2 .8])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.36*ones(1,3))%Right_Hand_Scale_Rot(.36-->.75)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*129.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[.75 2.4 4.4584])%Right_Hand
setfield(object_nodes(9),'scale',.065*ones(1,3))%Left_Hand_Scale_Rot(.065-->.13)
setfield(object_nodes(9),'rotation',[0 1 0 -pi/180*15])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-1.25 1.78 5.8672])%Left_Hand
setfield(object_nodes(11),'scale',.0065*ones(1,3))%Tennis_Shoe_Right(.0065-->.0135)
setfield(object_nodes(11),'rotation',[.5276 .6216 .5798 pi/180*113])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-1.3118 2.1 5.8353])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.065:(.13-.065)/15:.13%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_right
    setfield(object_nodes(5),'emissiveColor',[0 0 .3]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from Bedroom_Front to BedroomRight
L=dist([Viewpoint.pos_BedroomRight',Viewpoint.pos_BedroomFrontFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_BedroomFrontFalse(1),Viewpoint.pos_BedroomRight(1),L);
y_pos=linspace (Viewpoint.pos_BedroomFrontFalse(2),Viewpoint.pos_BedroomRight(2),L);
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
setfield(object_nodes(7),'scale',.3*ones(1,3))%Right_Hand_Scale_Rot(.3-->.6)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*113.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-1.208 2.25 .1])%Right_Hand
setfield(object_nodes(9),'scale',.28*ones(1,3))%Left_Hand_Scale_Rot(.28-->.55)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*120.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-1.208 2.15 2.72])%Left_Hand
vrdrawnow;pause(3)
    for i=.28:(.55-.28)/15:.55%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_BedroomRight',Viewpoint.pos_BedroomRightFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_BedroomRight(1),Viewpoint.pos_BedroomRightFalse(1),L);
y_pos=linspace(Viewpoint.pos_BedroomRight(2),Viewpoint.pos_BedroomRightFalse(2),L);
z_pos=linspace(Viewpoint.pos_BedroomRight(3),Viewpoint.pos_BedroomRightFalse(3),L);
x_ori=linspace(Viewpoint.ori_BedroomRight(1),Viewpoint.ori_BedroomRightFalse(1),L);
y_ori=linspace(Viewpoint.ori_BedroomRight(2),Viewpoint.ori_BedroomRightFalse(2),L);
z_ori=linspace(Viewpoint.ori_BedroomRight(3),Viewpoint.ori_BedroomRightFalse(3),L);
rot_ori=linspace(Viewpoint.ori_BedroomRight(4),Viewpoint.ori_BedroomRightFalse(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[.6296 1.2 5.02])%Station_front
setfield(object_nodes(3),'translation',[-.9704 1.2 3.72])%Station_Right
setfield(object_nodes(2),'translation',[.6296 1.2 .6])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.202*ones(1,3))%Right_Hand_Scale_Rot(.202-->.41)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*25.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.4 2.35 .7424])%Right_Hand
setfield(object_nodes(9),'scale',.18*ones(1,3))%Left_Hand_Scale_Rot(.18-->.36)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*99])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-1.208 2.2 -.28])%Left_Hand
setfield(object_nodes(11),'scale',.0055*ones(1,3))%Tennis_Shoe_Right(.0055-->.011)
setfield(object_nodes(11),'rotation',[-.3441 -.2373 .9085 pi/180*103.5739])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-2.6078 2.34 -.12])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.18:(.36-.18)/15:.36%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_right
    setfield(object_nodes(5),'emissiveColor',[0 0 .3]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from Bedroom_Right to BedroomFalse
L=dist([Viewpoint.pos_Bedroom',Viewpoint.pos_BedroomRightFalse']);
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
setfield(object_nodes(7),'scale',.062*ones(1,3))%Right_Hand_Scale_Rot(.062-->.125)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*68.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1 1.868 -.53])%Right_Hand
setfield(object_nodes(9),'scale',.085*ones(1,3))%Left_Hand_Scale_Rot(.085-->.17)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*171])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.63 1.79 .263])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.085:(.17-.085)/15:.17%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_BedroomDoor',Viewpoint.pos_Bedroom']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_Bedroom(1),Viewpoint.pos_BedroomDoor(1),L);
y_pos=linspace(Viewpoint.pos_Bedroom(2),Viewpoint.pos_BedroomDoor(2),L);
z_pos=linspace(Viewpoint.pos_Bedroom(3),Viewpoint.pos_BedroomDoor(3),L);
x_ori=linspace(Viewpoint.ori_Bedroom(1),Viewpoint.ori_BedroomDoor(1),L);
y_ori=linspace(Viewpoint.ori_Bedroom(2),Viewpoint.ori_BedroomDoor(2),L);
z_ori=linspace(Viewpoint.ori_Bedroom(3),Viewpoint.ori_BedroomDoor(3),L);
rot_ori=linspace(Viewpoint.ori_Bedroom(4),Viewpoint.ori_BedroomDoor(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L=100;
x_pos=linspace(1.392,.955,L);
y_pos=linspace(2,2,L);
z_pos=linspace(.003,-.39,L);
x_ori=linspace(0,0,L);
y_ori=linspace(1,1,L);
z_ori=linspace(0,0,L);
rot_ori=linspace(pi/180*90,pi/180*0,L);
for i=L:-1:1
    setfield(object_nodes(55),'translation',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(55),'rotation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(23),'on',0)%Spot_Light_Bedroom
setfield(object_nodes(25),'on',1)%Spot_Light_DiningTable
L=dist([Viewpoint.pos_BedroomDoor',Viewpoint.pos_BedroomFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_BedroomFalse(1),Viewpoint.pos_BedroomDoor(1),L);
y_pos=linspace(Viewpoint.pos_BedroomFalse(2),Viewpoint.pos_BedroomDoor(2),L);
z_pos=linspace(Viewpoint.pos_BedroomFalse(3),Viewpoint.pos_BedroomDoor(3),L);
x_ori=linspace(Viewpoint.ori_BedroomFalse(1),Viewpoint.ori_BedroomDoor(1),L);
y_ori=linspace(Viewpoint.ori_BedroomFalse(2),Viewpoint.ori_BedroomDoor(2),L);
z_ori=linspace(Viewpoint.ori_BedroomFalse(3),Viewpoint.ori_BedroomDoor(3),L);
rot_ori=linspace(Viewpoint.ori_BedroomFalse(4),Viewpoint.ori_BedroomDoor(4),L);
for i=floor(L):-1:1
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[1.5091 1.2 -1.0697])%Station_front
setfield(object_nodes(3),'translation',[1.5091 1.408 -3.4825])%Station_Right
setfield(object_nodes(2),'translation',[1.5091 1.2 1.5511])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.092*ones(1,3))%Right_Hand_Scale_Rot(.092-->.185)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*136.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[5.584 2.27 -.27])%Right_Hand
setfield(object_nodes(9),'scale',.07*ones(1,3))%Left_Hand_Scale_Rot(.07-->.141)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*100.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[5.7216 2.12 .675])%Left_Hand
setfield(object_nodes(11),'scale',.027*ones(1,3))%Tennis_Shoe_Right(.027-->.055)
setfield(object_nodes(11),'rotation',[.7121 .6996 .0589 pi/180*173.7003])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[3.7497 2 .0315])%Tennis_Shoe_Right
setfield(object_nodes(25),'on',1)%Spot_Light_DiningTable
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.027:(.055-.027)/15:.055%foot enlarging
        setfield(object_nodes(11),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(6),'diffuseColor',[.01 .8 .09]);pause(eps)%Color_Station_right
    setfield(object_nodes(6),'emissiveColor',[0 0.3 0]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from BedroomFalse to WCBath
L=dist([Viewpoint.pos_WCBathDoor',Viewpoint.pos_BedroomFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_BedroomFalse(1),Viewpoint.pos_WCBathDoor(1),L);
y_pos=linspace(Viewpoint.pos_BedroomFalse(2),Viewpoint.pos_WCBathDoor(2),L);
z_pos=linspace(Viewpoint.pos_BedroomFalse(3),Viewpoint.pos_WCBathDoor(3),L);
x_ori=linspace(Viewpoint.ori_BedroomFalse(1),Viewpoint.ori_WCBathDoor(1),L);
y_ori=linspace(Viewpoint.ori_BedroomFalse(2),Viewpoint.ori_WCBathDoor(2),L);
z_ori=linspace(Viewpoint.ori_BedroomFalse(3),Viewpoint.ori_WCBathDoor(3),L);
rot_ori=linspace(Viewpoint.ori_BedroomFalse(4),Viewpoint.ori_WCBathDoor(4),L);
for i=1:L
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
for i=1:L
    setfield(object_nodes(56),'translation',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(56),'rotation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
L=dist([Viewpoint.pos_WCBathDoor',Viewpoint.pos_WCBath']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_WCBathDoor(1),Viewpoint.pos_WCBath(1),L);
y_pos=linspace(Viewpoint.pos_WCBathDoor(2),Viewpoint.pos_WCBath(2),L);
z_pos=linspace(Viewpoint.pos_WCBathDoor(3),Viewpoint.pos_WCBath(3),L);
x_ori=linspace(Viewpoint.ori_WCBathDoor(1),Viewpoint.ori_WCBath(1),L);
y_ori=linspace(Viewpoint.ori_WCBathDoor(2),Viewpoint.ori_WCBath(2),L);
z_ori=linspace(Viewpoint.ori_WCBathDoor(3),Viewpoint.ori_WCBath(3),L);
rot_ori=linspace(Viewpoint.ori_WCBathDoor(4),Viewpoint.ori_WCBath(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(13),'on',1)%Spot_Light_toilet
setfield(object_nodes(25),'on',0)%Spot_Light_diningtable
setfield(object_nodes(7),'scale',.095*ones(1,3))%Right_Hand_Scale_Rot(.095-->.195)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*163.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.22 2.12 -1.9548])%Right_Hand
setfield(object_nodes(9),'scale',.06*ones(1,3))%Left_Hand_Scale_Rot(.06-->.12)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*82.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.2604 1.93 -1.06])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.095:(.195-.095)/15:.195%%right hand enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(27),'position',[Viewpoint.pos_WCBathTrue(1) Viewpoint.pos_WCBathTrue(2) Viewpoint.pos_WCBathTrue(3)]);
    setfield(object_nodes(27),'orientation',[Viewpoint.ori_WCBathTrue(1) Viewpoint.ori_WCBathTrue(2) Viewpoint.ori_WCBathTrue(3) Viewpoint.ori_WCBathTrue(4)]);
    vrdrawnow
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[-2.2704 1.2 -2.9952])%Station_front
setfield(object_nodes(3),'translation',[-1.32 1.2 -4.8268])%Station_Right
setfield(object_nodes(2),'translation',[-2.2704 1.2 -1.7792])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.095*ones(1,3))%Right_Hand_Scale_Rot(.095-->.195)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*163.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.22 2.12 -1.9548])%Right_Hand
setfield(object_nodes(9),'scale',.06*ones(1,3))%Left_Hand_Scale_Rot(.06-->.12)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*82.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.2604 1.93 -1.06])%Left_Hand
setfield(object_nodes(11),'scale',.01*ones(1,3))%Tennis_Shoe_Right(.01-->.02)
setfield(object_nodes(11),'rotation',[.6957 .6928 .1896 pi/180*158.0915])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[.7385 2.18 -1.5067])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.06:(.12-.06)/15:.12%%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_right
    setfield(object_nodes(5),'emissiveColor',[0 0 0.3]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right

%% Navigation from WCBath to WCBathLeft
L=dist([Viewpoint.pos_WCBathLeft',Viewpoint.pos_WCBath']);
L=L(1,2)/.034;
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
setfield(object_nodes(7),'scale',.24*ones(1,3))%Right_Hand_Scale_Rot(.24-->.48)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*126])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.8 2.39 -2.95])%Right_Hand
setfield(object_nodes(9),'scale',.175*ones(1,3))%Left_Hand_Scale_Rot(.175-->.35)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*113.4])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-2.4416 2.17 -.9])%Left_Hand
vrdrawnow;pause(3)
    for i=.175:(.35-.175)/15:.35%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_WCBathLeft',Viewpoint.pos_WCBathLeftFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_WCBathLeft(1),Viewpoint.pos_WCBathLeftFalse(1),L);
y_pos=linspace(Viewpoint.pos_WCBathLeft(2),Viewpoint.pos_WCBathLeftFalse(2),L);
z_pos=linspace(Viewpoint.pos_WCBathLeft(3),Viewpoint.pos_WCBathLeftFalse(3),L);
x_ori=linspace(Viewpoint.ori_WCBathLeft(1),Viewpoint.ori_WCBathLeftFalse(1),L);
y_ori=linspace(-Viewpoint.ori_WCBathLeft(2),Viewpoint.ori_WCBathLeftFalse(2),L);
z_ori=linspace(Viewpoint.ori_WCBathLeft(3),Viewpoint.ori_WCBathLeftFalse(3),L);
rot_ori=linspace(-Viewpoint.ori_WCBathLeft(4),Viewpoint.ori_WCBathLeftFalse(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[.104 1.272 -4.788])%Station_front
setfield(object_nodes(3),'translation',[.904 1.2 -3.748])%Station_Right
setfield(object_nodes(2),'translation',[-1.496 1.2 -3.748])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.5*ones(1,3))%Right_Hand_Scale_Rot(.5-->1)
setfield(object_nodes(7),'rotation',[0 1 0 -pi/180*144])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.1 2.7 -3.85])%Right_Hand
setfield(object_nodes(9),'scale',.36*ones(1,3))%Left_Hand_Scale_Rot(.36-->.73)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*23.4])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-2.45 2.71 -3.5])%Left_Hand
setfield(object_nodes(11),'scale',.036*ones(1,3))%Tennis_Shoe_Right(.036-->.07)
setfield(object_nodes(11),'rotation',[.4984 .5998 .6259 pi/180*109.535])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-1.1977 1.65 -3.4991])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.36:(.73-.36)/15:.73%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_right
    setfield(object_nodes(5),'emissiveColor',[0 0 .3]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from WCBathLeft to WCBathFront
L=dist([Viewpoint.pos_WCBathFront',Viewpoint.pos_WCBathLeftFalse']);
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
setfield(object_nodes(7),'scale',.53*ones(1,3))%Right_Hand_Scale_Rot(.53-->1)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*126])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.4 2.18 -5.4])%Right_Hand
setfield(object_nodes(9),'scale',.4*ones(1,3))%Left_Hand_Scale_Rot(.4-->.8)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*113.4])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-2.1776 1.95 -2.35])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.4:(.8-.4)/15:.8%%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_WCBathFront',Viewpoint.pos_WCBathFrontFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_WCBathFront(1),Viewpoint.pos_WCBathFrontFalse(1),L);
y_pos=linspace(Viewpoint.pos_WCBathFront(2),Viewpoint.pos_WCBathFrontFalse(2),L);
z_pos=linspace(Viewpoint.pos_WCBathFront(3),Viewpoint.pos_WCBathFrontFalse(3),L);
x_ori=linspace(Viewpoint.ori_WCBathFront(1),Viewpoint.ori_WCBathFrontFalse(1),L);
y_ori=linspace(Viewpoint.ori_WCBathFront(2),Viewpoint.ori_WCBathFrontFalse(2),L);
z_ori=linspace(Viewpoint.ori_WCBathFront(3),Viewpoint.ori_WCBathFrontFalse(3),L);
rot_ori=linspace(Viewpoint.ori_WCBathFront(4),Viewpoint.ori_WCBathFrontFalse(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[1.104 1.2 -.648])%Station_front
setfield(object_nodes(3),'translation',[-2.296 1.2 -.748])%Station_Right
setfield(object_nodes(2),'translation',[1.104 1.2 -2.5])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.355*ones(1,3))%Right_Hand_Scale_Rot(.355-->.71)
setfield(object_nodes(7),'rotation',[0 1 0 -pi/180*0])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.6 2.6 -2])%Right_Hand
setfield(object_nodes(9),'scale',.35*ones(1,3))%Left_Hand_Scale_Rot(.35-->.7)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*120])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[.38 2.73 -3.1])%Left_Hand
setfield(object_nodes(11),'scale',.024*ones(1,3))%Tennis_Shoe_Right(.024-->.048)
setfield(object_nodes(11),'rotation',[-.4419 -.4351 .7845 pi/180*113.5282])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-1.5 2.1 -2.8])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.35:(.7-.35)/15:.7%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_right
    setfield(object_nodes(5),'emissiveColor',[0 0 .3]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from WCBathFront to WCBathRight
L=dist([Viewpoint.pos_WCBathRight',Viewpoint.pos_WCBathFrontFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_WCBathFrontFalse(1),Viewpoint.pos_WCBathRight(1),L);
y_pos=linspace(Viewpoint.pos_WCBathFrontFalse(2),Viewpoint.pos_WCBathRight(2),L);
z_pos=linspace(Viewpoint.pos_WCBathFrontFalse(3),Viewpoint.pos_WCBathRight(3),L);
x_ori=linspace(Viewpoint.ori_WCBathFrontFalse(1),Viewpoint.ori_WCBathRight(1),L);
y_ori=linspace(Viewpoint.ori_WCBathFrontFalse(2),Viewpoint.ori_WCBathRight(2),L);
z_ori=linspace(Viewpoint.ori_WCBathFrontFalse(3),Viewpoint.ori_WCBathRight(3),L);
rot_ori=linspace(Viewpoint.ori_WCBathFrontFalse(4),Viewpoint.ori_WCBathRight(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(7),'scale',.205*ones(1,3))%Right_Hand_Scale_Rot(.205-->.41)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*129.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[.19 2.24 -6.8])%Right_Hand
setfield(object_nodes(9),'scale',.25*ones(1,3))%Left_Hand_Scale_Rot(.25-->.5)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*117])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[.0224 2.22 -4.7])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.25:(.5-.25)/15:.5%%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_WCBathRight',Viewpoint.pos_WCBathRightFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_WCBathRight(1),Viewpoint.pos_WCBathRightFalse(1),L);
y_pos=linspace(Viewpoint.pos_WCBathRight(2),Viewpoint.pos_WCBathRightFalse(2),L);
z_pos=linspace(Viewpoint.pos_WCBathRight(3),Viewpoint.pos_WCBathRightFalse(3),L);
x_ori=linspace(Viewpoint.ori_WCBathRight(1),Viewpoint.ori_WCBathRightFalse(1),L);
y_ori=linspace(Viewpoint.ori_WCBathRight(2),Viewpoint.ori_WCBathRightFalse(2),L);
z_ori=linspace(Viewpoint.ori_WCBathRight(3),Viewpoint.ori_WCBathRightFalse(3),L);
rot_ori=linspace(Viewpoint.ori_WCBathRight(4),Viewpoint.ori_WCBathRightFalse(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[-1.592 1.2 -2.348])%Station_front
setfield(object_nodes(3),'translation',[-2.6 1.2 -.748])%Station_Right
setfield(object_nodes(2),'translation',[1.1296 1.2 -1.0376])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.255*ones(1,3))%Right_Hand_Scale_Rot(.255-->.51)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*32.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.45 2.5 -4.36])%Right_Hand
setfield(object_nodes(9),'scale',.3*ones(1,3))%Left_Hand_Scale_Rot(.3-->.6)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*144])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[0.12 2.5 -3.714])%Left_Hand
setfield(object_nodes(11),'scale',.0225*ones(1,3))%Tennis_Shoe_Right(.0225-->.045)
setfield(object_nodes(11),'rotation',[-.5641 -.5 .6565 pi/180*118.4381])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-1.4502 2 -3.8408])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.3:(.6-.3)/15:.6%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(5),'diffuseColor',[0 .18 1]);pause(eps)%Color_Station_right
    setfield(object_nodes(5),'emissiveColor',[0 0 .3]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from WCBathRight to WCBathFalse 
L=dist([Viewpoint.pos_WCBath',Viewpoint.pos_WCBathRightFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_WCBathRightFalse(1),Viewpoint.pos_WCBath(1),L);
y_pos=linspace(Viewpoint.pos_WCBathRightFalse(2),Viewpoint.pos_WCBath(2),L);
z_pos=linspace(Viewpoint.pos_WCBathRightFalse(3),Viewpoint.pos_WCBath(3),L);
x_ori=linspace(Viewpoint.ori_WCBathRightFalse(1),Viewpoint.ori_WCBath(1),L);
y_ori=linspace(Viewpoint.ori_WCBathRightFalse(2),Viewpoint.ori_WCBath(2),L);
z_ori=linspace(Viewpoint.ori_WCBathRightFalse(3),Viewpoint.ori_WCBath(3),L);
rot_ori=linspace(Viewpoint.ori_WCBathRightFalse(4),Viewpoint.ori_WCBath(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(7),'scale',.095*ones(1,3))%Right_Hand_Scale_Rot(.095-->.195)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*163.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.22 2.12 -1.9548])%Right_Hand
setfield(object_nodes(9),'scale',.06*ones(1,3))%Left_Hand_Scale_Rot(.06-->.12)
setfield(object_nodes(9),'rotation',[-.036 -.9969 .0706 pi/180*82.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.2604 1.93 -1.06])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.06:(.12-.06)/15:.12%%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_WCBath',Viewpoint.pos_WCBathDoor']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_WCBath(1),Viewpoint.pos_WCBathDoor(1),L);
y_pos=linspace(Viewpoint.pos_WCBath(2),Viewpoint.pos_WCBathDoor(2),L);
z_pos=linspace(Viewpoint.pos_WCBath(3),Viewpoint.pos_WCBathDoor(3),L);
x_ori=linspace(Viewpoint.ori_WCBath(1),Viewpoint.ori_WCBathDoor(1),L);
y_ori=linspace(Viewpoint.ori_WCBath(2),Viewpoint.ori_WCBathDoor(2),L);
z_ori=linspace(Viewpoint.ori_WCBath(3),Viewpoint.ori_WCBathDoor(3),L);
rot_ori=linspace(Viewpoint.ori_WCBath(4),Viewpoint.ori_WCBathDoor(4),L);
for i=1:L
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
setfield(object_nodes(13),'on',0);%Spot_Light_toilet
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
setfield(object_nodes(1),'translation',[1.5091 1.2 .1014])%Station_front
setfield(object_nodes(3),'translation',[1.5091 1.2 -2.4665])%Station_Right
setfield(object_nodes(2),'translation',[1.5091 1.2 1.2203])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.085*ones(1,3))%Right_Hand_Scale_Rot(.085-->.17)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*113.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[4 1.87 -1.95])%Right_Hand
setfield(object_nodes(9),'scale',.065*ones(1,3))%Left_Hand_Scale_Rot(.065-->.136)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*126])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.46 1.71 -1.06])%Left_Hand
setfield(object_nodes(11),'scale',.019*ones(1,3))%Tennis_Shoe_Right(.019-->.038)
setfield(object_nodes(11),'rotation',[-.709 -.6976 .1037 pi/180*167.4])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[2.9489 1.74 -1.15])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.085:(.17-.085)/15:.17%right hand enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(4),'diffuseColor',[.8 .8 .01]);pause(eps)%Color_Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0.3 0]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from WCBathFalse to Salon
setfield(object_nodes(25),'on',0);%Spot_Light_diningtable
setfield(object_nodes(26),'on',1);%Spot_Light_salon
L=dist([Viewpoint.pos_WCBathFalse',Viewpoint.pos_Salon']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_WCBathFalse(1),Viewpoint.pos_Salon(1),L);
y_pos=linspace(Viewpoint.pos_WCBathFalse(2),Viewpoint.pos_Salon(2),L);
z_pos=linspace(Viewpoint.pos_WCBathFalse(3),Viewpoint.pos_Salon(3),L);
x_ori=linspace(Viewpoint.ori_WCBathFalse(1),Viewpoint.ori_Salon(1),L);
y_ori=linspace(Viewpoint.ori_WCBathFalse(2),-Viewpoint.ori_Salon(2),L);
z_ori=linspace(Viewpoint.ori_WCBathFalse(3),Viewpoint.ori_Salon(3),L);
rot_ori=linspace(Viewpoint.ori_WCBathFalse(4),-Viewpoint.ori_Salon(4)+6.283,L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(7),'scale',.065*ones(1,3))%Right_Hand_Scale_Rot(.065-->.13)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*163.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[2.7069 2.0517 -6.9441])%Right_Hand
setfield(object_nodes(9),'scale',.115*ones(1,3))%Left_Hand_Scale_Rot(.115-->.23)
setfield(object_nodes(9),'rotation',[-.036 -1 .0706 pi/180*69])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[2.1 2.03 -6.59])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.065:(.13-.065)/15:.13%right hand enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(27),'position',[Viewpoint.pos_SalonTrue(1) Viewpoint.pos_SalonTrue(2) Viewpoint.pos_SalonTrue(3)]);
    setfield(object_nodes(27),'orientation',[Viewpoint.ori_SalonTrue(1) Viewpoint.ori_SalonTrue(2) Viewpoint.ori_SalonTrue(3) Viewpoint.ori_SalonTrue(4)]);
    vrdrawnow
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[-.672 1.2 -11.5028])%Station_front
setfield(object_nodes(3),'translation',[2.8658 1.2 -10.6942])%Station_Right
setfield(object_nodes(2),'translation',[-1.32 1.2 -9.3428])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.065*ones(1,3))%Right_Hand_Scale_Rot(.065-->.13)
setfield(object_nodes(7),'rotation',[.0224 .9994 .0273 pi/180*163.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[2.7069 2.0517 -6.9441])%Right_Hand
setfield(object_nodes(9),'scale',.115*ones(1,3))%Left_Hand_Scale_Rot(.115-->.23)
setfield(object_nodes(9),'rotation',[-.036 -1 .0706 pi/180*69])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[2.1 2.03 -6.59])%Left_Hand
setfield(object_nodes(11),'scale',.007*ones(1,3))%Tennis_Shoe_Right(.007-->.0145)
setfield(object_nodes(11),'rotation',[.5971 .7212 .3502 pi/180*133.6037])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[2.35 2.23 -6.7212])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.065:(.13-.065)/15:.13%right hand enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(4),'diffuseColor',[.8 .8 .01]);pause(eps)%Color_Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0.3 0]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right

%% Navigation from SalonTrue to Salon_Right
L=dist([Viewpoint.pos_SalonRight',Viewpoint.pos_SalonTrue']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_SalonTrue(1),Viewpoint.pos_SalonRight(1),L);
y_pos=linspace(Viewpoint.pos_SalonTrue(2),Viewpoint.pos_SalonRight(2),L);
z_pos=linspace(Viewpoint.pos_SalonTrue(3),Viewpoint.pos_SalonRight(3),L);
x_ori=linspace(Viewpoint.ori_SalonTrue(1),Viewpoint.ori_SalonRight(1),L);
y_ori=linspace(-Viewpoint.ori_SalonTrue(2),Viewpoint.ori_SalonRight(2),L);
z_ori=linspace(Viewpoint.ori_SalonTrue(3),Viewpoint.ori_SalonRight(3),L);
rot_ori=linspace(-Viewpoint.ori_SalonTrue(4),Viewpoint.ori_SalonRight(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(7),'scale',.105*ones(1,3))%Right_Hand_Scale_Rot(.105-->.21)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*59.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.216 2.28 -10.03])%Right_Hand
setfield(object_nodes(9),'scale',.265*ones(1,3))%Left_Hand_Scale_Rot(.265-->.53)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*50])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[2.661 2.471 -11.3])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.265:(.53-.265)/15:.53%left enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_SalonRight',Viewpoint.pos_SalonRightFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_SalonRight(1),Viewpoint.pos_SalonRightFalse(1),L);
y_pos=linspace(Viewpoint.pos_SalonRight(2),Viewpoint.pos_SalonRightFalse(2),L);
z_pos=linspace(Viewpoint.pos_SalonRight(3),Viewpoint.pos_SalonRightFalse(3),L);
x_ori=linspace(Viewpoint.ori_SalonRight(1),Viewpoint.ori_SalonRightFalse(1),L);
y_ori=linspace(-Viewpoint.ori_SalonRight(2),Viewpoint.ori_SalonRightFalse(2),L);
z_ori=linspace(Viewpoint.ori_SalonRight(3),Viewpoint.ori_SalonRightFalse(3),L);
rot_ori=linspace(-Viewpoint.ori_SalonRight(4),Viewpoint.ori_SalonRightFalse(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[-.2354 1.2 -7.484])%Station_front
setfield(object_nodes(3),'translation',[-1.1354 1.2 -11.684])%Station_Right
setfield(object_nodes(2),'translation',[1.5646 1.2 -7.484])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.095*ones(1,3))%Right_Hand_Scale_Rot(.095-->.19)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*100.8])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[4.916 2.37 -11.87])%Right_Hand
setfield(object_nodes(9),'scale',.29*ones(1,3))%Left_Hand_Scale_Rot(.29-->.58)
setfield(object_nodes(9),'rotation',[0 1 0 -pi/180*156.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[4.679 2.6 -9.6])%Left_Hand
setfield(object_nodes(11),'scale',.031*ones(1,3))%Tennis_Shoe_Right(.031-->.062)
setfield(object_nodes(11),'rotation',[.6959 .6991 -.1642 -pi/180*158.4])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[3.3454 2.08 -10.5449])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.095:(.19-.095)/15:.19%left enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(4),'diffuseColor',[.8 .8 .01]);pause(eps)%Color_Station_right
    setfield(object_nodes(4),'emissiveColor',[ 0.3 .3 0]);pause(eps)%Color_Station_right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');    
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from Salon_Right to SalonFront
L=dist([Viewpoint.pos_SalonFront',Viewpoint.pos_SalonRightFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_SalonRightFalse(1),Viewpoint.pos_SalonFront(1),L);
y_pos=linspace(Viewpoint.pos_SalonRightFalse(2),Viewpoint.pos_SalonFront(2),L);
z_pos=linspace(Viewpoint.pos_SalonRightFalse(3),Viewpoint.pos_SalonFront(3),L);
x_ori=linspace(Viewpoint.ori_SalonRightFalse(1),Viewpoint.ori_SalonFront(1),L);
y_ori=linspace(Viewpoint.ori_SalonRightFalse(2),Viewpoint.ori_SalonFront(2),L);
z_ori=linspace(Viewpoint.ori_SalonRightFalse(3),Viewpoint.ori_SalonFront(3),L);
rot_ori=linspace(Viewpoint.ori_SalonRightFalse(4),Viewpoint.ori_SalonFront(4)-6.283,L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(7),'scale',.6*ones(1,3))%Right_Hand_Scale_Rot(.6-->1.2)
setfield(object_nodes(7),'rotation',[0 1 0 -pi/180*149.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[1.5 2.5 -12.66])%Right_Hand
setfield(object_nodes(9),'scale',.455*ones(1,3))%Left_Hand_Scale_Rot(.455-->.95)
setfield(object_nodes(9),'rotation',[0 -1 0 pi/180*30.6])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-2.6 2.2 -12])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.455:(.95-.455)/15:.95%left enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_SalonFront',Viewpoint.pos_SalonFrontFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_SalonFront(1),Viewpoint.pos_SalonFrontFalse(1),L);
y_pos=linspace(Viewpoint.pos_SalonFront(2),Viewpoint.pos_SalonFrontFalse(2),L);
z_pos=linspace(Viewpoint.pos_SalonFront(3),Viewpoint.pos_SalonFrontFalse(3),L);
x_ori=linspace(Viewpoint.ori_SalonFront(1),Viewpoint.ori_SalonFrontFalse(1),L);
y_ori=linspace(-Viewpoint.ori_SalonFront(2),Viewpoint.ori_SalonFrontFalse(2),L);
z_ori=linspace(Viewpoint.ori_SalonFront(3),Viewpoint.ori_SalonFrontFalse(3),L);
rot_ori=linspace(-Viewpoint.ori_SalonFront(4)+6.283,Viewpoint.ori_SalonFrontFalse(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[1.9486 1.2 -6.788])%Station_front
setfield(object_nodes(3),'translation',[-.8354 1.2 -7.484])%Station_Right
setfield(object_nodes(2),'translation',[3.1186 1.2 -10.415])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.155*ones(1,3))%Right_Hand_Scale_Rot(.155-->.31)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*16.2])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-2.579 1.88 -11.7])%Right_Hand
setfield(object_nodes(9),'scale',.335*ones(1,3))%Left_Hand_Scale_Rot(.335-->.67)
setfield(object_nodes(9),'rotation',[0 -1 0 -pi/180*99])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[.016 2.1 -12.1])%Left_Hand
setfield(object_nodes(11),'scale',.025*ones(1,3))%Tennis_Shoe_Right(.025-->.05)
setfield(object_nodes(11),'rotation',[-.3175 -.2752 .9075 pi/180*99.0467])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-1.446 1.55 -11.1])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.155:(.31-.155)/15:.31%right hand enlarging
        setfield(object_nodes(7),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    setfield(object_nodes(4),'diffuseColor',[.8 .8 .01]);pause(eps)%Color_Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0.3 0]);pause(eps)%Color_Station_right
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation from SalonFront to Salon_Left
L=dist([Viewpoint.pos_SalonLeft',Viewpoint.pos_SalonFrontFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_SalonFrontFalse(1),Viewpoint.pos_SalonLeft(1),L);
y_pos=linspace(Viewpoint.pos_SalonFrontFalse(2),Viewpoint.pos_SalonLeft(2),L);
z_pos=linspace(Viewpoint.pos_SalonFrontFalse(3),Viewpoint.pos_SalonLeft(3),L);
x_ori=linspace(Viewpoint.ori_SalonFrontFalse(1),Viewpoint.ori_SalonLeft(1),L);
y_ori=linspace(-Viewpoint.ori_SalonFrontFalse(2),Viewpoint.ori_SalonLeft(2),L);
z_ori=linspace(Viewpoint.ori_SalonFrontFalse(3),Viewpoint.ori_SalonLeft(3),L);
rot_ori=linspace(-Viewpoint.ori_SalonFrontFalse(4),Viewpoint.ori_SalonLeft(4)-6.283,L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(7),'scale',.115*ones(1,3))%Right_Hand_Scale_Rot(.115-->.23)
setfield(object_nodes(7),'rotation',[0 1 0 pi/180*32.4])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-1.08 1.36 -8.9])%Right_Hand
setfield(object_nodes(9),'scale',.34*ones(1,3))%Left_Hand_Scale_Rot(.34-->.68)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*145.8])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[1.1 1.66 -7.1173])%Left_Hand
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    for i=.34:(.68-.34)/15:.68%left hand enlarging
        setfield(object_nodes(9),'scale',i*ones(1,3));pause(eps)%left_Hand_Scale_Rot(.77-->1.6)
    end
    vrdrawnow;pause(1)
    % setting stations to default color and position
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
L=dist([Viewpoint.pos_SalonLeft',Viewpoint.pos_SalonLeftFalse']);
L=L(1,2)/.034;
x_pos=linspace(Viewpoint.pos_SalonLeft(1),Viewpoint.pos_SalonLeftFalse(1),L);
y_pos=linspace(Viewpoint.pos_SalonLeft(2),Viewpoint.pos_SalonLeftFalse(2),L);
z_pos=linspace(Viewpoint.pos_SalonLeft(3),Viewpoint.pos_SalonLeftFalse(3),L);
x_ori=linspace(Viewpoint.ori_SalonLeft(1),Viewpoint.ori_SalonLeftFalse(1),L);
y_ori=linspace(Viewpoint.ori_SalonLeft(2),Viewpoint.ori_SalonLeftFalse(2),L);
z_ori=linspace(Viewpoint.ori_SalonLeft(3),Viewpoint.ori_SalonLeftFalse(3),L);
rot_ori=linspace(Viewpoint.ori_SalonLeft(4),Viewpoint.ori_SalonLeftFalse(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
setfield(object_nodes(1),'translation',[3.1646 1.2 -9.584])%Station_front
setfield(object_nodes(3),'translation',[1.4646 1.2 -7.784])%Station_Right
setfield(object_nodes(2),'translation',[.1646  1.2 -11.784])%Station_Left
vrdrawnow;pause(1)
setfield(object_nodes(7),'scale',.155*ones(1,3))%Right_Hand_Scale_Rot(.155-->.31)
setfield(object_nodes(7),'rotation',[0 -1 0 pi/180*93.6])%Right_Hand_Scale_Rot
setfield(object_nodes(8),'translation',[-1 2.16 -7.53])%Right_Hand
setfield(object_nodes(9),'scale',.295*ones(1,3))%Left_Hand_Scale_Rot(.295-->.59)
setfield(object_nodes(9),'rotation',[0 1 0 pi/180*27])%Left_Hand_Scale_Rot
setfield(object_nodes(10),'translation',[-1 2.3 -9.4093])%Left_Hand
setfield(object_nodes(11),'scale',.03*ones(1,3))%Tennis_Shoe_Right(.03-->.06)
setfield(object_nodes(11),'rotation',[.3477 .3243 .8798 pi/180*96.6378])%Tennis_Shoe_Right
setfield(object_nodes(11),'translation',[-.2434 1.75 -8.5])%Tennis_Shoe_Right
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
vrdrawnow;pause(3)
    % setting stations to default color and position
    setfield(object_nodes(1),'translation',[2.35 -10 6])%Station_front
    setfield(object_nodes(2),'translation',[0 -10 9])%Station_Left
    setfield(object_nodes(3),'translation',[5 -10 10])%Station_right
    setfield(object_nodes(8),'translation',[5.72 -10 10])%Right_Hand
    setfield(object_nodes(10),'translation',[-.7 -10 10])%Left_Hand
    setfield(object_nodes(11),'translation',[2.49 -10 13])%Tennis_Shoe_Right
    setfield(object_nodes(4),'diffuseColor',[1 0 0])%Station_front
    setfield(object_nodes(5),'diffuseColor',[1 0 0])%Station_Left
    setfield(object_nodes(6),'diffuseColor',[1 0 0])%Station_right
    setfield(object_nodes(4),'emissiveColor',[.3 0 0])%Station_front
    setfield(object_nodes(5),'emissiveColor',[.3 0 0])%Station_Left
    setfield(object_nodes(6),'emissiveColor',[.3 0 0])%Station_right
%% Navigation to first place
setfield(object_nodes(26),'on',0);%Spot_Light_salon
setfield(object_nodes(14),'on',1);%Spot_Light_inputdoor
setfield(object_nodes(15),'on',1);%Spot_Light_Left3
setfield(object_nodes(16),'on',1);%Spot_Light_Left2
setfield(object_nodes(17),'on',1);%Spot_Light_Left1
setfield(object_nodes(18),'on',1);%Spot_Light_Right1
setfield(object_nodes(19),'on',1);%Spot_Light_Right2
setfield(object_nodes(21),'on',1);%Spot_Light_Right3
setfield(object_nodes(22),'on',1);%Spot_Light_Front
L=100;
x_pos=linspace(Viewpoint.pos_SalonLeftFalse(1),Viewpoint.pos_SalonTrue(1),L);
y_pos=linspace(Viewpoint.pos_SalonLeftFalse(2),Viewpoint.pos_SalonTrue(2),L);
z_pos=linspace(Viewpoint.pos_SalonLeftFalse(3),Viewpoint.pos_SalonTrue(3),L);
x_ori=linspace(Viewpoint.ori_SalonLeftFalse(1),Viewpoint.ori_SalonTrue(1),L);
y_ori=linspace(Viewpoint.ori_SalonLeftFalse(2),Viewpoint.ori_SalonTrue(2),L);
z_ori=linspace(Viewpoint.ori_SalonLeftFalse(3),Viewpoint.ori_SalonTrue(3),L);
rot_ori=linspace(Viewpoint.ori_SalonLeftFalse(4)-6.283,Viewpoint.ori_SalonTrue(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
% Navigation from SalonTrue to Bed_Bath_Door
L=100;
x_pos=linspace(Viewpoint.pos_SalonTrue(1),Viewpoint.pos_BedBathDoor(1),L);
y_pos=linspace(Viewpoint.pos_SalonTrue(2),Viewpoint.pos_BedBathDoor(2),L);
z_pos=linspace(Viewpoint.pos_SalonTrue(3),Viewpoint.pos_BedBathDoor(3),L);
x_ori=linspace(Viewpoint.ori_SalonTrue(1),Viewpoint.ori_BedBathDoor(1),L);
y_ori=linspace(Viewpoint.ori_SalonTrue(2),Viewpoint.ori_BedBathDoor(2),L);
z_ori=linspace(Viewpoint.ori_SalonTrue(3),Viewpoint.ori_BedBathDoor(3),L);
rot_ori=linspace(Viewpoint.ori_SalonTrue(4),Viewpoint.ori_BedBathDoor(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
% Navigation from Bed_Bath_Door to Input_Door
L=100;
x_pos=linspace(Viewpoint.pos_BedBathDoor(1),Viewpoint.pos_InputDoor(1),L);
y_pos=linspace(Viewpoint.pos_BedBathDoor(2),Viewpoint.pos_InputDoor(2),L);
z_pos=linspace(Viewpoint.pos_BedBathDoor(3),Viewpoint.pos_InputDoor(3),L);
x_ori=linspace(Viewpoint.ori_BedBathDoor(1),Viewpoint.ori_InputDoor(1),L);
y_ori=linspace(-Viewpoint.ori_BedBathDoor(2),Viewpoint.ori_InputDoor(2),L);
z_ori=linspace(Viewpoint.ori_BedBathDoor(3),Viewpoint.ori_InputDoor(3),L);
rot_ori=linspace(-Viewpoint.ori_BedBathDoor(4),Viewpoint.ori_InputDoor(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
% Navigation from Input_Door to OutFront
L=100;
x_pos=linspace(Viewpoint.pos_InputDoor(1),Viewpoint.pos_OutFront(1),L);
y_pos=linspace(Viewpoint.pos_InputDoor(2),Viewpoint.pos_OutFront(2),L);
z_pos=linspace(Viewpoint.pos_InputDoor(3),Viewpoint.pos_OutFront(3),L);
x_ori=linspace(Viewpoint.ori_InputDoor(1),Viewpoint.ori_OutFront(1),L);
y_ori=linspace(Viewpoint.ori_InputDoor(2),-Viewpoint.ori_OutFront(2),L);
z_ori=linspace(Viewpoint.ori_InputDoor(3),Viewpoint.ori_OutFront(3),L);
rot_ori=linspace(Viewpoint.ori_InputDoor(4),-Viewpoint.ori_OutFront(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
% Navigation from OutFront to FrontTop
L=100;
x_pos=linspace(Viewpoint.pos_OutFront(1),Viewpoint.pos_FrontTop(1),L);
y_pos=linspace(Viewpoint.pos_OutFront(2),Viewpoint.pos_FrontTop(2),L);
z_pos=linspace(Viewpoint.pos_OutFront(3),Viewpoint.pos_FrontTop(3),L);
x_ori=linspace(Viewpoint.ori_OutFront(1),Viewpoint.ori_FrontTop(1),L);
y_ori=linspace(-Viewpoint.ori_OutFront(2),Viewpoint.ori_FrontTop(2),L);
z_ori=linspace(Viewpoint.ori_OutFront(3),Viewpoint.ori_FrontTop(3),L);
rot_ori=linspace(-Viewpoint.ori_OutFront(4),Viewpoint.ori_FrontTop(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');










