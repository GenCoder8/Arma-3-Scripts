
#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)


#define UI_GRID_X	(safezoneX)
#define UI_GRID_Y	(safezoneY)
#define UI_GRID_W	(5 * 0.5 * pixelW * pixelGrid)
#define UI_GRID_H	(5 * 0.5 * pixelH * pixelGrid)


#define UI_GRID_WAbs	(safezoneW)
#define UI_GRID_HAbs	(safeZoneH)

/*
#define UI_GRID_X (safezoneX - 1.0 * (1 - (pixelW / 0.0014881)))
#define UI_GRID_Y (safezoneY - 1.0 * (1 - (pixelH / 0.00198413)))
*/

/*
#define UI_GRID_X (safezoneX)
#define UI_GRID_Y (safezoneY)
#define UI_GRID_W (((safezoneW / safezoneH) min 1.2) / 40)
#define UI_GRID_H ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
*/

/*
#define UI_GRID_WAbs			((safezoneW / safezoneH) min 1.2)
#define UI_GRID_HAbs			(UI_GRID_WAbs / 1.2)
#define UI_GRID_W			(UI_GRID_WAbs / 40)
#define UI_GRID_H			(UI_GRID_HAbs / 25)
#define UI_GRID_X			(safezoneX)
#define UI_GRID_Y			(safezoneY + safezoneH - UI_GRID_HAbs)
*/