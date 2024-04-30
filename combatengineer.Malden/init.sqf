
sleep 0.1;
createDialog "SelectObjectDlg";


//
#include "\a3\ui_f\hpp\definedikcodes.inc"

#define CE_MOVE_ENABLE_KEYS [DIK_LCONTROL,DIK_RCONTROL]

#define CE_PLACING_Z_MUL   0.1
#define CE_PLANING_ROT_MUL 0.5

#define CE_PLACING_AWAY_FROM  1.5

placingCtrlDown = false;
placingMode = "height";

placingZ = 0.5;
placingTilt = 0;

placingObjType = "Land_PierLadder_F"; // "Land_Plank_01_4m_F";


waituntil { !isnull (findDisplay 46) };

(findDisplay 46) displayAddEventHandler ["MouseZChanged",
{
params ["_display", "_scroll"];



if(placingCtrlDown) then
{

if(placingMode == "height") then
{
placingZ = placingZ + _scroll * CE_PLACING_Z_MUL;
}
else
{
placingTilt = placingTilt - _scroll * CE_PLANING_ROT_MUL;
};

//

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
if(placingMode == "height") then
{
hint "Changing tilt";

placingMode = "rotation";
}
else
{
hint "Changing height";

placingMode = "height";
};
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

 private _posFromPlr = player modelToWorld [0,CE_PLACING_AWAY_FROM,placingZ];

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

