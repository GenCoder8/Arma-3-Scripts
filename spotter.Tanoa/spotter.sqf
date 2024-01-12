
#define VALID_BINOCULARS ["Rangefinder","Binoculars"] // order important


spotterLoop =
{

private _curTarget = objNull;
private _spotter = objnull;

while { true } do
{

if(alive player && !([player,false] call inVehicle)) then
{

private _units = (units player) select { !isplayer _x && !([_x,false] call inVehicle) };

// Get men with binoculars or rangefinder
private _spotters = _units select 
{
private _man = _x;
private _has = false;

{
 if(_man hasWeapon _x) exitwith { _has = true; };
} foreach VALID_BINOCULARS;

_has
};

// _spotter selectWeapon "Binoculars";

 // hintsilent format ["> %1 %2 ", cursortarget, cursorobject];
 hintsilent format ["> %1 %2 %3", cursortarget, cameraView == "gunner", _spotters];

 if(count _spotters > 0 && cameraView == "gunner" && alive cursortarget && cursortarget iskindof "CAManBase") then
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