
_h = execvm "spotter.sqf";
waituntil { scriptdone _h };


inVehicle =
{
 params ["_man",["_canBeParachute",true]];
 private _inVeh = (vehicle _man) != _man;

 if(!_canBeParachute) then
 {
  if((vehicle _man) call isVehParachute) then { _inVeh = false; };
 };

 _inVeh
};

isVehParachute =
{
 ((tolower (typeof _this)) find "parachute") >= 0
};

ishostile = { true };

playSoundToPlayer =
{
params ["_soundFile","_volume",["_pitch",1]];

private _handle = playSound3D [_soundFile, player, false, getPosASL player, _volume, _pitch, 0, 0, true]; 

_handle
};


[] spawn spotterLoop;
