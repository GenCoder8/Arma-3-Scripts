/* #Xutecy
$[
	1.063,
	["getGroupCfgs",[["safezoneX","safezoneY","safezoneW","safeZoneH"],"5 * 0.5 * pixelW * pixelGrid","5 * 0.5 * pixelH * pixelGrid","UI_GRID"],0,0,0],
	[1500,"",[2,"",["15.5 * UI_GRID_W + UI_GRID_X","8.5 * UI_GRID_H + UI_GRID_Y","9 * UI_GRID_W","11.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"Select faction","-1"],["onLBSelChanged = |call onFactionSelected|;"]],
	[1501,"",[2,"",["25 * UI_GRID_W + UI_GRID_X","8.5 * UI_GRID_H + UI_GRID_Y","11 * UI_GRID_W","11.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"Select group type","-1"],["onLBSelChanged = |call onGroupTypeSelected|;"]],
	[2100,"",[2,"Select side",["25 * UI_GRID_W + UI_GRID_X","5.5 * UI_GRID_H + UI_GRID_Y","13 * UI_GRID_W","2 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["onLBSelChanged = |call onSideSelected|;"]],
	[1502,"",[2,"",["36.5 * UI_GRID_W + UI_GRID_X","8.5 * UI_GRID_H + UI_GRID_Y","11.5 * UI_GRID_W","11.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"Select group config","-1"],["onLBSelChanged = |call onGroupSelected|;"]],
	[1503,"",[2,"",["16 * UI_GRID_W + UI_GRID_X","21 * UI_GRID_H + UI_GRID_Y","23 * UI_GRID_W","9 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["type = CT_LISTNBOX;","columns[] = GROUP_LIST_COL;"]],
	[1600,"",[2,"Copy faction",["15.5 * UI_GRID_W + UI_GRID_X","6 * UI_GRID_H + UI_GRID_Y","8.5 * UI_GRID_W","1.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |call copyFaction|;"]],
	[1601,"",[2,"Copy group config",["40 * UI_GRID_W + UI_GRID_X","21.5 * UI_GRID_H + UI_GRID_Y","7.5 * UI_GRID_W","1.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |call copyGroupConfig|;"]],
	[1602,"",[2,"Copy full config",["40 * UI_GRID_W + UI_GRID_X","24.5 * UI_GRID_H + UI_GRID_Y","7.5 * UI_GRID_W","1.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |call copyFullGroupConfig|;"]],
	[1603,"",[2,"Close",["41 * UI_GRID_W + UI_GRID_X","28.5 * UI_GRID_H + UI_GRID_Y","5.5 * UI_GRID_W","1.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |call GCGClose|;"]]
]
*/












#define GROUP_LIST_COL {0,0.35}


class GetGroupCfgsDlg
{
 idd = 1234765;

 movingEnable = false;
 
 onLoad = "uiNamespace setVariable ['gcgDisp', _this select 0];";
 //onUnload = "";

 class controlsBackground 
 {
 
class Background: IGUIBack
{
	idc = 3700;
	x = 15 * UI_GRID_W + UI_GRID_X;
	y = 5.5 * UI_GRID_H + UI_GRID_Y;
	w = 33 * UI_GRID_W;
	h = 25 * UI_GRID_H;
	
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
// GUI EDITOR OUTPUT START (by GC, v1.063, #Xutecy)
////////////////////////////////////////////////////////

class RscListbox_1500: RscListbox
{
	onLBSelChanged = "call onFactionSelected";

	idc = 1500;
	x = 15.5 * UI_GRID_W + UI_GRID_X;
	y = 8.5 * UI_GRID_H + UI_GRID_Y;
	w = 9 * UI_GRID_W;
	h = 11.5 * UI_GRID_H;
	tooltip = "Select faction"; //--- ToDo: Localize;
};
class RscListbox_1501: RscListbox
{
	onLBSelChanged = "call onGroupTypeSelected";

	idc = 1501;
	x = 25 * UI_GRID_W + UI_GRID_X;
	y = 8.5 * UI_GRID_H + UI_GRID_Y;
	w = 11 * UI_GRID_W;
	h = 11.5 * UI_GRID_H;
	tooltip = "Select group type"; //--- ToDo: Localize;
};
class RscCombo_2100: RscCombo
{
	onLBSelChanged = "call onSideSelected";

	idc = 2100;
	text = "Select side"; //--- ToDo: Localize;
	x = 25 * UI_GRID_W + UI_GRID_X;
	y = 5.5 * UI_GRID_H + UI_GRID_Y;
	w = 13 * UI_GRID_W;
	h = 2 * UI_GRID_H;
};
class RscListbox_1502: RscListbox
{
	onLBSelChanged = "call onGroupSelected";

	idc = 1502;
	x = 36.5 * UI_GRID_W + UI_GRID_X;
	y = 8.5 * UI_GRID_H + UI_GRID_Y;
	w = 11.5 * UI_GRID_W;
	h = 11.5 * UI_GRID_H;
	tooltip = "Select group config"; //--- ToDo: Localize;
};
class RscListbox_1503: RscListbox
{
	type = CT_LISTNBOX;
	columns[] = GROUP_LIST_COL;

	idc = 1503;
	x = 16 * UI_GRID_W + UI_GRID_X;
	y = 21 * UI_GRID_H + UI_GRID_Y;
	w = 23 * UI_GRID_W;
	h = 9 * UI_GRID_H;
};
class RscButton_1600: RscButton
{
	action = "call copyFaction";

	idc = 1600;
	text = "Copy faction"; //--- ToDo: Localize;
	x = 15.5 * UI_GRID_W + UI_GRID_X;
	y = 6 * UI_GRID_H + UI_GRID_Y;
	w = 8.5 * UI_GRID_W;
	h = 1.5 * UI_GRID_H;
};
class RscButton_1601: RscButton
{
	action = "call copyGroupConfig";

	idc = 1601;
	text = "Copy group config"; //--- ToDo: Localize;
	x = 40 * UI_GRID_W + UI_GRID_X;
	y = 21.5 * UI_GRID_H + UI_GRID_Y;
	w = 7.5 * UI_GRID_W;
	h = 1.5 * UI_GRID_H;
};
class RscButton_1602: RscButton
{
	action = "call copyFullGroupConfig";

	idc = 1602;
	text = "Copy full config"; //--- ToDo: Localize;
	x = 40 * UI_GRID_W + UI_GRID_X;
	y = 24.5 * UI_GRID_H + UI_GRID_Y;
	w = 7.5 * UI_GRID_W;
	h = 1.5 * UI_GRID_H;
};
class RscButton_1603: RscButton
{
	action = "call GCGClose";

	idc = 1603;
	text = "Close"; //--- ToDo: Localize;
	x = 41 * UI_GRID_W + UI_GRID_X;
	y = 28.5 * UI_GRID_H + UI_GRID_Y;
	w = 5.5 * UI_GRID_W;
	h = 1.5 * UI_GRID_H;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////



};

};
