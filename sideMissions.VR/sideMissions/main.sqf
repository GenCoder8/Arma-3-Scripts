#include "sideMain.h"



runningSideMissions = [];
deleteSideMissions = [];



numSideMisCreated = 0;

startSideMission =
{
 params ["_misPos","_misSide","_misClass"];
 _misConf = missionConfigFile >> "SideMissions" >> _misClass;
 _startFn = getText (_misConf >> "start");
 
 curMisPos = _misPos;
 curMisTargets = [];
 _curMisSide = _misSide;
 
 _compobjs = [];
 
 private _defenderSet = [_misSide,_misPos] call onSideMissionDefenderCreate;
 private _enemySide = civilian;
 private _groups = [];
 if(count _defenderSet > 0) then
 {
  _enemySide = _defenderSet # 0;
  _groups = _defenderSet # 1; 
 };
 
 [_misConf,_enemySide] call smInitMission;
 
 if(_startFn != "") then
 {
 call compile _startFn;
 };
 
 _taskIcon = getText(_misConf >> "taskIcon");
 _desc = getText (_misConf >> "desc");
 
 _taskID = format["sideMisTask_%1",numSideMisCreated];
 numSideMisCreated = numSideMisCreated + 1;
 
 [_misSide,_taskID, [getText(_misConf >> "startInfo"),_desc,""], _misPos, "CREATED", 1, true, "", false] call BIS_fnc_taskCreate;
 

// taskAlwaysVisible?

{

_id = format ["%1_%2",_taskID,_foreachindex];
[_misSide, [_id,_taskID], [_desc,format["Target %1", _foreachindex + 1],"target"], _x, "CREATED", 2, false, _taskIcon, false] call BIS_fnc_taskCreate;

} foreach curMisTargets;

 
 runningSideMissions pushback [_misPos,_misSide,_misConf,_taskID,curMisTargets,_enemySide,_groups,_compobjs];
};

endSideMission =
{
 params ["_success",["_reason",""],["_completer",[]]];
 
 if(_misConf in deleteSideMissions) exitWith {}; // can end/delete only once
 
 curMisTargets = _misTargets;
 curMisSide = _misSide;
 curMisTaskID = _taskID;
 
 private _reward = getNumber(_misConf >> "reward");
 
 private _ts = "SUCCEEDED";
 private _sMsg = "Completed";
 if(!_success) then 
 {
 _ts = "FAILED";
 _sMsg = "Failed";
 }
 else
 {
 _completers = [];
 _helpers = [];
 
 _selectPlrs =
 {
   !isnull _x && isplayer _x && side _x == curMisSide // Ignore killers of other side
 };
 
 if(count curMisTargets > 0) then
 {
 _completers = curMisTargets apply { _x getVariable ["killedBy",objNull] };

 _completers = _completers select _selectPlrs;

 };
 
 // If group completer override _completers
 if(typename _completer == "GROUP") then
 {
 _completers = (units _completer) select _selectPlrs;
 }
 else // Helpers only in non-group mission
 {
 
 if(count curMisTargets > 0) then
 {
 _mispos = curMisTargets # 0; // Use first target
 
  // Type-Include list would be sufficient
 _helpers = entities [["CAManBase"], ["Logic","Air"], true, true];
 // diag_log (str _helpers);
 _helpers = _helpers select { alive _x && isplayer _x && (_x distance2D _mispos) < SIDE_MIS_MAX_HELPER_DIST && side _x == curMisSide && !(_x in _completers) };
 };
 
 };
 
  [_misConf,_reward,_completers,_helpers] call onSideMissionComplete;
 };
 
 [curMisTaskID,_ts] call BIS_fnc_taskSetState;
 
 // Delete task entry after awhile
[_taskID,_misSide,_misPos,_compobjs,_defenders] spawn
{
 params ["_taskID","_misSide","_misPos","_compobjs","_defenders"];
 sleep 3;
 //systemchat format [">> %1",_this];
 [_taskID,_misSide] call BIS_fnc_deleteTask;
 

 if(isnil "_misPos") then { "_misPos invalid" call errmsg; }; // making sure

 if(count _defenders > 0) then
 {
 // Wait a while before deleting defenders
 waituntil { sleep 30; !([_misPos, _misSide, ENEMY_NEAR_DISTANCE / 2] call isEnemyNear) };

 // Delete defending groups...
 { _x call deleteGroupInstantly } foreach _defenders;
 };
 
 // Delete objects, last
 { _x call safeDeleteAny; } foreach _compobjs;
};

 //if(_reason != "") then { _reason = "" + _reason; };
 
 [format["Mission %1: %2. %3",_sMsg,getText (_misConf >> "desc"),_reason],curMisSide] call userMessage;
 
 deleteSideMissions pushback _misConf;
};


smSetTaskInfo =
{
params ["_info"];

private _taskDesc = _taskID call BIS_fnc_taskDescription;
_taskDesc params ["_desc", "_title", "_marker"];

private _desc = _desc # 0; // in array Bug??

// diag_log format [">> %1 %2 %3 %4",_taskDesc,_objective,_desc,_title];

if(_info == _desc) exitWith {}; // Already set

[_taskID,[_info,_title,""]] call BIS_fnc_taskSetDescription;

};

processSideMissions =
{
 
 // First delete
 {
 _misConf = _x;
 
 _delIndex = _misConf call smGetMissionIndex;
  _misToDelete = runningSideMissions # _delIndex;
  _misToDelete params SIDEMIS_PARAMS;
  
  {
   if(getNumber(_misConf >> "removeActions") == 1) then
   {
   _x remoteExecCall ["smRemoveAction",_misSide];
   };
   if(getNumber(_misConf >> "deleteTargets") == 1) then
   {
   _x call safeDelete;
   };
  
  } foreach _misTargets;
  
  // systemchat "Deleting";
  
  runningSideMissions deleteAt _delIndex;
  
  _misSide call onSideMissionEnded;
  
 
 } foreach deleteSideMissions;
 
 deleteSideMissions = [];
 
 
 // Run the side missions
 for "_i" from (count runningSideMissions - 1) to 0 step -1 do
 {
  private _t = runningSideMissions select _i;
  _t params SIDEMIS_PARAMS; // Todo _misConf works on load?
  
   curMisTargets = _misTargets;
   curMisSide = _misSide;
   curMisTaskID = _taskID;
   _curMisConf = _misConf;
   _curMisDefenders = _defenders;
  // _deleteCurTask = false;
   
 //  player sidechat ("LOOP " + (getText(_misConf >> "loop")));
  
  call compile (getText (_misConf >> "loop"));
  

 };
 
};


smInitMission =
{
 params ["_misConf","_enemySide"];
 
 private _targetTypes = getArray(_misConf >> "targetTypes");
 
 private _numTargets = (_misConf >> "targetsMax") call smGetNumber;
 
_misPos = curMisPos;


 private _existingObjs = [];
 private _comp = getText (_misConf >> "composition");
 if(_comp != "") then
 {
  private _mret = [_misPos, 0,_comp,_misSide] call objMapper;
  _existingObjs = _mret select 0;
  
  _compobjs = _existingObjs;
  
  {
  // Register mission required targets
  if(typeof _x in _targetTypes) then
  {
   curMisTargets pushback _x;
  };
  } foreach _existingObjs;
 };
 
 // Do not create target objects already created from composition
 {
  private _type = typeof _x;
  if(_type in _targetTypes) then
  {
  _targetTypes = _targetTypes - [_type];
  };
 } foreach _existingObjs;
 
_targetSide = civilian;

if(getNumber (_misConf >> "targetIsDefender") == 1) then
{
 _targetSide = _enemySide;
};

_misGroup = createGroup _targetSide;

if(count _targetTypes > 0) then
{

for "_i" from 1 to _numTargets do
{
private _type = selectRandom _targetTypes;

_target = objNull;
if(_type isKindOf "Man") then
{

_target = _misGroup createUnit [_type, _misPos, [], 0, "NONE"];

[_target] joinSilent _misGroup;

// hint format["Creating! %1 %2 %3",_targetSide, side _target, side (group _target) ];

_target setUnitPos "UP";

// For now target men dont have any weapons
removeAllWeapons _target;

}
else
{
_target = createVehicle [_type, _misPos, [], 0, "NONE"]; 
};

//[_captive,true] call toggleCaptive;

if(isNull _target) exitWith { systemchat "Failed to create target"; };

curMisTargets pushback _target;
};

{
_x addEventHandler ["killed", 
{
params ["_misTarget", "_killer", "_instigator", "_useEffects"];

_rewardTo = _instigator;

// Reward player not the AI
if(!isPlayer _rewardTo) then
{
   _lead = leader _rewardTo;
   if(isPlayer _lead) then
   {
    _rewardTo = _lead;
   };
};

_misTarget setVariable ["killedBy", _rewardTo];

}
];


} foreach curMisTargets;

};

if(count units _misGroup == 0) then
{
 deleteGroup _misGroup; // Delete if not used
};
 
};

smGetRunningMissionsForSide =
{
params ["_getSide"];

private _misRunning = runningSideMissions select 
{
_x params SIDEMIS_PARAMS;
(_misSide == _getSide)
};

_misRunning
};

smGetRunningMissionTypesForSide =
{
 params ["_side"];
 private _ret = [];
 private _missions = _side call smGetRunningMissionsForSide;
 {
 _x params SIDEMIS_PARAMS;
 
 _ret pushbackunique (configname _misConf);
 
 } foreach _missions;
 _ret
};

smGetNearTargetPlayer =
{
scopename "gntp";
params ["_maxDist"];

private _plrs = (call getPlayers) select { side _x == curMisSide };

{
private _plr = _x;

_numNear = { _x distance2D _plr < _maxDist } count curMisTargets;
if(_numNear > 0) then
{
_plr
breakout "gntp";
};

} foreach _plrs;

objNull
};

smAreTargetsInDestination =
{
 private _destFn = call compile (getText(_curMisConf >> "destinationFn"));
 
 private _targets = curMisTargets select { alive _x }; // Count only alive

 private _numArrived = { [curMisSide,getpos _x] call _destFn; } count _targets;
 
 _numArrived == (count _targets)
};

smPercentTargetsDone =
{
 params ["_areAlive"];
 private _numAlive = { alive _x } count curMisTargets;
 private _ret = 0;
 if(_areAlive) then
 {
  _ret = _numAlive / (count curMisTargets);
 }
 else
 {
  _ret = ((count curMisTargets) - _numAlive) / (count curMisTargets);
 };
 _ret
};

smNumTargetsAlive =
{
 ({ alive _x } count curMisTargets)
};

smGetNumber =
{
 params ["_conf"];
 private _ret = 0;
 
 if(isNumber _conf) then
 {
  _ret = getNumber _conf;
 }
 else
 {
 private _script = getText _conf;
 if(_script == "") exitWith { systemchat "smGetNumber no text!"; };
 
 _ret = call compile _script;
 
 };
 
  _ret
};

smGetMissionByTarget =
{
 params ["_target"];
 private _ret = [];
 
 {
  private _mis = _x;
  _mis params SIDEMIS_PARAMS;
  
  {
  
  if(_x == _target) then
  {
   _ret = _mis;
  };
  
  } foreach _misTargets;
  
 } foreach runningSideMissions;
 
 _ret
};

smGetMissionIndex =
{
 params ["_misConfToLook"];
 private _deleteIndex = -1;
 {
  _x params SIDEMIS_PARAMS;
  if(_misConf == _misConfToLook) exitWith
  {
  _deleteIndex = _forEachIndex;
  };
 } foreach runningSideMissions;
 _deleteIndex
};
