
#define SELOBJDLG_ID 1238990


class SelectObjectDlg
{
 idd = SELOBJDLG_ID;

 movingEnable = false;
 
 onLoad = "";

 class controlsBackground 
 {
 
 	class Background: IGUIBack
    {
	idc = 3700;
	x = 15 * UI_GRID_W + UI_GRID_X;
	y = 5 * UI_GRID_H + UI_GRID_Y;
	w = 34 * UI_GRID_W;
	h = 26 * UI_GRID_H;
	moving = false;
	
	colorBackground[] = {0,0,0,1};
	
    };
 
 };
	
 class objects 
 {
 };
	
	
class controls 
{

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by GC, v1.063, #Feseqy)
////////////////////////////////////////////////////////

class RscListbox_1500: RscListbox
{
	onLBSelChanged = "_this call selectObjectDlgSel";

	idc = 1500;
	x = 19 * UI_GRID_W + UI_GRID_X;
	y = 7.5 * UI_GRID_H + UI_GRID_Y;
	w = 20 * UI_GRID_W;
	h = 15 * UI_GRID_H;
};
class RscButton_1600: RscButton
{
	action = "call selectObjectDlgApply";

	idc = 1600;
	text = "Build"; //--- ToDo: Localize;
	x = 34 * UI_GRID_W + UI_GRID_X;
	y = 26 * UI_GRID_H + UI_GRID_Y;
	w = 7 * UI_GRID_W;
	h = 2.5 * UI_GRID_H;
};
class RscButton_1601: RscButton
{
	action = "call selectObjectDlgCancel";

	idc = 1601;
	text = "Close"; //--- ToDo: Localize;
	x = 22 * UI_GRID_W + UI_GRID_X;
	y = 26 * UI_GRID_H + UI_GRID_Y;
	w = 7 * UI_GRID_W;
	h = 2.5 * UI_GRID_H;
};
class RscPicture_1200: RscPicture
{
	idc = 1200;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	x = 40 * UI_GRID_W + UI_GRID_X;
	y = 7.5 * UI_GRID_H + UI_GRID_Y;
	w = 7 * UI_GRID_W;
	h = 7 * UI_GRID_H;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////






};

};