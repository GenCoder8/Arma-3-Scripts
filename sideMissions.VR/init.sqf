
#define prepro Compile preprocessFileLineNumbers



objMapper = Compile preprocessFileLineNumbers "objectMapperFn.sqf";


if(isServer) then
{
_h = execvm "sideMissions\misScripts.sqf"; // Server 
waituntil { scriptdone _h };
};

if(hasInterface) then
{
_h = execvm "sideMissions\misClient.sqf"; // Client
waituntil { scriptdone _h };
};

_h = execvm "sideMissions\misDeps.sqf"; // Both client & server
waituntil { scriptdone _h };

_h = execvm "sideMissions\misImplement.sqf"; // Both client & server
waituntil { scriptdone _h };



_h = execvm  "sideMissions\main.sqf";
waituntil { scriptdone _h };


if(isServer) then
{
 // Creates side missions for players of side west
 
//[getmarkerpos "misCap",west,"RescuePilot"] call startSideMission;

[getmarkerpos "misCap",west,"FreeCaptives"] call startSideMission;

// [getmarkerpos "off",west,"CaptureOfficer"] call startSideMission;

//[getmarkerpos "misCap",west,"FreeCaptives"] call startSideMission;
/*
[getmarkerpos "misLaptop",west,"AccessComputer"] call startSideMission;
[getmarkerpos "misRadar",west,"DestroyRadar"] call startSideMission;

[getmarkerpos "tmis",west,"EliminateEnemy"] call startSideMission;

//[getmarkerpos "scout",west,"ScoutArea"] call startSideMission;

[getmarkerpos "off",west,"CaptureOfficer"] call startSideMission;
*/
while { true } do
{

call processSideMissions;

sleep 1;
};

};

