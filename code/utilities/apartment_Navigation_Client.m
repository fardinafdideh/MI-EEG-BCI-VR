% clear;%Clear variables and functions from memory.
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
% set(vrfigure_object,'Fullscreen','on');
% pause(eps)
set(vrfigure_object,'Position',[0 79 696 696*768/1366]);%Set object properties.
% vrfigure_object.Position
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
%% Apartment tour
reload(myworld);%Load the most recently used program file into the target.
set(vrfigure_object,'Headlight','off');pause(eps)
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');pause(1)
% Navigation from FrontTop to OutFront(test)
L=100;
x_pos=linspace(Viewpoint.pos_FrontTop(1),Viewpoint.pos_OutFront(1),L);
y_pos=linspace(Viewpoint.pos_FrontTop(2),Viewpoint.pos_OutFront(2),L);
z_pos=linspace(Viewpoint.pos_FrontTop(3),Viewpoint.pos_OutFront(3),L);
x_ori=linspace(Viewpoint.ori_FrontTop(1),Viewpoint.ori_OutFront(1),L);
y_ori=linspace(-Viewpoint.ori_FrontTop(2),Viewpoint.ori_OutFront(2),L);
z_ori=linspace(Viewpoint.ori_FrontTop(3),Viewpoint.ori_OutFront(3),L);
rot_ori=linspace(-Viewpoint.ori_FrontTop(4),Viewpoint.ori_OutFront(4),L);
for i=1:L
    setfield(object_nodes(27),'position',[x_pos(i) y_pos(i) z_pos(i)]);
    setfield(object_nodes(27),'orientation',[x_ori(i) y_ori(i) z_ori(i) rot_ori(i)]);
    vrdrawnow
end
set(vrfigure_object,'Viewpoint','Subject_Viewpoint');
% Navigation from FrontTop to OutFront
if isRealEEG
L=100;
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
pause(5)
end
%% moving to StartStation
if StartStation==1
    StartStation='OutFront';
elseif StartStation==2
    StartStation='OutRight';
elseif StartStation==3
    StartStation='OutLeft';
elseif StartStation==4
    StartStation='InputDoor';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(25),'on',1)%Spot_Light_diningtable
elseif StartStation==5
    StartStation='Kitchen';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(24),'on',1)%Spot_Light_Kitchen
elseif StartStation==6
    StartStation='KitchenRight';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(24),'on',1)%Spot_Light_Kitchen
elseif StartStation==7
    StartStation='KitchenLeft';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(24),'on',1)%Spot_Light_Kitchen
elseif StartStation==8
    StartStation='KitchenFront';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(24),'on',1)%Spot_Light_Kitchen
elseif StartStation==9
    StartStation='DiningTable';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(25),'on',1)%Spot_Light_DiningTable
elseif StartStation==10
    StartStation='BedBathDoor';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(25),'on',1)%Spot_Light_DiningTable
elseif StartStation==11
    StartStation='Bedroom';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(23),'on',1)%Spot_Light_Bedroom
elseif StartStation==12
    StartStation='BedroomRight';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(23),'on',1)%Spot_Light_Bedroom
elseif StartStation==13
    StartStation='BedroomLeft';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(23),'on',1)%Spot_Light_Bedroom
elseif StartStation==14
    StartStation='BedroomFront';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(23),'on',1)%Spot_Light_Bedroom
elseif StartStation==15
    StartStation='WCBath';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(13),'on',1)%Spot_Light_WCBath
elseif StartStation==16
    StartStation='WCBathRight';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(13),'on',1)%Spot_Light_WCBath
elseif StartStation==17
    StartStation='WCBathLeft';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(13),'on',1)%Spot_Light_WCBath
elseif StartStation==18
    StartStation='WCBathFront';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(13),'on',1)%Spot_Light_WCBath
elseif StartStation==19
    StartStation='Salon';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(26),'on',1)%Spot_Light_Salon
elseif StartStation==20
    StartStation='SalonRight';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(26),'on',1)%Spot_Light_Salon
elseif StartStation==21
    StartStation='SalonLeft';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(26),'on',1)%Spot_Light_Salon
elseif StartStation==22
    StartStation='SalonFront';
    setfield(object_nodes(15),'on',0)%Spot_Light_Left3
    setfield(object_nodes(16),'on',0)%Spot_Light_Left2
    setfield(object_nodes(17),'on',0)%Spot_Light_Left1
    setfield(object_nodes(18),'on',0)%Spot_Light_Right1
    setfield(object_nodes(19),'on',0)%Spot_Light_Right2
    setfield(object_nodes(21),'on',0)%Spot_Light_Right3
    setfield(object_nodes(14),'on',0)%Spot_Light_inputdoor
    setfield(object_nodes(26),'on',1)%Spot_Light_Salon
end
eval(['setfield(object_nodes(27),''position'',[Viewpoint.pos_',StartStation,'(1) Viewpoint.pos_',StartStation,'(2) Viewpoint.pos_',StartStation,'(3)]);'])
eval(['setfield(object_nodes(27),''orientation'',[Viewpoint.ori_',StartStation,'(1) Viewpoint.ori_',StartStation,'(2) Viewpoint.ori_',StartStation,'(3) Viewpoint.ori_',StartStation,'(4)]);'])
vrdrawnow
%%
class_ind=1; % the index of the Class*.mat that is going to be loaded in VR WS (saved by BCI WS), that contains C
k=1; % The index in C (when Class*.mat is loaded) that its value enlarges the hands and shoes objects in VR WS
class_ind_inc=3; % Each class_ind_inc the Class*.mat (saved by BCI WS) is loaded. No need to load consecutive Class*.mats
del_ind=1;

SubjectRouteCounter=1;
stretch=40;%exe=40
Navigation_Time=tic;
while Navigation
    if sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_OutFront)==3% OutFront
        Subject_Route(1,SubjectRouteCounter)=1;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_OutFront
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_OutRight)==3% OutRight
        Subject_Route(1,SubjectRouteCounter)=2;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_OutRight
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_OutLeft)==3% OutLeft
        Subject_Route(1,SubjectRouteCounter)=3;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_OutLeft
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_InputDoor)==3% InputDoor
        Subject_Route(1,SubjectRouteCounter)=4;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_InputDoor
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_Kitchen)==3% Kitchen
        Subject_Route(1,SubjectRouteCounter)=5;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_Kitchen
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_KitchenTrue)==3% KitchenTrue
        Subject_Route(1,SubjectRouteCounter)=5;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_KitchenTrue
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_KitchenFalse)==3% KitchenFalse
        Subject_Route(1,SubjectRouteCounter)=5;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_KitchenFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_KitchenRight)==3% Kitchen_Right
        Subject_Route(1,SubjectRouteCounter)=6;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_KitchenRight
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_KitchenRightFalse)==3% Kitchen_RightFalse
        Subject_Route(1,SubjectRouteCounter)=6;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_KitchenRightFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_KitchenLeft)==3% Kitchen_Left
        Subject_Route(1,SubjectRouteCounter)=7;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_KitchenLeft
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_KitchenLeftFalse)==3% Kitchen_LeftFalse
        Subject_Route(1,SubjectRouteCounter)=7;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_KitchenLeftFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_KitchenFront)==3% Kitchen_Front
        Subject_Route(1,SubjectRouteCounter)=8;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_KitchenFront
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_KitchenFrontFalse)==3% Kitchen_FrontFalse
        Subject_Route(1,SubjectRouteCounter)=8;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_KitchenFrontFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_DiningTable)==3% DiningTable
        Subject_Route(1,SubjectRouteCounter)=9;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_DiningTable
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_DiningTableFalse)==3% DiningTableFalse
        Subject_Route(1,SubjectRouteCounter)=9;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_DiningTableFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_BedBathDoor)==3% BedBathDoor
        Subject_Route(1,SubjectRouteCounter)=10;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_BedBathDoor
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_BedBathDoorTrue)==3% BedBathDoorTrue
        Subject_Route(1,SubjectRouteCounter)=10;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_BedBathDoorTrue
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_BedBathDoorFalse)==3% BedBathDoorFalse
        Subject_Route(1,SubjectRouteCounter)=10;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_BedBathDoorFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_Bedroom)==3% Bedroom
        Subject_Route(1,SubjectRouteCounter)=11;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_Bedroom
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_BedroomTrue)==3% BedroomTrue
        Subject_Route(1,SubjectRouteCounter)=11;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_BedroomTrue
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_BedroomFalse)==3% BedroomFalse
        Subject_Route(1,SubjectRouteCounter)=23;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_BedroomFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_BedroomRight)==3% BedroomRight
        Subject_Route(1,SubjectRouteCounter)=12;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_BedroomRight
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_BedroomRightFalse)==3% BedroomRightFalse
        Subject_Route(1,SubjectRouteCounter)=12;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_BedroomRightFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_BedroomLeft)==3% BedroomLeft
        Subject_Route(1,SubjectRouteCounter)=13;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_BedroomLeft
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_BedroomLeftFalse)==3% BedroomLeftFalse
        Subject_Route(1,SubjectRouteCounter)=13;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_BedroomLeftFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_BedroomFront)==3% BedroomFront
        Subject_Route(1,SubjectRouteCounter)=14;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_BedroomFront
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_BedroomFrontFalse)==3% BedroomFrontFalse
        Subject_Route(1,SubjectRouteCounter)=14;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_BedroomFrontFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_WCBath)==3% WCBath
        Subject_Route(1,SubjectRouteCounter)=15;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_WCBath
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_WCBathTrue)==3% WCBathTrue
        Subject_Route(1,SubjectRouteCounter)=15;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_WCBathTrue
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_WCBathFalse)==3% WCBathFalse
        Subject_Route(1,SubjectRouteCounter)=9;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_WCBathFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_WCBathRight)==3% WCBathRight
        Subject_Route(1,SubjectRouteCounter)=16;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_WCBathRight
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_WCBathRightFalse)==3% WCBathRightFalse
        Subject_Route(1,SubjectRouteCounter)=16;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_WCBathRightFalse
       del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_WCBathLeft)==3% WCBathLeft
        Subject_Route(1,SubjectRouteCounter)=17;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_WCBathLeft
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_WCBathLeftFalse)==3% WCBathLeftFalse
        Subject_Route(1,SubjectRouteCounter)=17;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_WCBathLeftFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_WCBathFront)==3% WCBathFront
        Subject_Route(1,SubjectRouteCounter)=18;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_WCBathFront
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_WCBathFrontFalse)==3% WCBathFrontFalse
        Subject_Route(1,SubjectRouteCounter)=18;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_WCBathFrontFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_Salon)==3% Salon
        Subject_Route(1,SubjectRouteCounter)=19;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_Salon
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_SalonTrue)==3% SalonTrue
        Subject_Route(1,SubjectRouteCounter)=19;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_SalonTrue
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_SalonFalse)==3% SalonFalse
        Subject_Route(1,SubjectRouteCounter)=19;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_SalonFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_SalonLeft)==3% SalonLeft
        Subject_Route(1,SubjectRouteCounter)=21;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_SalonLeft
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_SalonLeftFalse)==3% SalonLeftFalse
        Subject_Route(1,SubjectRouteCounter)=21;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_SalonLeftFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_SalonRight)==3% SalonRight
        Subject_Route(1,SubjectRouteCounter)=20;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_SalonRight
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_SalonRightFalse)==3% SalonRightFalse
        Subject_Route(1,SubjectRouteCounter)=20;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_SalonRightFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_SalonFront)==3% SalonFront
        Subject_Route(1,SubjectRouteCounter)=22;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_SalonFront
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    elseif sum(get(vrfigure_object,'CameraPositionAbs')==Viewpoint.pos_SalonFrontFalse)==3% SalonFrontFalse
        Subject_Route(1,SubjectRouteCounter)=22;
        SubjectRouteCounter=SubjectRouteCounter+1;
        apartment_Navigation_Client_SalonFrontFalse
        del_ind = deleteClass(sharePath, del_ind,class_ind,class_ind_inc);
    end
end
Navigation_Time=toc(Navigation_Time);
