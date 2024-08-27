
/* #Midugy
$[
	1.063,
	["chatExt",[["safezoneX","safezoneY","0","0"],"2.5 * pixelW * pixelGrid","2.5 * pixelH * pixelGrid","UI_GRID"],0,0,0],
	[2300,"",[2,"",["1 * UI_GRID_W + UI_GRID_X","11 * UI_GRID_H + UI_GRID_Y","27 * UI_GRID_W","13 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/


#define CHATEXTDLGID 1234511



class ChatExtendedDlg
{
 idd = CHATEXTDLGID;

 movingEnable = false;

// duration = 1e10;

//onLoad = "uiNamespace setVariable ['ChatExtOverlay', _this select 0];";
 
 onUnload = "call chatExtClose";


 class controlsBackground 
 {
 
class Background : IGUIBack
{
 idc = 3700;

 text = "#(argb,8,8,3)color(1,1,1,1)";
 x = 15 * UI_GRID_W + UI_GRID_X;
 y = 5.5 * UI_GRID_H + UI_GRID_Y;
 w = 33 * UI_GRID_W;
 h = 25 * UI_GRID_H;

 colorBackground[] = {179/255, 179/255, 179/255,1};
 };

 };
	
 class objects
 {
 };
	
	
class controls
{

/* #Kulyfi
$[
	1.063,
	["chatExt",[["safezoneX","safezoneY","0","0"],"2.5 * pixelW * pixelGrid","2.5 * pixelH * pixelGrid","UI_GRID"],0,0,0],
	[1100,"",[2,"",["15.5 * UI_GRID_W + UI_GRID_X","6 * UI_GRID_H + UI_GRID_Y","32 * UI_GRID_W","22.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[2,"Close",["42.5 * UI_GRID_W + UI_GRID_X","29 * UI_GRID_H + UI_GRID_Y","5 * UI_GRID_W","2.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |closeDialog 0|;"]],
	[1601,"",[2,"Side",["43 * UI_GRID_W + UI_GRID_X","3 * UI_GRID_H + UI_GRID_Y","4 * UI_GRID_W","2.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |1 call chatExtSwitchToChannel|;"]],
	[1602,"",[2,"Global",["37.5 * UI_GRID_W + UI_GRID_X","3 * UI_GRID_H + UI_GRID_Y","4 * UI_GRID_W","2.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["action = |0 call chatExtSwitchToChannel|;"]],
	[1000,"",[2,"Current channel text",["16.5 * UI_GRID_W + UI_GRID_X","3.5 * UI_GRID_H + UI_GRID_Y","11 * UI_GRID_W","2 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1900,"",[2,"",["27 * UI_GRID_W + UI_GRID_X","3 * UI_GRID_H + UI_GRID_Y","9 * UI_GRID_W","2.5 * UI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["onSliderPosChanged = |_this call chatExtTransparency|;"]]
]
*/






////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by GC, v1.063, #Toqyta)
////////////////////////////////////////////////////////

class ChatBox : RscControlsGroup
{
	idc	= 5001;

	x = 15.5 * UI_GRID_W + UI_GRID_X;
	y = 6 * UI_GRID_H + UI_GRID_Y;
	w = 32 * UI_GRID_W;
	h = 22.5 * UI_GRID_H;

	class Controls
	{
class ChatMessages : RscStructuredText
{

 idc = 1100;

x = 0;
y = 0;
w = 1;
h = 1;

};

	};

};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by GC, v1.063, #Kulyfi)
////////////////////////////////////////////////////////


class RscButton_1600: RscButton
{
	action = "closeDialog 0";

	idc = 1600;
	text = "Close"; //--- ToDo: Localize;
	x = 42.5 * UI_GRID_W + UI_GRID_X;
	y = 29 * UI_GRID_H + UI_GRID_Y;
	w = 5 * UI_GRID_W;
	h = 2.5 * UI_GRID_H;
};
class RscButton_1601: RscButton
{
	action = "1 call chatExtSwitchToChannel";

	idc = 1601;
	text = "Side"; //--- ToDo: Localize;
	x = 43 * UI_GRID_W + UI_GRID_X;
	y = 3 * UI_GRID_H + UI_GRID_Y;
	w = 4 * UI_GRID_W;
	h = 2.5 * UI_GRID_H;
};
class RscButton_1602: RscButton
{
	action = "0 call chatExtSwitchToChannel";

	idc = 1602;
	text = "Global"; //--- ToDo: Localize;
	x = 37.5 * UI_GRID_W + UI_GRID_X;
	y = 3 * UI_GRID_H + UI_GRID_Y;
	w = 4 * UI_GRID_W;
	h = 2.5 * UI_GRID_H;
};
class RscText_1000: RscText
{
	idc = 1000;
	text = "Current channel text"; //--- ToDo: Localize;
	x = 16.5 * UI_GRID_W + UI_GRID_X;
	y = 3.5 * UI_GRID_H + UI_GRID_Y;
	w = 11 * UI_GRID_W;
	h = 2 * UI_GRID_H;
};
class RscSlider_1900: RscSlider
{
	onSliderPosChanged = "_this call chatExtTransparency";

	idc = 1900;
	x = 27 * UI_GRID_W + UI_GRID_X;
	y = 3 * UI_GRID_H + UI_GRID_Y;
	w = 9 * UI_GRID_W;
	h = 2.5 * UI_GRID_H;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////






};

};
