#include "dbgDefines.h"


getDbgStatsIdc =
{
 params ["_ctrlName"];

 getNumber (missionConfigFile >> "DbgStatsDialog" >> "controls" >> _ctrlName >> "idc")
};

getDbgStatsCtrl =
{
 params ["_ctrlName"];

 private _idc = _ctrlName call getDbgStatsIdc;

 private _display = findDisplay DBGSTATSDLG;

 _display displayctrl _idc
};

// maxStrengthPerSide = 0;

#define DEBUGABLE_SIDES [east,west,resistance,civilian]

openDbgStatsDlg =
{
 createDialog "DbgStatsDialog";

dbgStatsUpdate = [] spawn
{
 _display = displayNull;

 waituntil {
 sleep 0.1;
 _display = findDisplay DBGSTATSDLG;
  !isnull _display
 };
 
 _sidesCtrl = _display displayCtrl 2100;

 _sidesCtrl lbadd "ALL";

 {
  _sidesCtrl lbadd (str _x);
 } foreach DEBUGABLE_SIDES; // must be same order as in getSideIndex
 
 dbgSelectedSide = 0;
 
 _sidesCtrl lbSetCurSel 0;

while { true } do
{

 call dbgUpdate;
 
 sleep (5 * clientSleepMul);
};

};

responseScript = [] spawn
{
 _display = findDisplay DBGSTATSDLG;
 
 _respTimeText = _display displayCtrl 1000;

 _respTimeText ctrlSetText "";

#define RESP_WAIT 3

 lastResponse = time;
 while { true } do
 {
  sleep RESP_WAIT;
  
  _respTime = time - lastResponse - RESP_WAIT;
  
  _respTimeText ctrlSetText format["Script response time: %1 s", _respTime];
  
  lastResponse = time;
  
 };
};

 call chartInit;

};

dbgSides = [];

dbgSetCountedSides =
{
 dbgSides = _this;
};

dbgIsCountedSide =
{
 if(_this == sidelogic) exitWith { false };

 (count dbgSides == 0) || (_this in dbgSides)
};

dbgGetAllMen =
{
 allunits select { _x == (vehicle _x) && (side _x) call dbgIsCountedSide && !isplayer _x };
};

dbgGetAllVehicles =
{
 vehicles select { (side _x) call dbgIsCountedSide && !isplayer (driver _x) };
};

isVehicleDriveable =
{
 !(_this isKindof "StaticWeapon") && (_this isKindof "AllVehicles")
};

dbgUpdate =
{
 _display = findDisplay DBGSTATSDLG;
 
 _usedArmyStrength = _display displayCtrl 1201;
 
 _usedStrengthText = _display displayCtrl 1001;
 
 
 _spawnedInfText = _display displayCtrl 1002;
 _spawnedVehText = _display displayCtrl 1004;
 
 _numGroupsText = _display displayCtrl 1003;

 _countSides = [];
 
 if(dbgSelectedSide > 0) then
 {
  _countSides = [DEBUGABLE_SIDES # (dbgSelectedSide - 1) ];
 };

 _countSides call dbgSetCountedSides;
 
_countTheseSides =
{
 if(_this == sidelogic) exitWith { false };

 (count _countSides == 0) || (_this in _countSides)
};

_isPlayerUnit =
{
 isplayer (leader (group _this))
};
 
_usedArmyS = 0;
if(dbgSelectedSide < (count armySizes)) then
{
 _usedArmyS = armySizes select dbgSelectedSide;
};

 _usedArmyStrength progressSetPosition (_usedArmyS / maxStrengthPerSide);
 
 _usedStrengthText ctrlSetText format["Used strength: %1 / %2",  _usedArmyS, maxStrengthPerSide];
 
 _allMen = call dbgGetAllMen;

 _spawnedInfText ctrlSetText format["Spawned infantry: %1 (%2)",  count _allMen, { _x call _isPlayerUnit } count _allMen];

 _allVehs = call dbgGetAllVehicles;

 _driveableVehs = _allVehs select { _x call isVehicleDriveable };
 _usedVehs = _driveableVehs select { alive (driver _x) };
 
 _numStaticWeaps = { _x isKindof "StaticWeapon" } count _allVehs;
 
 _spawnedVehText ctrlSetText format["Spawned vehicles: %1 (%2)", count _driveableVehs, { _x call _isPlayerUnit } count _driveableVehs];
 
 ctrlSetText [1005,format["Vehicles in use: %1" , count _usedVehs ]];
 
 _air = _driveableVehs select { _x isKindof "Air" };
 ctrlSetText [1007,format["Num air: %1 / %2", {alive (driver _x)} count _air , count _air]];
 _land = _driveableVehs select { _x isKindof "land" };
 ctrlSetText [1008,format["Num land: %1 / %2", {alive (driver _x)} count _land , count _land]];
 _ship = _driveableVehs select { _x isKindof "Ship" };
 ctrlSetText [1009,format["Num water: %1 / %2", {alive (driver _x)} count _ship , count _ship]];
 
 
 ctrlSetText [1006,format["Static weapons: %1" ,_numStaticWeaps]];
 
 _allGroups = allgroups select { (side _x) call _countTheseSides };

 _numSpawnedGroups = { count (units _x) > 0 } count _allGroups;

 _numGroupsText ctrlSetText format["Total groups: %1 / %2", count _allGroups, 288 ];


 ctrlSetText [1010,format["Num  spawned groups: %1", _numSpawnedGroups]];

 ctrlSetText [1011,format["Num  empty groups: %1", (count _allGroups) - _numSpawnedGroups]];

  // ctrlSetText [1011,format[" %1 / %2", count allgroups]];


_fpsText = "FPStext" call getDbgStatsCtrl;
_fpsStr = "FPS: ";

 if(fpsShowing) then
 {
  _fpsStr = _fpsStr + format["Server: %1 ", lastServerFPS];
 };

 _fpsStr = _fpsStr + format["Client: %1 ", round diag_fps];

_fpsText ctrlSetText _fpsStr;
  

};

dbgSelectSide = 
{
 params ["_control", "_selectedIndex"];
 
 dbgSelectedSide = _selectedIndex;
 
 call dbgUpdate;
};



fpsShowing = false;
toggleShowFPS =
{
 fpsShowing = !fpsShowing;
 
 fpsShowing remoteExec ["toggleFPSServer",2];

 ("ShowServerFPS" call getDbgStatsCtrl) ctrlSetText (["Show FPS","Hide Server FPS"] select fpsShowing);
 
};

 lastServerFPS = 0;

serverReportingFPS =
{
 params ["_serverFPS"];

 lastServerFPS = _serverFPS;
};

closeDbgStatsDlg =
{
 closeDialog 0;
};

onCloseDbgStatsDlg =
{

terminate responseScript;

terminate dbgStatsUpdate;

};


_h = execvm "dbgStats\chart.sqf";
waituntil { scriptdone _h };

