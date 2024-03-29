
/* #Typive
$[
	1.063,
	["settings",[["safezoneX","safezoneY","0","0"],"2.5 * pixelW * pixelGrid","2.5 * pixelH * pixelGrid","UI_GRID"],0,0,0],
	[1900,"ViewDistPlane",[2,"",["27.5 * UI_GRID_W + UI_GRID_X","8 * UI_GRID_H + UI_GRID_Y","16.5 * UI_GRID_W","2 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[2,"Airplane View Distance",["17 * UI_GRID_W + UI_GRID_X","8.5 * UI_GRID_H + UI_GRID_Y","10 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[2,"Helicopter View Distance",["17 * UI_GRID_W + UI_GRID_X","11.5 * UI_GRID_H + UI_GRID_Y","10 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[2,"Ground View Distance",["17 * UI_GRID_W + UI_GRID_X","14.5 * UI_GRID_H + UI_GRID_Y","10 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1901,"ViewDistHeli",[2,"",["27.5 * UI_GRID_W + UI_GRID_X","11 * UI_GRID_H + UI_GRID_Y","16.5 * UI_GRID_W","2 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1902,"ViewDistGround",[2,"",["27.5 * UI_GRID_W + UI_GRID_X","14 * UI_GRID_H + UI_GRID_Y","16.5 * UI_GRID_W","2 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[2,"Apply",["40 * UI_GRID_W + UI_GRID_X","26 * UI_GRID_H + UI_GRID_Y","7.5 * UI_GRID_W","3.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |true call settingsClose|;"]],
	[1003,"ViewDistPlaneNum",[2,"10000",["44.5 * UI_GRID_W + UI_GRID_X","8 * UI_GRID_H + UI_GRID_Y","6.5 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"ViewDistHeliNum",[2,"10000",["44.5 * UI_GRID_W + UI_GRID_X","11 * UI_GRID_H + UI_GRID_Y","6.5 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1005,"ViewDistGroundNum",[2,"10000",["44.5 * UI_GRID_W + UI_GRID_X","14 * UI_GRID_H + UI_GRID_Y","6.5 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1006,"",[2,"overallVisibility",["33 * UI_GRID_W + UI_GRID_X","6 * UI_GRID_H + UI_GRID_Y","14 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2800,"",[2,"",["15.5 * UI_GRID_W + UI_GRID_X","5.5 * UI_GRID_H + UI_GRID_Y","2 * UI_GRID_W","2 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1007,"",[2,"Use custom view distance",["18 * UI_GRID_W + UI_GRID_X","6 * UI_GRID_H + UI_GRID_Y","10 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"",[2,"",["15.5 * UI_GRID_W + UI_GRID_X","7.5 * UI_GRID_H + UI_GRID_Y","33 * UI_GRID_W","9 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"",[2,"Cancel",["16.5 * UI_GRID_W + UI_GRID_X","26 * UI_GRID_H + UI_GRID_Y","7.5 * UI_GRID_W","3.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |false call settingsClose|;"]]
]
*/











class SettingsDlg
{
 idd = 1234567;

 movingEnable = false;

 //onLoad = "";
 //onUnload = "";

 class controlsBackground
 {

 	class Background : IGUIBack
    {
	idc = 3700;
	
	x = 15 * UI_GRID_W + UI_GRID_X;
	y = 5.5 * UI_GRID_H + UI_GRID_Y;
	w = 34 * UI_GRID_W;
	h = 25.5 * UI_GRID_H;
	
	moving = false;

	colorBackground[] = {0,0,1,1};
	
    };
 
 };
	
 class objects 
 {
 };
	
	
class controls 
{

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by GC, v1.063, #Typive)
////////////////////////////////////////////////////////

class ViewDistPlane: RscSlider
{
	idc = 1900;
	x = 27.5 * UI_GRID_W + UI_GRID_X;
	y = 8 * UI_GRID_H + UI_GRID_Y;
	w = 16.5 * UI_GRID_W;
	h = 2 * UI_GRID_H;
};
class RscText_1000: RscText
{
	idc = 1000;
	text = "Airplane View Distance"; //--- ToDo: Localize;
	x = 17 * UI_GRID_W + UI_GRID_X;
	y = 8.5 * UI_GRID_H + UI_GRID_Y;
	w = 10 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1001: RscText
{
	idc = 1001;
	text = "Helicopter View Distance"; //--- ToDo: Localize;
	x = 17 * UI_GRID_W + UI_GRID_X;
	y = 11.5 * UI_GRID_H + UI_GRID_Y;
	w = 10 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1002: RscText
{
	idc = 1002;
	text = "Ground View Distance"; //--- ToDo: Localize;
	x = 17 * UI_GRID_W + UI_GRID_X;
	y = 14.5 * UI_GRID_H + UI_GRID_Y;
	w = 10 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class ViewDistHeli: RscSlider
{
	idc = 1901;
	x = 27.5 * UI_GRID_W + UI_GRID_X;
	y = 11 * UI_GRID_H + UI_GRID_Y;
	w = 16.5 * UI_GRID_W;
	h = 2 * UI_GRID_H;
};
class ViewDistGround: RscSlider
{
	idc = 1902;
	x = 27.5 * UI_GRID_W + UI_GRID_X;
	y = 14 * UI_GRID_H + UI_GRID_Y;
	w = 16.5 * UI_GRID_W;
	h = 2 * UI_GRID_H;
};
class RscButton_1600: RscButton
{
	action = "true call settingsClose";

	idc = 1600;
	text = "Apply"; //--- ToDo: Localize;
	x = 40 * UI_GRID_W + UI_GRID_X;
	y = 26 * UI_GRID_H + UI_GRID_Y;
	w = 7.5 * UI_GRID_W;
	h = 3.5 * UI_GRID_H;
};
class ViewDistPlaneNum: RscText
{
	idc = 1003;
	text = "10000"; //--- ToDo: Localize;
	x = 44.5 * UI_GRID_W + UI_GRID_X;
	y = 8 * UI_GRID_H + UI_GRID_Y;
	w = 6.5 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class ViewDistHeliNum: RscText
{
	idc = 1004;
	text = "10000"; //--- ToDo: Localize;
	x = 44.5 * UI_GRID_W + UI_GRID_X;
	y = 11 * UI_GRID_H + UI_GRID_Y;
	w = 6.5 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class ViewDistGroundNum: RscText
{
	idc = 1005;
	text = "10000"; //--- ToDo: Localize;
	x = 44.5 * UI_GRID_W + UI_GRID_X;
	y = 14 * UI_GRID_H + UI_GRID_Y;
	w = 6.5 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1006: RscText
{
	idc = 1006;
	text = "overallVisibility"; //--- ToDo: Localize;
	x = 33 * UI_GRID_W + UI_GRID_X;
	y = 6 * UI_GRID_H + UI_GRID_Y;
	w = 14 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscCheckbox_2800: RscCheckbox
{
	idc = 2800;
	x = 15.5 * UI_GRID_W + UI_GRID_X;
	y = 5.5 * UI_GRID_H + UI_GRID_Y;
	w = 2 * UI_GRID_W;
	h = 2 * UI_GRID_H;
};
class RscText_1007: RscText
{
	idc = 1007;
	text = "Use custom view distance"; //--- ToDo: Localize;
	x = 18 * UI_GRID_W + UI_GRID_X;
	y = 6 * UI_GRID_H + UI_GRID_Y;
	w = 10 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscFrame_1800: RscFrame
{
	idc = 1800;
	x = 15.5 * UI_GRID_W + UI_GRID_X;
	y = 7.5 * UI_GRID_H + UI_GRID_Y;
	w = 33 * UI_GRID_W;
	h = 9 * UI_GRID_H;
};
class RscButton_1601: RscButton
{
	action = "false call settingsClose";

	idc = 1601;
	text = "Cancel"; //--- ToDo: Localize;
	x = 16.5 * UI_GRID_W + UI_GRID_X;
	y = 26 * UI_GRID_H + UI_GRID_Y;
	w = 7.5 * UI_GRID_W;
	h = 3.5 * UI_GRID_H;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////





};

};