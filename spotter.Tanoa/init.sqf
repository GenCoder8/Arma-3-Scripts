
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


[] spawn spotterLoop;
