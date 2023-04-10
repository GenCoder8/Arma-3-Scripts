
#include "airTraffic.h"


#define COLOR_NOTAVAILABLE "#FF0000"
#define COLOR_AVAILABLE    "#FFFFFF"
#define COLOR_USING        "#00FF00"


private _grp = createGroup sideLogic; 
airTrafficControl = _grp createUnit ["Logic", [-1000,1000], [], 0, "NONE"]; 

airTrafficChannel = radioChannelCreate [[52, 149, 235, 255] call colNumToFloat, "Airtraffic control", "%CHANNEL_LABEL", [airTrafficControl]];


inGameUISetEventHandler ["Action", "_this call checkAutoPilot"];

waituntil { ! isnil "airTrafficChannel" };
airTrafficChannel radioChannelAdd [player];


airtrafficControlMsg =
{
 params ["_msgId"];

 _atMsg = switch (_msgId) do 
 {
  case AIRT_MSG_FREE_TO_LAND: { "You are free to land" };
  case AIRT_MSG_RUNWAY_FULL: { "Runway is full" };
  case AIRT_MSG_NO_AIRFIELD: { "No runway nearby for landing" };
 };

 airTrafficControl customChat [airTrafficChannel, _atMsg];
};


checkAutoPilot =
{
 params ["","_plr","","_actionName"];
 
 if(!(_actionName in ["Land","CancelLand"])) exitWith  { false };

 private _runwayState = _plr getVariable ["runwayState",-1];

 if(_runwayState == RUNWAY_STATE_FAR) then
 {
  // hintsilent "No runway nearby";
 };
 
 private _canLand = _runwayState == RUNWAY_STATE_CLEAR;

if(_canLand) then
{
 _this remoteExecCall ["useAutoPilot",2];
};

 // systemchat format [">>>>> %1 %2 %3",_canLand, _plr getVariable "runwayState", RUNWAY_STATE_CLEAR ];
 
 !_canLand
};




[] spawn
{

while { true } do
{
 _plane = vehicle player;
 _pilot = player;
  
 private _runwayState = _pilot getVariable ["runwayState",-1];
 if(_runwayState > 0 && !isnull _plane && _plane iskindof "plane") then
 {
  private _runwayDesc = _pilot getVariable ["runwayName",[false,"",0]];
  _runwayDesc params ["_isCarrier","_locName","_afPos"];

if(isnil "afMarker") then
{
_marker = createMarkerLocal ["nearestAFMarker", getposASL _plane];

_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "mil_end";

_marker setMarkerColorLocal "ColorBlue";
_marker setMarkerSizeLocal [1.75,1.75];

afMarker = _marker;
};
  
 _color = COLOR_NOTAVAILABLE;
 _msg = "Runway busy";
 afMarker setMarkerColorLocal "ColorRed";

 if(_runwayState == RUNWAY_STATE_CLEAR) then
 {
 _color = COLOR_AVAILABLE;
 _msg = "Runway clear";
 afMarker setMarkerColorLocal "ColorBlue";
 };
 if(_runwayState == RUNWAY_STATE_LANDING) then
 {
 _color = COLOR_USING;
 _msg = "Landing";
 afMarker setMarkerColorLocal "ColorGreen";
 };
 if(_runwayState == RUNWAY_STATE_ONRUNWAY) then
 {
 _color = COLOR_USING;
 _msg = "The runway is yours";
  afMarker setMarkerAlphaLocal 0;
 };

 _img = "\a3\ui_f_jets\data\gui\cfg\hints\ilsapproach_ca.paa";
 
 if(_isCarrier) then
 {
 _img = "\a3\ui_f_jets\data\gui\cfg\hints\aircraftlandcarrier_ca.paa";
 };


afMarker setmarkerPosLocal _afPos;

 hintSilent parseText format["<t color='%2'>Nearby %1:<br/>Distance: %5 m<br/>%3 <t size='5'><img image='%4'></img></t></t>",_locName, _color, _msg, _img, ceil (_plane distance2d _afPos) ];
 }
 else
 {
  if(!isnil "afMarker") then
  {
   deleteMarkerlocal afMarker;
   afMarker = nil;
  };

 hintSilent "";
 };
 
 sleep 1;
};

};