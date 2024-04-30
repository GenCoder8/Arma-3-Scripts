
#define VALID_BINOCULARS ["Rangefinder","Binoculars"] // order important
#define SNIPER_MIN_RANGE 500


spotterLoop =
{

private _curTarget = objNull;

while { true } do
{

if(alive player && { !([player,false] call inVehicle) } ) then
{

private _spotters = []; // Spotters retrieved only if all conditions fulfilled
private _hasSniperScope = false;

if(cameraView == "gunner") then
{
if((currentweapon player) != "" && (currentweapon player) == (primaryWeapon player)) then
{
private _scope = primaryweaponitems player # 2;

private _cfg = configfile >> "CfgWeapons" >> _scope >> "ItemInfo" >> "OpticsModes" >> (player getOpticsMode 1);

// hintsilent format ["Dist: %1", getnumber(_cfg >> "distanceZoomMax") ];

_hasSniperScope = (getnumber(_cfg >> "distanceZoomMax")) >= SNIPER_MIN_RANGE;
};
};

if(_hasSniperScope && alive cursortarget && cursortarget iskindof "CAManBase" && { [player,cursortarget] call isHostile } ) then
{

private _units = (units player) select { alive _x && !isplayer _x && { !([_x,false] call inVehicle) } };

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

   
   // player reveal _curTarget;

   [_spotter,_dist] call callOutDistance;
   };

   sleep 2;
  };
 }
 else
 {
  _curTarget = objNull;
 };

};

 sleep 2;
};

};



// sounds files for these distances are available
#define DIST_RADIO [75,100,200,300,400,500,600,700,800,1000,1500,2000,2500]

callOutDistance =
{
 params ["_speaker","_actualDist"];

private _useDist = 0;

{

if(_actualDist >= _x) then
{
 _useDist = _x;
};

} foreach DIST_RADIO;

if(_useDist == 0 || _useDist > 2500) exitwith {}; // not enough sound files


private _file = format ["dist%1_%2.ogg",_useDist, floor (random 3) + 1];

private _filepath = format ["\a3\dubbing_radio_f\data\eng\%1\RadioProtocolENG\%2\%3", speaker _speaker, "Normal\DistanceAbsolute1", _file ];

if(!fileExists _filepath) exitwith {}; // if wrong language or something

systemchat format [" %1 %2 %3 ", _file, _useDist, fileExists _filepath];

[_filepath, 1.25] call playSoundToPlayer;


};



