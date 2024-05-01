
sleep 0.1;




#include "\a3\ui_f\hpp\definedikcodes.inc"



#define CE_MOVE_ENABLE_KEYS [DIK_LCONTROL,DIK_RCONTROL]

#define CE_PLACING_HEIGHT_MUL   0.1
#define CE_PLANING_ROT_MUL 0.5
#define CE_PLANING_AWAY_MUL 0.2

#define CE_PLACING_AWAY_FROM  1.5

#define CE_PLACING_MODE_HEIGHT 0
#define CE_PLACING_MODE_TILT   1
#define CE_PLACING_MODE_AWAY   2
#define CE_MAX_PLACING_MODES   3


placingCtrlDown = false;
placingMode = CE_PLACING_MODE_HEIGHT;

placingZ = 0.5;
placingTilt = 0;
placingAwayFrom = 1.5;

placingObjType = "Land_PierLadder_F"; // "Land_Plank_01_4m_F";


waituntil { !isnull (findDisplay 46) };

(findDisplay 46) displayAddEventHandler ["MouseZChanged",
{
params ["_display", "_scroll"];


if(placingCtrlDown) then
{

if(placingMode == CE_PLACING_MODE_HEIGHT) then
{
placingZ = placingZ + _scroll * CE_PLACING_HEIGHT_MUL;
if(placingZ < -10) then { placingZ = -10; };
if(placingZ > 10) then { placingZ = 10; };
};

if(placingMode == CE_PLACING_MODE_TILT) then
{
placingTilt = placingTilt - _scroll * CE_PLANING_ROT_MUL;
};

if(placingMode == CE_PLACING_MODE_AWAY) then
{
 placingAwayFrom = placingAwayFrom + _scroll * CE_PLANING_AWAY_MUL;
 if(placingAwayFrom < 0) then { placingAwayFrom = 0; };
 if(placingAwayFrom > 10) then { placingAwayFrom = 10; };
};

};

// hint format ["%1 %2 %3", count _this,_this,placingTilt];

false
}];


(findDisplay 46) displayAddEventHandler ["KeyDown",
{

params ["_display", "_key", "_shift", "_ctrl", "_alt"];

//systemchat format [">>> %1 %2 %3", _key, _ctrl];

if(_key in CE_MOVE_ENABLE_KEYS) then
{
 placingCtrlDown = true;
};


}];


(findDisplay 46) displayAddEventHandler ["KeyUp",
{

params ["_display", "_key", "_shift", "_ctrl", "_alt"];

if(_key in CE_MOVE_ENABLE_KEYS) then
{
 placingCtrlDown = false;
};



// hint format [">>> %1 %2 %3", _key == DIK_H, placingMode];

if(_key == DIK_H) then
{
placingMode = placingMode + 1;
if(placingMode >= CE_MAX_PLACING_MODES) then
{
placingMode = 0;
};

if(placingMode == CE_PLACING_MODE_HEIGHT) then { hint "Changing height"; };
if(placingMode == CE_PLACING_MODE_TILT) then { hint "Changing tilt"; };
if(placingMode == CE_PLACING_MODE_AWAY) then { hint "Changing away position"; };

};

}];


_actionID = player addAction ["Place", {

_finalobj = createVehicle [placingObjType, getposATL placingObj, [], 0, "CAN_COLLIDE"];

_finalobj setVectorDirAndUp [vectorDir placingObj,vectorUp placingObj];

_finalobj setposATL (getposATL placingObj);

//_finalobj setdir (getdir placingObj);


deleteVehicle placingObj;

}];


//if(true) exitwith {};

selectObjsDlgObjects = [];

openSelectObjectDlg =
{
params ["_selObjs"];

createDialog "SelectObjectDlg";

_display = findDisplay 1238990;

private _list = _display displayCtrl 1500;

{
 _x params ["_name","_cfgName"];

 _list lbadd _name;

 private _objCfg = configfile >> "CfgVehicles" >> _cfgName;

 selectObjsDlgObjects pushback [_name,_objCfg];
} foreach _selObjs;


};

selectObjectDlgSel =
{
 params ["_ctrl","_index"];


_display = findDisplay 1238990;

 private _pic = _display displayCtrl 1200;

 if(_index < 0) exitWith {};

 (selectObjsDlgObjects # _index) params ["_name","_objCfg"];

 _pic ctrlSetText format ["%1",getText (_objCfg >> "editorPreview")];

 systemchat format ["_ctrl %1", _objCfg];

};

ceOpenObjectSelect =
{

private _selObjs = [];
_ceObjs = missionConfigFile >> "CombatEngineerObjs";
for "_i" from 0 to (count _ceObjs - 1) do
{
 private _ceObj = _ceObjs select _i;

 _selObjs pushback [configname _ceObj,(getText (_ceObj >> "object"))];
};

[_selObjs] call openSelectObjectDlg;

};

call ceOpenObjectSelect;


ceStartPlacing =
{

private _pobj = createSimpleObject [placingObjType, [0,0,0], true];

// _pobj = createVehicle [placingObjType, getposATL player vectoradd [0,0,0.5], [], 0, "CAN_COLLIDE"];


//_pobj disableCollisionWith player;
player disableCollisionWith _pobj;

sleep 0.1;

placingObj = _pobj;

//if(true) exitwith {};

while { !isnull placingObj } do
{

 private _pos = getposATL player;

 private _posFromPlr = player modelToWorld [0,placingAwayFrom,placingZ];

 _pobj setPosATL _posFromPlr;

 //_pobj setdir (getdir player);


_yaw = (getdir player); _pitch = placingTilt; _roll = 0;
_pobj setVectorDirAndUp [
	[sin _yaw * cos _pitch, cos _yaw * cos _pitch, sin _pitch],
	[[sin _roll, -sin _pitch, cos _roll * cos _pitch], -_yaw] call BIS_fnc_rotateVector2D
];

 //_pobj setVectorDirAndUp [[0,1,0], [1,0,0]];

 /// _pobj setVectorDir [0,0,placingTilt];

 sleep 0.1;
};

};
