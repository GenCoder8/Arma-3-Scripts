
_h = execvm "deps.sqf";
waituntil { scriptdone _h };

_h = execvm "dbgStats\dbgStats.sqf";
waituntil { scriptdone _h };

[east,west,resistance] call dbgSetCountedSides;

armySizes = [];
{

armySizes pushback 0;

} foreach [east,west,resistance];


clientSleepMul = 1;
maxStrengthPerSide = 100;

sleep 0.1;

call openDbgStatsDlg;
