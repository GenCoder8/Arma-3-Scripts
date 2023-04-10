


#include "airTraffic.h"


#define AF_AIRFIELD_INDEX         0
#define AF_AIRFIELD_CONFIG        1
#define AF_ISCARRIER              2
#define AF_GEOMETRY               3
#define AF_RUNWAY_CLEAR           4
#define AF_RUNWAY_OBSTACLES       5
#define AF_CURRENT_LANDING_PLANE  6
#define AF_CURRENT_LANDING_TIME   7



#define RUNWAY_GEO_MIDDLE 2

#define MAX_AUTO_LANDING_DIST  7500

#define AUTO_LANDING_TIMEOUT (60 * 3)

#define DEBUG_AIR_TRAFFIC false

registeredAirfields = [];


getNearestAirfieldId =
{
 params ["_nearTo",["_belowAf",true]];

 private _closestDist = 1e10;
 private _closestId = -1;

for "_priority" from 0 to 1 do
{
 private _onlyBelowAfs = _priority == 0;

 {
  private _af = _x;
  private _index = _forEachIndex;
  private _afPos = [_af] call getAirfieldPos;
 

 if(((_nearTo # 1) < (_afPos # 1)) || (([_af] call isAirfieldCarrier) || !_belowAf) || !_onlyBelowAfs) then
 {

  private _dist = _afPos distance2D _nearTo;
  if(_dist < _closestDist) then
  {
  _closestId = _index;
  _closestDist = _dist;
  };

 };


 } foreach registeredAirfields;

  if(_closestId >= 0) then { break; };

};

 _closestId
};

getNearestAirfieldIdOld =
{
 params ["_nearTo"];
 private _world = configfile >> "CfgWorlds" >> worldname;
 private _index = 0;
 private _closestDist = 1e10;
 private _closestId = -1;
 
for "_priority" from 0 to 1 do
{

 private _onlyBelowAfs = _priority == 0;

 _checkAF =
 {
  params ["_ilspos"];
  private _p = getArray _ilspos;

 if((_nearTo # 1) < (_p # 1) || !_onlyBelowAfs) then
 {

  private _dist = _p distance2D _nearTo;
  if(_dist < _closestDist) then
  {
  _closestId = _index;
  _closestDist = _dist;
  };

 };

  _index = _index + 1;
 };
 
 (_world >> "ilsPosition") call _checkAF;
 
 private _sec = _world >> "SecondaryAirports";
 
 for "_i" from 0 to (count _sec - 1) do
 {
  _ap = _sec select _i;
  (_ap >> "ilsPosition") call _checkAF;
 };
 
 private _carriers = (allAirports # 1);
 {
   private _dist = _x distance2D _nearTo;
  if(_dist < _closestDist) then
  {
  _closestDist = _dist;
  _closestId = _x;
  };
 } foreach _carriers;
 
 if(_closestId >= 0) then { break; };

};

 _closestId
};

getAirfieldCfg =
{
 params ["_afIndex"];
 private _ret = configNull;
 private _world = configfile >> "CfgWorlds" >> worldname;
 if(_afIndex == 0) then
 {
 _ret = _world;
 }
 else
 {
 private _sec = _world >> "SecondaryAirports";
 if((_afIndex - 1) < (count _sec)) then
 {
 _ret = _sec select ( _afIndex - 1 );
 
 };
 };
 
 _ret
};


 
 /*
_afIndex = [getpos player] call getNearestAirfieldId;
_afCfg = _afIndex call getAirfieldCfg;



afPos = getArray(_afCfg >> "ilsPosition");
afDir = getArray(_afCfg >> "ilsDirection");
afPos set [2,5];

runwayAngle = (([[0,0], [ (afDir # 0) , (afDir # 2) ]]) call getAngle) - 180;


afTaxiIn = getArray(_afCfg >> "ilsTaxiIn");
afTaxiOff = getArray(_afCfg >> "ilsTaxiOff");

_c = count afTaxiOff;
runwaysDist = [afTaxiIn#0,afTaxiIn#1] distance2D [afTaxiOff#(_c-2),afTaxiOff#(_c - 1)];

hint format["AF: %1 %2", _afIndex, _afCfg];
*/

cancelLanding =
{
params ["_plane"];

diag_log format ["cancelLanding %1 %2", (_plane call isLanding), _plane getVariable ["landingAtAf", -1]];

if(_plane call isLanding) then
{

_plane action ["cancelLand", _plane];

 private _afIndex = _plane getVariable "landingAtAf";
[_plane,_afIndex] call releaseRunway;
};

};

isLanding =
{
params ["_plane"];

 private _afIndex = _plane getVariable ["landingAtAf", -1];

 //if(typename _afIndex == "SCALAR") exitwith { _afIndex >= 0 };
 //(!isnull _afIndex)

 _afIndex >= 0
};

onLandingRequest =
{
 params ["_plane","_afIndex"];
 
 // Exit silently if already landing (Landing EH (gears lowered calls this))
 if(_plane call isLanding) exitwith { true }; // Todo ok?
 
 
 _af = _afIndex call getAirfield;
 
 private _approved = false;
 
// private _client = owner _plane;
 private _pilot = driver _plane;
 private _msgId = -1;
 
 // Close enough the airport?
 if((([_af] call getAirfieldPos) distance2D _plane) < MAX_AUTO_LANDING_DIST) then
 {
 
 _approved = _afIndex call requestLanding;
 
 // systemchat format["Landing approved: %1", _approved];
 
 if(_approved) then
 {
 [_plane,_afIndex] call grantRunway;
 
 _msgId = AIRT_MSG_FREE_TO_LAND;
 }
 else // Abort landing!
 {
  _msgId = AIRT_MSG_RUNWAY_FULL;
 };
 
 }
 else
 {
  _msgId = AIRT_MSG_NO_AIRFIELD;
 };
 
  // systemchat format["%1 %2 %3",clientOwner,(str _client), _plane];
  
  if(isPlayer _pilot) then
  {
  [_pilot,_msgId] call sendAtMsg;
  };
  
  _approved
};

sendAtMsg =
{
 params ["_pilot","_msgId"];

 _msgId remoteExecCall ["airtrafficControlMsg", _pilot];
};


useAutoPilot =
{
 params ["","_plr","","_actionName"];
 //systemchat format[">> %1 -- %2", _this, _actionName];
 
 _plane = vehicle _plr;
 _afIndex = [getposATL _plane] call getNearestAirfieldId;
 _af = _afIndex call getAirfield;
 
 _override = false;
 
 if(_actionName == "Land") then
 {
  _approved = [_plane,_afIndex] call onLandingRequest;
  
  if(!_approved) then
  {
  _override = true;
  };
 };
 if(_actionName == "CancelLand") then
 {
  _afIndex = _plane getVariable "landingAtAf"; // override, make sure its right AF
  _af = _afIndex call getAirfield;

  
  // Cancel landing if this plane is landing at the airfield (maybe pointless check)
  if(_plane == (_af # AF_CURRENT_LANDING_PLANE)) then
  {
   _plane call cancelLanding;
  }
  else
  {
   systemchat "Error, not landing";
  };
 };
 
 //_override
};


registerAirfield =
{
params ["_airportID","_afcfg"];

_start = [];
_end = [];
_middlePos = [];

//if(typename _afIndex == "SCALAR") then
_isCarrier = false;
_height = 0.25;
_posFix = [0,0,0];
if(isnull _afcfg) then // If carrier
{
_afcfg = configfile >> "CfgVehicles" >> "DynamicAirport_01_F"; // TODO same class for all carriers?
_posFix = getposASL _airportID; // Carrier needs pos fixed
_height = (_posFix # 2) + 0.25;
_isCarrier = true;
};

_afPos = getArray(_afCfg >> "ilsPosition");
_afPos = [_afPos,_posFix] call addvector;
_afDir = getArray(_afCfg >> "ilsDirection");
_afPos set [2,_height];

_runwayAngle = (([[0,0], [ (_afDir # 0) , (_afDir # 2) ]]) call getAngle) - 180;
 
_afTaxiOff = getArray(_afCfg >> "ilsTaxiOff");
_middlePos = [_afTaxiOff # 0, _afTaxiOff # 1];
_middlePos = [_middlePos,_posFix] call addvector;
_length = _afPos distance2D _middlePos;


_v = [_runwayAngle,_length * 2 + 175] call getvector; // Some extra space
_end = +_afPos;
_end = [_end,_v] call addvector;
_end set [2,_height];

_v = [_runwayAngle - 180,75] call getvector; // Some extra space
_start = [_afPos,_v] call addvector;
_start set [2,_height];


registeredAirfields pushback [_airportID,_afcfg,_isCarrier,[_start,_end,_middlePos],true,[],objNull,0];
};


registerAirtraffic =
{
params ["_plane"];

_plane addEventHandler ["Landing", 
{
 params ["_plane", "_airportID", "_isCarrier"];

 diag_log format [">>>>>>> Landing >>>>>> %1", _this];
 
  _afIndex = _airportID call getAirfieldIndex;

  _af = _afIndex call getAirfield;
  systemchat format ["TIME: %1", time - (_af # AF_CURRENT_LANDING_TIME)  ];
 
 _approved = [_plane,_afIndex] call onLandingRequest;
  if(!_approved) then
  {
  _plane call cancelLanding;
  };

}];
  
 // Player does not taxi
_plane addEventHandler ["LandedTouchDown", 
{
 params ["_plane", "_airportID"];
 if(isPlayer (driver _plane)) then
 {

  diag_log format ["LandedTouchDown %1", _this];

  // private _afIndex = _airportID call getAirfieldIndex;


  [_plane] call releaseRunway;
 };
}];

_plane addEventHandler ["LandedStopped", 
{
 params ["_plane", "_airportID"];
 
 systemchat "Releasing runway (LandedStopped)";
 
  //private _afIndex = _airportID call getAirfieldIndex;

  [_plane] call releaseRunway;
}];

_plane addEventHandler ["LandingCanceled", 
{
 params ["_plane", "_airportID"];
 
 systemchat format["Releasing runway (LandingCanceled) (%1)", isPlayer (driver _plane)];
 
  //private _afIndex = _airportID call getAirfieldIndex;

  [_plane] call releaseRunway;
}];

 _plane spawn playerRunwayInfo;
 
};



getAirfieldPos =
{
params ["_af"];

((_af # AF_GEOMETRY) # RUNWAY_GEO_MIDDLE)
};

isAirfieldCarrier =
{
params ["_af"];
 (_af # AF_ISCARRIER)
};


getAirfield =
{
 params ["_afIndex"];

 (registeredAirfields # _afIndex);
};

getAirfieldIndex =
{
 params ["_airportID"];

 private _ret = -1;

 {
  scopename "getAF";
  private _afIndex2 = (_x # AF_AIRFIELD_INDEX);
  if(typename _airportID == typename _afIndex2) then
  {
  if(_airportID == _afIndex2) then {
  _ret = _forEachIndex;
  breakout "getAF";
  };
  };
 } foreach registeredAirfields;

 _ret
};

isRunwayClearForLanding =
{
 params ["_af"];
 _curPlane = _af # AF_CURRENT_LANDING_PLANE;
 _runwayClear = _af # AF_RUNWAY_CLEAR;
 
 isnull _curPlane && _runwayClear
};

requestLanding =
{
 params ["_afIndex"];
 _af = _afIndex call getAirfield;
 
 // systemchat format ["dbg: %1 %2",_af,_afIndex];
 
 [_af] call isRunwayClearForLanding
};

grantRunway =
{
 params ["_plane","_afIndex"];

 _af = _afIndex call getAirfield;

 _af set [AF_CURRENT_LANDING_PLANE, _plane];
 _af set [AF_CURRENT_LANDING_TIME, time];
 
 _plane setVariable ["landingAtAf", _afIndex];
};

releaseRunway =
{
 params ["_plane"];

  private _afIndex = _plane getVariable ["landingAtAf",-1];

 diag_log format ["releaseRunway >>> %1 %2",_plane, _afIndex];

 if(_afIndex < 0) exitWith {}; // Already released

 _af = _afIndex call getAirfield;

 _af set [AF_CURRENT_LANDING_PLANE, objNull];
 
 _plane setVariable ["landingAtAf", -1];
};




debugDrawTaxiway =
{
params ["_way","_color"];

_c = count _way;
_lastP = [];
for "_i" from 0 to (_c - 1) step 2 do
{
_line1 = [_way # _i,_way # (_i + 1)];
_line1 set [2,5];

if(count _lastP > 0) then
{

drawLine3D [_lastP, _line1, [0,0,1,1]];
};

_lastP = +_line1;
};
};

if(DEBUG_AIR_TRAFFIC) then 
{
addMissionEventHandler ["Draw3D", 
{


{
_geo = _x # AF_GEOMETRY;
drawLine3D [_geo # 0, _geo # 1, [1,0,0,1]];
} foreach registeredAirfields;


// [afTaxiOff, [0,1,0,1] ] call debugDrawTaxiway


}];
};

playerRunwayInfo =
{
params ["_plane"];

_pilot = driver _plane;

_pilot setVariable ["runwayState",-1];
_pilot setVariable ["runwayName",[false,""]];

_setRunwayState =
{
params ["_newState","_isCarrier","_desc","_dist"];
_curState = _pilot getVariable "runwayState";
if(_curState != _newState) then
{
_pilot setVariable ["runwayState",_newState,true];


};
_curDesc = _pilot getVariable "runwayName";
if(!((_curDesc # 0) isEqualto _isCarrier) || (_curDesc # 1) != _desc) then
{
_pilot setVariable ["runwayName",[_isCarrier,_desc,_dist],true];

//systemchat format ["TEST: %1", _af];
};
};

while { alive _plane } do
{
 private _pilot = driver _plane;

 if(alive _pilot && isPlayer _pilot) then
 {
 private _afIndex = _plane getVariable ["landingAtAf", -1]; // Get info on landed AF

 if(_afIndex == -1) then
 {
 _afIndex = [getposATL _plane, !(isTouchingground _plane) ] call getNearestAirfieldId; // Get info on nearest AF
 };

 private _af = _afIndex call getAirfield;
 
 private _afPos = [_af] call getAirfieldPos;
 if((_afPos distance2D _plane) < MAX_AUTO_LANDING_DIST) then
 {
 
private _locations = nearestLocations [_afPos, ["NameCityCapital","NameCity","NameVillage","FlatAreaCity","FlatAreaCitySmall"], MAX_AUTO_LANDING_DIST];

private _locName = "";
{
if(text _x != "") exitwith
{
_locName = text _x;
}; 
} foreach _locations;

// systemchat format ["_locName = '%1' %2", _locName, count _locations];
 
 private _desc = "";
 private _isCarrier = false;
 
 if(_locName != "") then
 {
 _desc = _locName;
 };
 
 if([_af] call isAirfieldCarrier) then
 {
 _isCarrier = true;
 _desc = "Carrier";
 };

 private _otherObstacle = (_af # AF_RUNWAY_OBSTACLES) - [_plane];

 private _case = switch(true) do
 {
  case (_af # AF_CURRENT_LANDING_PLANE == _plane): { RUNWAY_STATE_LANDING };
  case ([_af] call isRunwayClearForLanding): { RUNWAY_STATE_CLEAR };

  //
  case (!(_af # AF_RUNWAY_CLEAR) && count _otherObstacle > 0 ): { RUNWAY_STATE_BUSY };

  // If player is alone on runway
  case (!(_af # AF_RUNWAY_CLEAR) && _plane in (_af # AF_RUNWAY_OBSTACLES) ): { RUNWAY_STATE_ONRUNWAY };


  default { RUNWAY_STATE_CLEAR };
 };
 
 [_case,_isCarrier,_desc,_afPos] call _setRunwayState;
 
 }
 else
 {
 [RUNWAY_STATE_FAR,false,"",0] call _setRunwayState;
 };
 
 };
 
 sleep 2;
 };
};



//_afIndex = (allAirports # 1) # 0; // [getpos testplane] call getNearestAirfieldId;
//testplane landAt _afIndex;
//hint format["LANDING !  %1", _afIndex ];

// For AI
landPlane =
{
 params ["_plane"];

 if(isPlayer (driver _plane)) exitwith { systemchat "landPlace only for AI planes"; };
 
 private _afIndex = [getposATL _plane] call getNearestAirfieldId;
 private _af = _afIndex call getAirfield;
 
 private _approved = [_plane,_afIndex] call onLandingRequest;
  
 if(_approved) then
 {
 _plane landAt (_af # AF_AIRFIELD_INDEX);
 };
};







// Get all airfields

_airfields = allAirports # 0;

{
_airportID = _x;

_afIndex = _forEachIndex;

_afcfg = _afIndex call getAirfieldCfg;

[_airportID,_afcfg,objNull] call registerAirfield;

} foreach _airfields;

// Get carriers
_carriers = allAirports # 1;
{
[_x,configNull] call registerAirfield;
} foreach _carriers;












// Main loop

lastAirTrafficTime = -1e10;

addMissionEventHandler ["EachFrame",
{

if((time - lastAirTrafficTime) < 1 && time >= 5) exitWith {};

lastAirTrafficTime = time;

 {
 _af = _x;
 _af params ["_afIndex","_afcfg","_isCArrier","_geometry","_runwayClear","_obstacles","_curLandingPlane","_curLandingTime"];
 


_runwayClear = true;

_vehs = vehicles select { _x distance2D (_geometry # 2) < 1000 && _x != _curLandingPlane }; // Get vehs near the AF


_runwayZ = _geometry # 0 # 2;

private _blockingVehs = [];

{
scopename "checkRunway";
_veh = _x;
_vehZ = (getPosASL _veh) # 2;

// Check if vehZ is above the runway (For carriers)
if( _vehZ > (_runwayZ - 1) && _veh != _curLandingPlane ) then
{

_p = [_geometry # 0,_geometry # 1,getposATL _veh,false] call BIS_fnc_nearestPoint;

// diag_log format ["near one: %1", _p distance _veh];

if(_p distance _veh <= (25 + 7)) then // Check distance with half size add (todo get accurate veh size)
{
_runwayClear = false;
_blockingVehs pushback _veh;
//breakout "checkRunway";
};
};

} foreach _vehs;

// diag_log format ["AF CHECK >>>> %1 %2 %3",_afIndex,  _vehs, _runwayClear];

_af set [AF_RUNWAY_CLEAR, _runwayClear];
_af set [AF_RUNWAY_OBSTACLES, _blockingVehs];



if(!isnull _curLandingPlane) then
{
 private _planeZ = (getposATL _curLandingPlane) # 2;
 if(_isCarrier) then
 {
  _planeZ = (getposASL _curLandingPlane) # 2;
 };

if(isplayer (driver _curLandingPlane)) then
{
 // systemchat format ["hmmmmm %1   %2   %3 <= %4   %5", (driver _curLandingPlane),_isCarrier, _planeZ, _runwayZ + 1, (speed _curLandingPlane)];
};

 // Destroyed / ejected / timed out
 if((_planeZ <= (_runwayZ + 1) && (speed _curLandingPlane) < 30) || !_runwayClear || !alive _curLandingPlane || !(alive (driver _curLandingPlane)) || (time - _curLandingTime) > AUTO_LANDING_TIMEOUT ) then
 {
  systemchat format["Landing plane dead / runway taken %1 %2" ,_curLandingPlane, (time - _curLandingTime)];
  
 //[_curLandingPlane,_afIndex] call releaseRunway;
 _curLandingPlane call cancelLanding;
};
};


if(DEBUG_AIR_TRAFFIC) then
{
 _idx = [(getpos player)] call getNearestAirfieldId;
 if(typename _afIndex == typename _idx) then
 {
 if(_idx == _afIndex) then
 {
 hintSilent format[">> %1\n%2\n%3\n%4", _idx, ((_geometry # 2) distance2D player), _runwayClear, _curLandingPlane];
 };
 };
};
 
 } foreach registeredAirfields;

}];




