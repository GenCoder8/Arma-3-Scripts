

targetClients =
{
 ([0,-2] select isdedicated)
};


_h = execvm "doorBreaching.sqf";
waituntil { scriptdone _h };



if(!isServer) exitWith {};





//_bldg = nearestBuilding (getmarkerpos "testb");
//_bldg call lockHouse;



_bldg = nearestBuilding player;
_i = 1; // The door number in front of player is 5
 private _sel = format["Door_%1", _i];

[_bldg,"<t color='#FFFF00'>Test!</t>",
{
 params ["_target", "_caller", "_actionId", "_arguments"];

 hint "test";
},
[],format["true",_i],_sel] call addHouseAction;




