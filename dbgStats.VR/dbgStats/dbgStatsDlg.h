/* #Javuki
$[
	1.063,
	["dbgStats",[["safezoneX","safezoneY","safezoneW","safeZoneH"],"5 * 0.5 * pixelW * pixelGrid","5 * 0.5 * pixelH * pixelGrid","UI_GRID"],0,0,0],
	[1800,"",[2,"Side",["16 * UI_GRID_W + UI_GRID_X","8 * UI_GRID_H + UI_GRID_Y","22 * UI_GRID_W","4.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"",[2,"All",["16 * UI_GRID_W + UI_GRID_X","14.5 * UI_GRID_H + UI_GRID_Y","16 * UI_GRID_W","14.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"UsedArmyBar : RscProgress",[2,"#(argb,8,8,3)color(1,1,1,1)",["16.5 * UI_GRID_W + UI_GRID_X","10.5 * UI_GRID_H + UI_GRID_Y","11 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[2,"Close",["29 * UI_GRID_W + UI_GRID_X","30 * UI_GRID_H + UI_GRID_Y","6 * UI_GRID_W","2 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |call closeDbgStatsDlg|;"]],
	[1000,"",[2,"Response time",["27.5 * UI_GRID_W + UI_GRID_X","6 * UI_GRID_H + UI_GRID_Y","11.5 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[2,"0 / 0",["18 * UI_GRID_W + UI_GRID_X","9 * UI_GRID_H + UI_GRID_Y","9 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[2,"Num men spawned: 0",["17 * UI_GRID_W + UI_GRID_X","19.5 * UI_GRID_H + UI_GRID_Y","10 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"",[2,"Total groups: 0",["17 * UI_GRID_W + UI_GRID_X","15.5 * UI_GRID_H + UI_GRID_Y","7.5 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"",[2,"Num veh spawned: 0",["17 * UI_GRID_W + UI_GRID_X","21 * UI_GRID_H + UI_GRID_Y","10 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"",[2,"",["28.5 * UI_GRID_W + UI_GRID_X","10 * UI_GRID_H + UI_GRID_Y","9 * UI_GRID_W","1.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["onLBSelChanged = |call dbgSelectSide|;"]],
	[1005,"",[2,"Vehs in use:",["18 * UI_GRID_W + UI_GRID_X","22.5 * UI_GRID_H + UI_GRID_Y","6 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1006,"",[2,"Static weapons:",["17.5 * UI_GRID_W + UI_GRID_X","27 * UI_GRID_H + UI_GRID_Y","7 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1007,"",[2,"Num air:",["18 * UI_GRID_W + UI_GRID_X","23.5 * UI_GRID_H + UI_GRID_Y","8 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1008,"",[2,"Num land:",["18 * UI_GRID_W + UI_GRID_X","24.5 * UI_GRID_H + UI_GRID_Y","8 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1009,"",[2,"Num water:",["18 * UI_GRID_W + UI_GRID_X","25.5 * UI_GRID_H + UI_GRID_Y","8 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"ShowServerFPS",[2,"Show Server FPS",["16 * UI_GRID_W + UI_GRID_X","3.5 * UI_GRID_H + UI_GRID_Y","7 * UI_GRID_W","2 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |call toggleShowFPS|;"]],
	[1010,"",[2,"Num  spawned groups",["18 * UI_GRID_W + UI_GRID_X","17 * UI_GRID_H + UI_GRID_Y","9.5 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1011,"",[2,"Num  empty groups",["18 * UI_GRID_W + UI_GRID_X","18 * UI_GRID_H + UI_GRID_Y","9.5 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1900,"ChartNumShown",[2,"",["39.5 * UI_GRID_W + UI_GRID_X","8 * UI_GRID_H + UI_GRID_Y","11.5 * UI_GRID_W","2 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[" onSliderPosChanged = |_this call chartSliderChange|;"]],
	[1200,"ChartArea",[2,"#(argb,8,8,3)color(1,1,1,0.3)",["41.5 * UI_GRID_W + UI_GRID_X","11.5 * UI_GRID_H + UI_GRID_Y","12.5 * UI_GRID_W","14 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1013,"ChartNumShownText",[2,"Show num chart",["40.5 * UI_GRID_W + UI_GRID_X","6 * UI_GRID_H + UI_GRID_Y","8 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1014,"FPStext",[2,"FPS",["16 * UI_GRID_W + UI_GRID_X","6 * UI_GRID_H + UI_GRID_Y","11 * UI_GRID_W","1 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/









#include "dbgDefines.h"







class ChartLine
{
	idc = -1;
	style = 176;
	x = 0.17;
	y = 0.48;
	w = 0.66;
	h = 0;
	text = "";
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	deletable = 0;
	fade = 0;
	access = 0;
	type = 0;
	fixedWidth = 0;
	shadow = 0;
	colorShadow[] = {0,0,0,0.5};
	font = "RobotoCondensed";
	SizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};

};


class ChartText
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 0;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "RobotoCondensed";
	SizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};



class DbgStatsDialog
{
 idd = DBGSTATSDLG;

 movingEnable = false;

 onUnload = "call chartOnClose; call onCloseDbgStatsDlg;";
 
	class controlsBackground 
	{
	
class RscPicture_1200: IGUIBack
{
	idc = 3700;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	x = 15 * UI_GRID_W + UI_GRID_X;
	y = 5.5 * UI_GRID_H + UI_GRID_Y;
	w = 33 * UI_GRID_W;
	h = 25 * UI_GRID_H;
};


	
	};
	
	class objects { 
		// define controls here
	};
	
	
class controls 
{

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by GC, v1.063, #Javuki)
////////////////////////////////////////////////////////

class RscFrame_1800: RscFrame
{
	idc = 1800;
	text = "Side"; //--- ToDo: Localize;
	x = 16 * UI_GRID_W + UI_GRID_X;
	y = 8 * UI_GRID_H + UI_GRID_Y;
	w = 22 * UI_GRID_W;
	h = 4.5 * UI_GRID_H;
};
class RscFrame_1801: RscFrame
{
	idc = 1801;
	text = "All"; //--- ToDo: Localize;
	x = 16 * UI_GRID_W + UI_GRID_X;
	y = 14.5 * UI_GRID_H + UI_GRID_Y;
	w = 16 * UI_GRID_W;
	h = 14.5 * UI_GRID_H;
};
class UsedArmyBar : RscProgress
{
	idc = 1201;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	x = 16.5 * UI_GRID_W + UI_GRID_X;
	y = 10.5 * UI_GRID_H + UI_GRID_Y;
	w = 11 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscButton_1600: RscButton
{
	action = "call closeDbgStatsDlg";

	idc = 1600;
	text = "Close"; //--- ToDo: Localize;
	x = 29 * UI_GRID_W + UI_GRID_X;
	y = 30 * UI_GRID_H + UI_GRID_Y;
	w = 6 * UI_GRID_W;
	h = 2 * UI_GRID_H;
};
class RscText_1000: RscText
{
	idc = 1000;
	text = "Response time"; //--- ToDo: Localize;
	x = 27.5 * UI_GRID_W + UI_GRID_X;
	y = 6 * UI_GRID_H + UI_GRID_Y;
	w = 11.5 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1001: RscText
{
	idc = 1001;
	text = "0 / 0"; //--- ToDo: Localize;
	x = 18 * UI_GRID_W + UI_GRID_X;
	y = 9 * UI_GRID_H + UI_GRID_Y;
	w = 9 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1002: RscText
{
	idc = 1002;
	text = "Num men spawned: 0"; //--- ToDo: Localize;
	x = 17 * UI_GRID_W + UI_GRID_X;
	y = 19.5 * UI_GRID_H + UI_GRID_Y;
	w = 10 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1003: RscText
{
	idc = 1003;
	text = "Total groups: 0"; //--- ToDo: Localize;
	x = 17 * UI_GRID_W + UI_GRID_X;
	y = 15.5 * UI_GRID_H + UI_GRID_Y;
	w = 7.5 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1004: RscText
{
	idc = 1004;
	text = "Num veh spawned: 0"; //--- ToDo: Localize;
	x = 17 * UI_GRID_W + UI_GRID_X;
	y = 21 * UI_GRID_H + UI_GRID_Y;
	w = 10 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscCombo_2100: RscCombo
{
	onLBSelChanged = "call dbgSelectSide";

	idc = 2100;
	x = 28.5 * UI_GRID_W + UI_GRID_X;
	y = 10 * UI_GRID_H + UI_GRID_Y;
	w = 9 * UI_GRID_W;
	h = 1.5 * UI_GRID_H;
};
class RscText_1005: RscText
{
	idc = 1005;
	text = "Vehs in use:"; //--- ToDo: Localize;
	x = 18 * UI_GRID_W + UI_GRID_X;
	y = 22.5 * UI_GRID_H + UI_GRID_Y;
	w = 6 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1006: RscText
{
	idc = 1006;
	text = "Static weapons:"; //--- ToDo: Localize;
	x = 17.5 * UI_GRID_W + UI_GRID_X;
	y = 27 * UI_GRID_H + UI_GRID_Y;
	w = 7 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1007: RscText
{
	idc = 1007;
	text = "Num air:"; //--- ToDo: Localize;
	x = 18 * UI_GRID_W + UI_GRID_X;
	y = 23.5 * UI_GRID_H + UI_GRID_Y;
	w = 8 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1008: RscText
{
	idc = 1008;
	text = "Num land:"; //--- ToDo: Localize;
	x = 18 * UI_GRID_W + UI_GRID_X;
	y = 24.5 * UI_GRID_H + UI_GRID_Y;
	w = 8 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1009: RscText
{
	idc = 1009;
	text = "Num water:"; //--- ToDo: Localize;
	x = 18 * UI_GRID_W + UI_GRID_X;
	y = 25.5 * UI_GRID_H + UI_GRID_Y;
	w = 8 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class ShowServerFPS: RscButton
{
	action = "call toggleShowFPS";

	idc = 1601;
	text = "Show Server FPS"; //--- ToDo: Localize;
	x = 16 * UI_GRID_W + UI_GRID_X;
	y = 3.5 * UI_GRID_H + UI_GRID_Y;
	w = 7 * UI_GRID_W;
	h = 2 * UI_GRID_H;
};
class RscText_1010: RscText
{
	idc = 1010;
	text = "Num  spawned groups"; //--- ToDo: Localize;
	x = 18 * UI_GRID_W + UI_GRID_X;
	y = 17 * UI_GRID_H + UI_GRID_Y;
	w = 9.5 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class RscText_1011: RscText
{
	idc = 1011;
	text = "Num  empty groups"; //--- ToDo: Localize;
	x = 18 * UI_GRID_W + UI_GRID_X;
	y = 18 * UI_GRID_H + UI_GRID_Y;
	w = 9.5 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class ChartNumShown: RscSlider
{
	 onSliderPosChanged = "_this call chartSliderChange";

	idc = 1900;
	x = 39.5 * UI_GRID_W + UI_GRID_X;
	y = 8 * UI_GRID_H + UI_GRID_Y;
	w = 11.5 * UI_GRID_W;
	h = 2 * UI_GRID_H;
};
class ChartArea: RscPicture
{
	idc = 1200;
	text = "#(argb,8,8,3)color(1,1,1,0.3)";
	x = 41.5 * UI_GRID_W + UI_GRID_X;
	y = 11.5 * UI_GRID_H + UI_GRID_Y;
	w = 12.5 * UI_GRID_W;
	h = 14 * UI_GRID_H;
};
class ChartNumShownText: RscText
{
	idc = 1013;
	text = "Show num chart"; //--- ToDo: Localize;
	x = 40.5 * UI_GRID_W + UI_GRID_X;
	y = 6 * UI_GRID_H + UI_GRID_Y;
	w = 8 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
class FPStext: RscText
{
	idc = 1014;
	text = "FPS"; //--- ToDo: Localize;
	x = 16 * UI_GRID_W + UI_GRID_X;
	y = 6 * UI_GRID_H + UI_GRID_Y;
	w = 11 * UI_GRID_W;
	h = 1 * UI_GRID_H;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////


};

};
