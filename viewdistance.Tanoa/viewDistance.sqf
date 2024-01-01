
#define SETTINGSDLG 1234567


settingsOpen =
{

createdialog "SettingsDlg";

_display = findDisplay SETTINGSDLG;

viewDistanePlane = 3000;
viewDistaneHeli =  2000;
viewDistaneGround = 1500;

_setupViewDistCtrls =
{
 params ["_sliderId","_numId","_vdVal"];

_slider = _display displayCtrl _sliderId; 
_slider setVariable ["vdnum", _display displayCtrl _numId];

_slider ctrlAddEventHandler ["SliderPosChanged", 
{
params ["_slider", "_newValue"];

(_slider getVariable "vdnum") ctrlSetText format["%1",_newValue];

hintSilent str _this 
}];

private _sliderValue = (missionnamespace getVariable [_vdVal,1000]);

_slider sliderSetRange [0, 10000];
_slider sliderSetSpeed [100, 1000, 100];
_slider sliderSetPosition _sliderValue;
(_slider getVariable "vdnum") ctrlSetText format["%1",_sliderValue]; // Have to init here

};

[1900,1003,"viewDistanePlane"] call _setupViewDistCtrls;
[1901,1004,"viewDistaneHeli"] call _setupViewDistCtrls;
[1902,1005,"viewDistaneGround"] call _setupViewDistCtrls;

};

settingsClose =
{
 params [["_apply", false]];

_display = findDisplay SETTINGSDLG;


_readInViewDistance =
{
 params ["_sliderId","_numId","_vdVal"];

_slider = _display displayCtrl _sliderId; 

_sliderPos = sliderPosition _slider;

missionnamespace setVariable [_vdVal,_sliderPos];

};

[1900,1003,"viewDistanePlane"] call _readInViewDistance;
[1901,1004,"viewDistaneHeli"] call _readInViewDistance;
[1902,1005,"viewDistaneGround"] call _readInViewDistance;

call updateViewDistance;

closeDialog 0;

};

updateViewDistance =
{
 _veh = vehicle player;

if(_veh != player) then
{

}
else
{
 hint format ["view dist %1", viewDistaneGround],
};

};

