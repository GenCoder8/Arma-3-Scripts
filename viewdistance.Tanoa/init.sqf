
execvm "viewDistance.sqf";


sleep 0.1;

call updateViewDistance;

call settingsOpen;


player addEventHandler ["GetInMan", 
{
 params ["_plr", "_role", "_veh", "_turret"];

 call updateViewDistance;

}];



player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret", "_isEject"];

 call updateViewDistance;
}];
