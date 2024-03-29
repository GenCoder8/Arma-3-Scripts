
_h = execvm "viewDistance.sqf";

waituntil { scriptdone _h };

sleep 0.01;

call updateViewDistance;

call settingsOpen;

// Persistent on respawn
player addEventHandler ["GetInMan",
{
 params ["_plr", "_role", "_veh", "_turret"];

 call updateViewDistance;

}];


// Persistent on respawn
player addEventHandler ["GetOutMan",
{
 params ["_plr", "_role", "_veh", "_turret", "_isEject"];

 call updateViewDistance;
}];
