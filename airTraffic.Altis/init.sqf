
#define prepro Compile preprocessFileLineNumbers

getAngle = prepro "math\getAngleFn.sqf";
getVecLength = prepro "math\getVecLengthFn.sqf";
getVecDir = prepro "math\getVecDirFn.sqf";
getvector = prepro "math\getvectorFn.sqf";
addvector = prepro "math\addVecFn.sqf";



_h = execvm "deps.sqf";
waituntil { scriptdone _h };

if(isServer) then
{
_h = execvm "airTraffic.sqf";
//waituntil { scriptdone _h };
};

if(hasInterface) then
{
_h = execvm "client.sqf";
waituntil { scriptdone _h };
};


if(isServer) then
{
// Test
//testplane call registerAirtraffic;



sleep 0.1;

// testplane call landPlane;
};

// sleep 2;
/*
checkAutoPilot =
{
 systemchat format[">> %1", _this # 3];
};
*/
//inGameUISetEventHandler ["Action", "_this call checkAutoPilot"];

//inGameUISetEventHandler ["PrevAction", "hint str _this; false"];
//inGameUISetEventHandler ["NextAction", "hint str _this; false"];

