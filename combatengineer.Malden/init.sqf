

#include "\a3\ui_f\hpp\definedikcodes.inc"


_h = execvm "objectSelectDlg.sqf";
waituntil { scriptdone _h };

sleep 0.1;


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




//if(true) exitwith {};

ceOpenObjectSelect =
{

private _selObjs = [];

private _ceObjs = missionConfigFile >> "CombatEngineerObjs";

for "_i" from 0 to (count _ceObjs - 1) do
{
 private _ceObj = _ceObjs select _i;

 _selObjs pushback [getText(_ceObj >> "name"),(getText (_ceObj >> "object"))];
};

[_selObjs,ceStartPlacing] call openSelectObjectDlg;

};



ceStartPlacing =
{
 params ["_placeObjType"];

 placingObjType = _placeObjType;


placingZ = 0.5;
placingTilt = 0;
placingAwayFrom = 1.5;


private _pobj = createSimpleObject [placingObjType, [0,0,0], true];

// _pobj = createVehicle [placingObjType, getposATL player vectoradd [0,0,0.5], [], 0, "CAN_COLLIDE"];


//_pobj disableCollisionWith player;
player disableCollisionWith _pobj;



cePlacingAction = player addAction ["Place",
{

private _finalobj = createVehicle [placingObjType, getposATL placingObj, [], 0, "CAN_COLLIDE"];

_finalobj setVectorDirAndUp [vectorDir placingObj,vectorUp placingObj];

_finalobj setposATL (getposATL placingObj);

//_finalobj setdir (getdir placingObj);


call ceEndPlacing;

}];

ceCancelAction = player addAction ["Cancel Placement",
{

call ceEndPlacing;

}];



placingObj = _pobj;

//if(true) exitwith {};

[] spawn
{

sleep 0.1; // For disable collision to work

while { alive player && !isnull placingObj } do
{

 private _pos = getposATL player;

 private _posFromPlr = player modelToWorld [0,placingAwayFrom,placingZ];

 placingObj setPosATL _posFromPlr;



private _yaw = (getdir player); 
private _pitch = placingTilt; 
private _roll = 0;

placingObj setVectorDirAndUp [
	[sin _yaw * cos _pitch, cos _yaw * cos _pitch, sin _pitch],
	[[sin _roll, -sin _pitch, cos _roll * cos _pitch], -_yaw] call BIS_fnc_rotateVector2D
];


 sleep 0.1;
};

call ceEndPlacing;

};

};

ceEndPlacing =
{

if(!isnil "cePlacingAction") then
{
player removeAction cePlacingAction;
player removeAction ceCancelAction;
};

cePlacingAction = nil;
ceCancelAction = nil;

// Make sure deleted
if(!isnull placingObj) then
{
deleteVehicle placingObj;
};

};


ceIsPlacing =
{
 !isnull placingObj
};



call ceOpenObjectSelect; // Begin testing



// Test functions

userAddAction =
{
 params ["_actOwner","_text","_action","_condition",["_radius",3]];
 
private _id = _actOwner addAction [_text, _action, nil, 1.5, true, true,"",_condition,_radius];

_id
};


_id = [player,"place objs", {

call ceOpenObjectSelect;

}, "!call ceIsPlacing" ] call userAddAction;



