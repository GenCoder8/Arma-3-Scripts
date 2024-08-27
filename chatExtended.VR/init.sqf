
getSideIndex = 
{
 switch (_this) do
 {
  case east: { 0 };
  case west: { 1 };
  case resistance: { 2 };
  case civilian: { 3 };

  default { -1 };
 };
};


_h = execvm "chatExt.sqf";

waituntil { scriptdone _h };

sleep 0.01;

waituntil { ! isnull (findDisplay 46) };

call chatExtOpen;