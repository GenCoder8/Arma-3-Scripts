
#define VALID_BINOCULARS ["Rangefinder","Binoculars"] // order important
#define SNIPER_MIN_RANGE 500


spotterLoop =
{

private _curTarget = objNull;

while { true } do
{

if(alive player && !([player,false] call inVehicle)) then
{

private _spotters = [];
private _hasSniperScope = false;

if(cameraView == "gunner") then
{
if((currentweapon player) != "" && (currentweapon player) == (primaryWeapon player)) then
{
private _scope = primaryweaponitems player # 2;

private _cfg = configfile >> "CfgWeapons" >> _scope >> "ItemInfo" >> "OpticsModes" >> (player getOpticsMode 1);

_hasSniperScope = (getnumber(_cfg >> "distanceZoomMax")) >= SNIPER_MIN_RANGE;
};
};

if(_hasSniperScope && alive cursortarget && cursortarget iskindof "CAManBase") then
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
 //hintsilent format ["> %1 %2 %3 %4", cursortarget, cameraView == "gunner", _spotters, (player getVariable ["isSniperScope",false])];

 if(count _spotters > 0) then
 {
  private _spotter = _spotters # 0;

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




