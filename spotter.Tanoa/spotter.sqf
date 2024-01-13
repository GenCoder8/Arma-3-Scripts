
#define VALID_BINOCULARS ["Rangefinder","Binoculars"] // order important


spotterLoop =
{

private _curTarget = objNull;
private _spotter = objnull;

while { true } do
{

if(alive player && !([player,false] call inVehicle)) then
{

private _spotters = [];

if(cameraView == "gunner" && (player getVariable ["isSniperScope",false]) && alive cursortarget && cursortarget iskindof "CAManBase") then
{

private _units = (units player) select { !isplayer _x && !([_x,false] call inVehicle) };

// Get men with binoculars or rangefinder
 _spotters = _units select 
{
private _man = _x;
private _has = false;

{
 if(_man hasWeapon _x) exitwith { _has = true; };
} foreach VALID_BINOCULARS;

_has
};

};

// _spotter selectWeapon "Binoculars";

 // hintsilent format ["> %1 %2 ", cursortarget, cursorobject];
 hintsilent format ["> %1 %2 %3 %4", cursortarget, cameraView == "gunner", _spotters, (player getVariable ["isSniperScope",false])];

 if(count _spotters > 0) then
 {
  _spotter = _spotters # 0;

  private _range = VALID_BINOCULARS select { _spotter hasWeapon _x };

 if(count _range > 0) then // Would be weird at this point if none was found
 {
  _spotter selectWeapon (_range # 0);
 };

  if(_curTarget != cursortarget) then
  {
   _curTarget = cursortarget;

   private _dist = round (player distance _curTarget);

   if(_dist > 100) then
   {
   _spotter sidechat format ["Target %1 meters", _dist ];
   };

   sleep 2;
  };
 }
 else
 {
  _curTarget = objNull;
 };

};

 sleep 1;
};

};


setPlayerScopeStatus =
{
params ["_scope","_mode"];

private _cfg = configfile >> "CfgWeapons" >> _scope >> "ItemInfo" >> "OpticsModes" >> _mode;

player setVariable ["isSniperScope", ((getnumber(_cfg >> "distanceZoomMax")) >= 500) ];

};


player addEventHandler ["OpticsModeChanged",
{
 params ["_unit", "_opticsClass", "_newMode", "_oldMode", "_isADS"]; 

//systemchat (str _this);

if((currentweapon player) != "" && (currentweapon player) == (primaryWeapon player)) then
{
_scope = primaryweaponitems player # 2;

[_scope,_newMode] call setPlayerScopeStatus;

}
else
{
player setVariable ["isSniperScope", false];
};

// systemchat format[">>> %1 %2",  (player getVariable ["isSniperScope",false]), (getnumber(_cfg >> "distanceZoomMax")) ];

//systemchat format[">> %1 %2 -- %3 %4 %5", getnumber (_cfg >> "distanceZoomMax"), getnumber(_cfg >> "distanceZoomMin"), getnumber(_cfg >> "opticsZoomMax") , getnumber(_cfg >> "opticsZoomMin"), getnumber(_cfg >> "opticsZoomInit") ];

}];

// init
_scope = primaryweaponitems player # 2;
if(_scope != "") then
{
[_scope,player getOpticsMode 1] call setPlayerScopeStatus;
};




