#include "dbgDefines.h"

#define MAKE_COLOR(r,g,b,a) [r / 255,g / 255,b / 255,a / 255]

chartMenCount =
{
 private _men = (call dbgGetAllMen) select { !isplayer _x };

 count _men
};

chartVehicleCount =
{
 private _vehs = (call dbgGetAllVehicles) select { _x call isVehicleDriveable && !isplayer (driver _x) };

 count _vehs
};


chartTypes = [
["FPS", { diag_fpsMin },[0,250], MAKE_COLOR(0, 153, 51, 255) ],
["Men",chartMenCount, [0,100], MAKE_COLOR(0, 255, 0, 255)  ],
["Vehicles",chartVehicleCount, [0,100], MAKE_COLOR(0, 0, 255, 255)  ]

//["test",{ random 1 }, [0,1], MAKE_COLOR(0, 102, 204, 255)  ]
];

numStepsToShow = 5;

// diag_fps



chartLines = [];

{ chartLines pushback [] } foreach chartTypes;



chartCtrls = [];


chartUpdate =
{
_display = findDisplay DBGSTATSDLG;

if(isnull _display) exitWith {}; // If dlg not open

_chart = _display displayctrl 1200;

{ ctrlDelete _x } foreach chartCtrls;
chartCtrls = [];


//if(count chartLines < 1) exitWith {};

_chartPos = ctrlPosition _chart;
_xStart = (_chartPos # 0);
_yStart = (_chartPos # 1);
_chartWidth = (_chartPos # 2);
_chartHeight = (_chartPos # 3);

_step = STEP_X;

_fline = chartLines # 0; // fetch one of the lines

if(count _fline < 2) exitWith {}; // bail if nothing to show

_maxShown = numStepsToShow;
if(_maxShown >= (count _fline)) then { _maxShown = count _fline - 1; };


_step = _chartWidth / _maxShown;


_prevLineY = 0;

{
_line = _x;
_ldef = chartTypes # _forEachIndex;
_lineindex = _forEachIndex;


if(count _line < 2) then { break; };

_li = count _line - _maxShown - 2;
if(_li < 0) then { _li = 0; };
_showlines = _line select [_li, _maxShown + 1];

_name = _ldef # 0;
_minMax = _ldef # 2;
_color = _ldef # 3; // [random 1,random 1,random 1,1];



_xShift = (_maxShown - (count _showlines ) ) - 0; // (count _showlines ) * -_step; // MAX_CHART_STEPS - (count _showlines) - 1; // - 1 because first line is ignored
//if(_xShift < 0) then { _xShift = 0; };

// if(_xShift < 0) then { continue; };

_lastValue = 0;
_lastY = 0;

{
 _valueReal = _x;

// _valueReal = _valueReal / 10;

_value = [_valueReal,_minMax # 0, _minMax # 1, 0.0, _chartHeight - 0.05] call getValueInRange;

_value = _value * -1;

_curLineY = (_value * 1);
_curLineX = ((_forEachIndex + _xShift) * _step);

if(_forEachIndex > 0) then
{


_sy = _yStart + _prevLineY + _chartHeight;
_sx = _xStart + _curLineX;

// diag_log format [">>> %1 %2 %3 %4",_sx, _sy, _step, _curLineY - _prevLineY];

_lineCtrl = _display ctrlCreate ["ChartLine", -1];
_lineCtrl ctrlSetPosition [_sx, _sy, _step, _curLineY - _prevLineY];  // w & h are relative x & y to the starting point
_lineCtrl ctrlSetTextColor _color;
_lineCtrl ctrlCommit 0;
chartCtrls pushback _lineCtrl;

_lastValue = _valueReal;
_lastY = _yStart + _curLineY + _chartHeight;

/*
_pos1 = [_xStart + _cx, _yStart + _prevY + 0.1];
_pos2 = [(_pos1 # 0) + STEP_X ,  (_pos1 # 1) + _cy - _prevY];


_angle = [_pos1,_pos2] call getAngle;

#define IMG_SIZE 0.2

private _lineCtrl = findDisplay 46 ctrlCreate ["TestCtrlCfg", -1];
// _lineCtrl ctrlSetText "#(argb,8,8,3)color(1,1,1,1)";
_lineCtrl ctrlSetPosition [(_pos1 # 0) - (IMG_SIZE/2), (_pos1 # 1) - (IMG_SIZE/2), IMG_SIZE, IMG_SIZE];
_lineCtrl ctrlSetAngle [-_angle+90, 0.5, 0.5, false];
_lineCtrl ctrlCommit 0;

chartCtrls pushback _lineCtrl;
*/

};

_prevLineY = _curLineY;

} foreach _showlines;

#define TEXT_HEIGHT 0.05

_textCtrl = _display ctrlCreate ["ChartText", -1];
_textCtrl ctrlSetPosition [_xStart + (MAX_CHART_STEPS - 1) * STEP_X + (_lineindex * 0.05) , _lastY - (TEXT_HEIGHT / 2) ,  0.2, TEXT_HEIGHT];
_textCtrl ctrlSetTextColor _color;
_textCtrl ctrlSetText format["%1 %2", _lastValue, _name];
_textCtrl ctrlCommit 0;
chartCtrls pushback _textCtrl;


} foreach chartLines;



};

chartOnClose =
{

terminate chartHandle;


{ ctrlDelete _x } foreach chartCtrls;
chartCtrls = [];
};





chartSliderChange =
{
 params ["_ctrl", "_value"];

 numStepsToShow = round _value;

 if(numStepsToShow <= 0) then { numStepsToShow = 1; };

_display = findDisplay DBGSTATSDLG;

(_display displayctrl 1013) ctrlSetText format ["Num steps to show: %1", numStepsToShow];

};

chartBeginRecording =
{

chartHandle = [] spawn
{

while { true } do
{

 {
  _x params ["_name","_code"];
  _lines = chartLines # _forEachIndex;

  _lines pushback (call _code);

/*
 if(count _lines > MAX_CHART_STEPS) then
 {
  _lines deleteAt 0;
 };*/

 } foreach chartTypes;



 call chartUpdate;

 sleep 0.5;

};

};

};

// Init chart
chartInit =
{

_display = findDisplay DBGSTATSDLG;
//_chart = _display displayctrl 1200;

_stepsSlider = _display displayctrl 1900;

_stepsSlider sliderSetSpeed [1, 10, 1];
_stepsSlider sliderSetRange [0, 100];

_stepsSlider sliderSetPosition numStepsToShow;

[_stepsSlider,numStepsToShow] call chartSliderChange; // Init like this

};