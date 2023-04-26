#include "sideMain.h"

onSideMissionDefenderCreate =
{
 [east,[]]
};

smEnemyBaseFound =
{
{
 _x params SIDEMIS_PARAMS;
 
 // Todo was this enemy base?
 
 // if(_misSide != baseside) then
 
// systemchat format ["hmmm %1 %2",_misConf, (missionconfigfile >> "SideMissions" >> "ScoutArea") ];

if((_misConf) == (missionconfigfile >> "SideMissions" >> "ScoutArea")) then
{
 _fn = getText (_misConf >> "smOnScoutComplete");
 if(_fn != "") then
 {
 call compile _fn;
 };
 
};

} foreach runningSideMissions;
};

// modify this function for reward on completing mission
onSideMissionComplete =
{
 params ["_misConf","_reward","_completers","_helpers"];
 // Todo: Give money to player
 
 diag_log format ["SIDEMIS COMPLETE --> %1 - %2 - %3 - %4",configname _misConf, _completers, _helpers, floor time ];
 
};

onSideMissionEnded = 
{
params ["_side"]; 

_misRunning = _side call smGetRunningMissionsForSide;
};


// Modify this function for the destination of the captives
isBaseNear =
{
 params ["_side","_pos"];
 
 _pos distance2D heli < 15
};


[] spawn
{
while { true } do
{

if(isnil "runningSideMissions") then { continue; };

if([playerside,getpos player] call isBaseNear) then
{
 hint "base found";
 call smEnemyBaseFound;
};

sleep 1;
};
};


