
#define SETTINGSDLG 1234567

#define MAX_VIEW_DIST 5000

viewDistanePlane = profilenamespace getVariable ["customViewdistancePlane", 3000];
viewDistaneHeli =  profilenamespace getVariable ["customViewdistanceHeli", 2000];
viewDistaneGround = profilenamespace getVariable ["customViewdistanceGround", 1500];

settingsMsg =
{
 hint _this;
};

settingsOpen =
{

createdialog "SettingsDlg";

_display = findDisplay SETTINGSDLG;


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

_newValue call setCustomViewDistance;

hintSilent str _this 
}];

private _sliderValue = (missionnamespace getVariable [_vdVal,1500]);

/*
private _maxVal = _maxViewDistance;

if(_maxVal > MAX_VIEW_DIST) then
{
 _maxVal = MAX_VIEW_DIST;
};
*/

if(_sliderValue > MAX_VIEW_DIST) then
{
 _sliderValue = MAX_VIEW_DIST;
};

/*
if(_sliderValue > _maxViewDistance) then
{
_sliderValue = _maxViewDistance;
};*/

_slider sliderSetRange [200, MAX_VIEW_DIST];
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

setCustomViewDistance =
{
 params ["_vdist"];

setViewdistance _vdist;
setObjectViewDistance (ceil (_vdist * 0.75));

};

updateViewDistance =
{
 private _veh = vehicle player;
 private _vdSet = 0;

// If enabled
if(profilenamespace getVariable ["useCustomViewdistance", true]) then
{

if(_veh != player) then
{

if(_veh isKindof "Plane") then
{
 format ["view Plane dist %1", viewDistanePlane] call settingsMsg;
 _vdSet = viewDistanePlane;
};

if(_veh isKindof "Helicopter") then
{
 format ["view Heli dist %1", viewDistaneHeli] call settingsMsg;
 _vdSet = viewDistaneHeli;
};

};

if(_vdSet == 0) then
{
 format ["view Ground dist %1", viewDistaneGround] call settingsMsg;
 _vdSet = viewDistaneGround;
};

_vdSet call setCustomViewDistance;

}
else
{
 format ["view dist reset"] call settingsMsg;

 _objVis = getVideoOptions get "objectVisibility";

 setViewdistance -1;
 setObjectViewDistance _objVis;
};


};

