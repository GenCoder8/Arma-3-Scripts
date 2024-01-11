
_h = execvm "spotter.sqf";
waituntil { scriptdone _h };

[] spawn spotterLoop;
