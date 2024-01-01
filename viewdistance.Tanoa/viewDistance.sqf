
#define SETTINGSDLG 1234567

#define MAX_VIEW_DIST 5000


settingsOpen =
{

createdialog "SettingsDlg";

_display = findDisplay SETTINGSDLG;

viewDistanePlane = profilenamespace getVariable ["customViewdistancePlane", 3000];
viewDistaneHeli =  profilenamespace getVariable ["customViewdistanceHeli", 2000];
viewDistaneGround = profilenamespace getVariable ["customViewdistanceGround", 1500];

_active = profilenamespace getVariable ["useCustomViewdistance", true];

_maxViewDistance = getVideoOptions get "overallVisibility";

(_display displayCtrl 1006) ctrlSetText format ["Overall visibility: %1",_maxViewDistance];

(_display displayCtrl 2800) cbSetChecked _active;

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

private _maxVal = _maxViewDistance;

if(_maxVal > MAX_VIEW_DIST) then
{
 _maxVal = MAX_VIEW_DIST;
};

if(_sliderValue > MAX_VIEW_DIST) then
{
 _sliderValue = MAX_VIEW_DIST;
};

if(_sliderValue > _maxViewDistance) then
{
_sliderValue = _maxViewDistance;
};

_slider sliderSetRange [200, _maxVal];
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


if(_apply) then
{

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

profilenamespace setVariable ["useCustomViewdistance", cbChecked (_display displayCtrl 2800) ];

profilenamespace setVariable ["customViewdistancePlane", viewDistanePlane];
profilenamespace setVariable ["customViewdistanceHeli", viewDistaneHeli];
profilenamespace setVariable ["customViewdistanceGround", viewDistaneGround];

saveProfileNamespace; 

};

call updateViewDistance;

closeDialog 0;

};

updateViewDistance =
{
 private _veh = vehicle player;
 private _vdSet = false;

if(_veh != player) then
{

if(_veh isKindof "Plane") then
{
 hint format ["view Plane dist %1", viewDistaneGround];
 _vdSet = true;
};

if(_veh isKindof "Heli") then
{
 hint format ["view Heli dist %1", viewDistaneGround];
 _vdSet = true;
};

};

if(!_vdSet) then
{
 hint format ["view Ground dist %1", viewDistaneGround];
};

};

