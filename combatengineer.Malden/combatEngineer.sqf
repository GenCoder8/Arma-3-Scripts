
#include "\a3\ui_f\hpp\definedikcodes.inc"




#define CE_MOVE_ENABLE_KEYS [DIK_LCONTROL,DIK_RCONTROL]

#define CE_PLACING_HEIGHT_MUL   0.1
#define CE_PLANING_TILT_MUL 1
#define CE_PLANING_AWAY_MUL 0.2

#define CE_PLACING_AWAY_FROM  1.5

#define CE_PLACING_MODE_HEIGHT 0
#define CE_PLACING_MODE_TILT   1
#define CE_PLACING_MODE_AWAY   2
#define CE_MAX_PLACING_MODES   3


placingCtrlDown = false;
placingMode = CE_PLACING_MODE_HEIGHT;


placingObjType = "Land_PierLadder_F"; // "Land_Plank_01_4m_F";

ceRegisterInput =
{
//waituntil { !isnull (findDisplay 46) };

ceInputKeyZ = (findDisplay 46) displayAddEventHandler ["MouseZChanged",
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
placingTilt = placingTilt - _scroll * CE_PLANING_TILT_MUL;
};

if(placingMode == CE_PLACING_MODE_AWAY) then
{
 placingAwayFrom = placingAwayFrom + _scroll * CE_PLANING_AWAY_MUL;
 if(placingAwayFrom < ceMinAwayDistance) then { placingAwayFrom = ceMinAwayDistance; };
 if(placingAwayFrom > 10) then { placingAwayFrom = 10; };
};

};

// hint format ["%1 %2 %3", count _this,_this,placingTilt];

false
}];


ceInputKeyDown = (findDisplay 46) displayAddEventHandler ["KeyDown",
{

params ["_display", "_key", "_shift", "_ctrl", "_alt"];

//systemchat format [">>> %1 %2 %3", _key, _ctrl];

if(_key in CE_MOVE_ENABLE_KEYS) then
{
 placingCtrlDown = true;
};


}];


ceInputKeyUp = (findDisplay 46) displayAddEventHandler ["KeyUp",
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

systemchat format ["placingMode %1", placingMode];

if(placingMode == CE_PLACING_MODE_HEIGHT) then { hint "Changing height"; };
if(placingMode == CE_PLACING_MODE_TILT) then { hint "Changing tilt"; };
if(placingMode == CE_PLACING_MODE_AWAY) then { hint "Changing away position"; };

};

}];


};

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

placingMode = CE_PLACING_MODE_HEIGHT; // Reset

call ceRegisterInput;

private _pobj = createSimpleObject [placingObjType, [0,0,0], true];

// private _pobj = createVehicleLocal [placingObjType, [0,0,0], [], 0, "CAN_COLLIDE"];

placingObj = _pobj;

private _size = _pobj call getObjectSize;

ceMinAwayDistance = ((_size # 0) max (_size # 1)) / 2 + 1.5;

placingAwayFrom = ceMinAwayDistance;


// systemchat format ["ceMinAwayDistance %1", ceMinAwayDistance];


player disableCollisionWith _pobj;


_p = ["Place","#00e600","a3\3den\data\displays\display3den\toolbar\redo_ca.paa"] call makeActStr;

cePlacingAction = [player,_p,{

private _finalobj = createVehicle [placingObjType, getposATL placingObj, [], 0, "CAN_COLLIDE"];

_finalobj setVectorDirAndUp [vectorDir placingObj,vectorUp placingObj];

_finalobj setposATL (getposATL placingObj);

//_finalobj setdir (getdir placingObj);


call ceEndPlacing;

}] call userAddAction;


_c = ["Cancel Placement","#FF0000","a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_cancel_ca.paa"] call makeActStr;

ceCancelAction = [player,_c,{ call ceEndPlacing; }] call userAddAction;







cePlacingEF = addMissionEventHandler ["EachFrame",
{

 if(!alive player) exitwith { call ceEndPlacing; };

 private _pos = getposATL player;

 private _posFromPlr = player modelToWorld [0,placingAwayFrom,placingZ];


 placingObj setPosATL _posFromPlr;



private _yaw = getdir player; 
private _pitch = placingTilt; 
private _roll = 0;

placingObj setVectorDirAndUp [
	[sin _yaw * cos _pitch, cos _yaw * cos _pitch, sin _pitch],
	[[sin _roll, -sin _pitch, cos _roll * cos _pitch], -_yaw] call BIS_fnc_rotateVector2D
];



}];






};

ceEndPlacing =
{

if(!isnil "cePlacingEF") then
{
removeMissionEventHandler ["EachFrame", cePlacingEF];
cePlacingEF = nil;
};

if(!isnil "ceInputKeyUp") then
{

(findDisplay 46) displayRemoveEventHandler ["keyDown",ceInputKeyDown];
(findDisplay 46) displayRemoveEventHandler ["KeyUp",ceInputKeyUp];
(findDisplay 46) displayRemoveEventHandler ["MouseZChanged",ceInputKeyZ];

ceInputKeyZ = nil;
ceInputKeyUp = nil;
ceInputKeyDown = nil;

};

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
