
/* #Kifedi
$[
	1.063,
	["settings",[["safezoneX","safezoneY","0","0"],"2.5 * pixelW * pixelGrid","2.5 * pixelH * pixelGrid","UI_GRID"],0,0,0],
	[1900,"ViewDistPlane",[2,"",["27.5 * UI_GRID_W + UI_GRID_X","6.5 * UI_GRID_H + UI_GRID_Y","16.5 * UI_GRID_W","2 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[2,"Airplane View Distance",["16.5 * UI_GRID_W + UI_GRID_X","6.5 * UI_GRID_H + UI_GRID_Y","10 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[2,"Helicopter View Distance",["16.5 * UI_GRID_W + UI_GRID_X","9.5 * UI_GRID_H + UI_GRID_Y","10 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[2,"Ground View Distance",["17 * UI_GRID_W + UI_GRID_X","12 * UI_GRID_H + UI_GRID_Y","10 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1901,"ViewDistHeli",[2,"",["27.5 * UI_GRID_W + UI_GRID_X","9 * UI_GRID_H + UI_GRID_Y","16.5 * UI_GRID_W","2 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1902,"ViewDistGround",[2,"",["27.5 * UI_GRID_W + UI_GRID_X","11.5 * UI_GRID_H + UI_GRID_Y","16.5 * UI_GRID_W","2 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[2,"Close",["41 * UI_GRID_W + UI_GRID_X","27 * UI_GRID_H + UI_GRID_Y","7.5 * UI_GRID_W","3.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |true call settingsClose|;"]],
	[1003,"ViewDistPlaneNum",[2,"10000",["45 * UI_GRID_W + UI_GRID_X","6.5 * UI_GRID_H + UI_GRID_Y","6.5 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"ViewDistHeliNum",[2,"10000",["45 * UI_GRID_W + UI_GRID_X","9 * UI_GRID_H + UI_GRID_Y","6.5 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1005,"ViewDistGroundNum",[2,"10000",["45 * UI_GRID_W + UI_GRID_X","11.5 * UI_GRID_H + UI_GRID_Y","6.5 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
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
// GUI EDITOR OUTPUT START (by GC, v1.063, #Kifedi)
////////////////////////////////////////////////////////

class ViewDistPlane: RscSlider
{
	idc = 1900;
	x = 27.5 * UI_GRID_W + UI_GRID_X;
	y = 6.5 * UI_GRID_H + UI_GRID_Y;
	w = 16.5 * UI_GRID_W;
	h = 2 * UI_GRID_H;
};
class RscText_1000: RscText
{
	idc = 1000;
	text = "Airplane View Distance"; //--- ToDo: Localize;
	x = 16.5 * UI_GRID_W + UI_GRID_X;
	y = 6.5 * UI_GRID_H + UI_GRID_Y;
	w = 10 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1001: RscText
{
	idc = 1001;
	text = "Helicopter View Distance"; //--- ToDo: Localize;
	x = 16.5 * UI_GRID_W + UI_GRID_X;
	y = 9.5 * UI_GRID_H + UI_GRID_Y;
	w = 10 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1002: RscText
{
	idc = 1002;
	text = "Ground View Distance"; //--- ToDo: Localize;
	x = 17 * UI_GRID_W + UI_GRID_X;
	y = 12 * UI_GRID_H + UI_GRID_Y;
	w = 10 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class ViewDistHeli: RscSlider
{
	idc = 1901;
	x = 27.5 * UI_GRID_W + UI_GRID_X;
	y = 9 * UI_GRID_H + UI_GRID_Y;
	w = 16.5 * UI_GRID_W;
	h = 2 * UI_GRID_H;
};
class ViewDistGround: RscSlider
{
	idc = 1902;
	x = 27.5 * UI_GRID_W + UI_GRID_X;
	y = 11.5 * UI_GRID_H + UI_GRID_Y;
	w = 16.5 * UI_GRID_W;
	h = 2 * UI_GRID_H;
};
class RscButton_1600: RscButton
{
	action = "true call settingsClose";

	idc = 1600;
	text = "Close"; //--- ToDo: Localize;
	x = 41 * UI_GRID_W + UI_GRID_X;
	y = 27 * UI_GRID_H + UI_GRID_Y;
	w = 7.5 * UI_GRID_W;
	h = 3.5 * UI_GRID_H;
};
class ViewDistPlaneNum: RscText
{
	idc = 1003;
	text = "10000"; //--- ToDo: Localize;
	x = 45 * UI_GRID_W + UI_GRID_X;
	y = 6.5 * UI_GRID_H + UI_GRID_Y;
	w = 6.5 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class ViewDistHeliNum: RscText
{
	idc = 1004;
	text = "10000"; //--- ToDo: Localize;
	x = 45 * UI_GRID_W + UI_GRID_X;
	y = 9 * UI_GRID_H + UI_GRID_Y;
	w = 6.5 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class ViewDistGroundNum: RscText
{
	idc = 1005;
	text = "10000"; //--- ToDo: Localize;
	x = 45 * UI_GRID_W + UI_GRID_X;
	y = 11.5 * UI_GRID_H + UI_GRID_Y;
	w = 6.5 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////





};

};