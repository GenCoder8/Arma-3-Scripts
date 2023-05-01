#include "sideMain.h"


errMsg = 
{
private "_print";
_print = "";

if((typename  _this) == "ARRAY") then {
_print = format _this;}
else {
_print = _this;
};

_print = "SideMission ERROR: " + _print;

player globalchat _print;
//_print remoteExecCall ["printError"]; 

diag_log _print;
};

getPlayers =
{
// playableUnits
 allPlayers
};


createGroupLogged =
{
 createGroup _this;
};

deleteGroupInstantly =
{
 deletegroup _this;
};


userAddAction =
{
 params ["_actOwner","_text","_action","_condition",["_radius",3]];
 
 // hint format[">>> %1 --- %2", _actOwner,_text];
 
 private _id = _actOwner addAction [_text, _action, nil, 1.5, true, true,"",_condition,_radius];

_id
};

// Modify this function for displaying mission messages to player
userMessageClient =
{
private ["_msg"];

_msg = _this;

//player sidechat _msg;
hint _msg;

};


userMessage =
{
 scopename "um";
 
 private ["_msg","_target"];
 
 if(typename _this == "ARRAY") then
 {
  _msg = _this select 0;
  _target = _this select 1;
 }
 else
 {
  _msg = _this;
 };
 
 if(isDedicated) then
 {
 if(!isRemoteExecuted) then { "userMessage (dedicated) not isRemoteExecuted" call errmsg; breakOut "um"; };

 _target = remoteExecutedOwner; 
 
 if(isnil "_target") then
 {
  ["Invalid args in userMessage (dedicated) (%1)",_this] call errmsg;
 };
 
  _msg remoteExecCall ["userMessageClient", _target];
 }
 else
 {
  _msg call userMessageClient;
 };

};

// Composition mapper depency
getSideIndex = {
private ["_idx"];
_idx = -1;

if(_this==east)then{_idx=0;}; 
if(_this==west)then{_idx=1;};
if(_this==resistance)then{_idx=2;};
if(_this==civilian)then{_idx=3;};

if(_idx < 0) then { ["Could not determine side for %1",_this] call errmsg; };

_idx
};



safeDelete =
{
 params ["_man"];
 if(isnull _man) exitWith {};

 if(_man iskindof "man") then
 {

// A must or buggy (ghosts)
if(_man getVariable ["channelReg",false]) then
{
supportChannel radioChannelRemove [_man];
};

 if(_man call inVehicle) then
 {
 (vehicle _man) deleteVehicleCrew _man;
 }
 else
 {

 deleteVehicle _man;
 };
 }
 else
 {
  ["SafeDelete not man %1",_man] call errmsg;
 };
};

safeDeleteVeh =
{
 params ["_veh"];
 
if(!(_veh iskindof "man")) then
{

 {
  _x call safeDelete;
 } forEach (crew _veh);
 
 deleteVehicle _veh;

}
else
{
 ["SafeDeleteVeh not veh %1",_veh] call errmsg;
};

};

safeDeleteAny =
{
 params ["_obj"];
if(_obj iskindof "man") then
{
 _obj call safeDelete;
}
else
{
 _obj call safeDeleteVeh;
};
};

inVehicle =
{
 params ["_unit"];
 (vehicle _unit) != _unit
};
