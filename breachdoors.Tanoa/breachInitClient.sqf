
dooBreachingInitBldgClient =
{
params ["_bldg"];

waituntil { sleep 0.1; !isnil "registerLockedHouse" };

_bldg call registerLockedHouse;
};