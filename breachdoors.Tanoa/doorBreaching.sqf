

#define MAX_DOOR_EXPLOSIVE_DIST 3

#define MAX_DOOR_OPEN_DIST 2.5

#define MAX_DOOR_DAMAGE 15

#define DOOR_LOCKED   1
#define DOOR_UNLOCKED 0


#define BREACHING_DEBUG true
#define BREACHING_LOG   false


dbDebug =
{
 if(BREACHING_DEBUG) then
{
 hint _this;
};
};


if(hasinterface) then
{

player addEventHandler ["Fired", 
{
 params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

 private _acfg = (configfile >> "Cfgammo" >> _ammo);
 
 
// player globalchat format [">> %1 -- (%2) (%3) %4 %5",_ammo, gettext(_acfg >> "mineTrigger") ];
// player globalchat format [">> %1 -- (%2) -- (%3) ",_ammo, getNumber (_acfg >> "hit"), _ammo call isAmmoBomb ];
 
 
 if(!(_ammo isKindOf "TimeBombCore")) exitWith { "not bomb" call dbDebug; };
 
 if(gettext(_acfg >> "mineTrigger") != "RemoteTrigger") exitWith { "not remote bomb" call dbDebug; };
 
 [player,_projectile] remoteExecCall ["placeExplosiveOnDoor",2];
 
}];




if(BREACHING_DEBUG) then
{
addMissionEventHandler ["Draw3D", 
{


_bldg = nearestBuilding player;
_doorIndex = [_bldg,getposatl player] call getNearestDoorIndex;
_doorpos = [_bldg,_doorIndex] call getDoorPos;

if(_doorIndex < 0) exitWith {
drawIcon3D ["\a3\ui_f\data\gui\cfg\keyframeanimation\iconkey_ca.paa", [1,2,0,1], getposATL _bldg, 1, 1, 45, "No doors", 1, 0.05, "TahomaB"];
};

{
private _pos = _bldg selectionPosition format [_x, _doorIndex];
private _doorpos = _bldg modelToWorld _pos;

_color = [1,1,1,1];
if(_pos isequalto [0,0,0]) then
{
_color = [1,0,0,1];
};

drawIcon3D ["\a3\ui_f\data\gui\cfg\keyframeanimation\iconkey_ca.paa", _color, _doorpos, 1, 1, 45, format["%1 - %2",_x,_doorIndex], 1, 0.05, "TahomaB"];


} foreach ["Door_%1","Door_%1_trigger","Door_%1_axis"];

}];

};

}; // gui



isDoorOpen =
{
 params ["_bldg","_doorIndex"];
 (_bldg animationPhase format["door_%1_rot",_doorIndex]) == 1
};

isDoorLocked =
{
 params ["_bldg","_doorIndex"];
 (_bldg getVariable [format["bis_disabled_Door_%1",_doorIndex], DOOR_UNLOCKED]) == DOOR_LOCKED
};

toggleDoorLock =
{
 params ["_bldg","_doorIndex","_lock"];
 _bldg setVariable [format["bis_disabled_Door_%1",_doorIndex], _lock, true];
};

toggleDoorOpen =
{
 params ["_bldg","_doorIndex","_open"];
 _bldg animate [format["door_%1_rot",_doorIndex], _open];
};


isAmmoBomb =
{
 params ["_ammo"];
 (_ammo isKindOf "TimeBombCore")
};


if(hasinterface) then
{

addHouseAction =
{
 params ["_bldg","_text", "_act", "_args", "_cond", "_selection"];
 _id = _bldg addAction [_text, _act, _args,1.5,true,true,"",_cond,2,false,_selection];
 _id
};

registerLockedHouse =
{
params ["_bldg"];

// diag_log format["((((((((((((((((((((((%1))))))))))))))))))))",_bldg];


private _numDoors = getNumber (configfile >> "CfgVehicles" >> (typeof _bldg) >> "numberOfDoors");

for "_i" from 1 to _numDoors do
{
 private _sel = format["Door_%1", _i];

// diag_log format["REGISTER DOOR %1 %2",_bldg,_sel];

[_bldg,"<t color='#003366'>[Kick door]</t>",
{
 params ["_target", "_caller", "_actionId", "_arguments"];
 (_arguments+[ceil (random (MAX_DOOR_DAMAGE * 2))]) call damageDoor;
 hint "You kicked the door";
 player setVariable['lastKickTime',time];
},
[_bldg,_sel],format["!([_target,%1] call isDoorOpen) && (time - (player getVariable['lastKickTime',-10])) > 2.5",_i],_sel] call addHouseAction;

};

// Should only trigger on shooters PC
_bldg addEventHandler ["HitPart", 
{

//diag_log "((HIT))";

{
_x params ["_bldg", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];


//_ammo params ["_hit","_ihit","_ihRange","_aclass"];

if(BREACHING_LOG) then
{
diag_log format [">>> %1 -- %2 -- %3", _ammo,_radius,_isDirect];
};

_hit = _ammo # 0;
_ammoName = _ammo # 4;
_range = _ammo # 2;

if(!_isDirect) then
{
 _hit = _ammo # 1;
 _range = _range / 4;
};

//if(_isDirect || (_ammoName call isAmmoBomb)) then

if(true) then
{

if(count _selection > 0 && _hit >= 0) then
{

if(BREACHING_LOG) then
{
diag_log format ["_selection %1 ", _selection];
};

_sel = (_selection # 0);
if("door" in (tolower _sel)) then
{

private _pos = _bldg selectionPosition format ["%1", _sel];
private _doorpos = _bldg modelToWorld _pos;
private _dp = ASLToAGL _position; // getposATL _projectile;
private _distToExplosion = (getposATL _projectile) distance _doorpos; // _doorpos distance (_bldg modelToWorld _dp);

if(BREACHING_LOG) then
{
diag_log format ["POS: %1 -- %2 -- %3 -- %4",_dp,_doorpos,getposATL _projectile,getposATL player];
};


_hitMul = 1;

if(!_isDirect) then
{
if(_distToExplosion > 0) then
{
_hitMul = _range / _distToExplosion;
if(_hitMul > 1) then
{
_hitMul = 1;
};
};
};

if(BREACHING_LOG) then
{
diag_log format["damage is %1 %2 %3 (%4)", _sel, _distToExplosion, _hitMul, (_bldg modelToWorld _position) distance player, _hit];
};

//if(_distToExplosion < MAX_DOOR_OPEN_DIST) then
if(_hitMul > 0.1) then
{
 [_bldg,_sel,_hit * _hitMul] call damageDoor;
};

 // diag_log format ["--> %1 - %2 - %3 - %4 - %5", _sel, aslToATL _position, _distToExplosion   ];
};
};

};
 
} foreach _this;

}];

};

damageDoor =
{
params ["_bldg","_sel","_hit"];

_this remoteExecCall ["onDoorDamge",2];

};

}; // Client


if(isServer) then
{


onDoorDamge =
{
params ["_bldg","_sel","_hit"];

private _ddName = format["doorDamage%1",_sel];

private _curDamage = _bldg getVariable [_ddName, 0];

_prevDamage = _curDamage;

_curDamage = _curDamage + _hit;


_bldg setVariable [_ddName, _curDamage];

// Trigger only once when max damage reached
if( _curDamage >= MAX_DOOR_DAMAGE && _prevDamage < MAX_DOOR_DAMAGE ) then
{
if((_bldg getVariable [format["bis_disabled_%1",_sel], 1]) == 1) then
{
_bldg setVariable [format["bis_disabled_%1",_sel], 0, true];
};
_bldg animate [format["%1_rot",_sel], 1];

};

};


placeExplosiveOnDoor =
{
params ["_plr","_projectile"];

_bldg = nearestBuilding _plr;
_doorIndex = [_bldg,getposatl _plr] call getNearestDoorIndex;
if(_doorIndex < 0) exitwith { };

_doorpos = [_bldg,_doorIndex] call getDoorPos;


if(_doorpos distance _plr > MAX_DOOR_EXPLOSIVE_DIST) exitWith { };

private _pos = _bldg selectionPosition format ["Door_%1", _doorIndex];
private _posTrigger = _bldg selectionPosition format ["Door_%1_trigger", _doorIndex];
private _posAxis = _bldg selectionPosition format ["Door_%1_axis", _doorIndex];



_doorAngle = _posTrigger getdir _posAxis;

_vec = [];
_aa = 0;
_doorDir = -1;

_closestDist = 100000;
_doorFrontPos = [];
{

_distFromDoor = 0.05;
_tryAngle = _doorAngle + _x;

_x = sin _tryAngle * _distFromDoor;
_y = cos _tryAngle * _distFromDoor;

_vec = [_x,_y,0];

_checkPos = _posTrigger vectorAdd _vec;

_checkPos = _bldg modelToWorld _checkPos;
_dist = _checkPos distance2D _plr;

if(_dist < _closestDist) then
{
_closestDist = _dist;
_doorFrontPos = _checkPos;
_aa = _tryAngle;

_cen = _bldg modelToWorld _posTrigger;
_doorDir = _cen getdir _checkPos; // Get where the door is pointing in world coords

};
} foreach [90,-90];


_chargepos = _doorFrontPos;

_projectile setposAtl _chargepos;


_projectile setVectorDirAndUp [[sin _doorDir,cos _doorDir,0],[0,0,1]];

};







getDoorPos =
{
params ["_bldg","_doorIndex"];
private _pos = _bldg selectionPosition format ["Door_%1_trigger", _doorIndex];
private _doorpos = _bldg modelToWorld _pos;

_doorpos
};

getNearestDoorIndex =
{
params ["_bldg","_toPos"];

private _numDoors = getNumber (configfile >> "CfgVehicles" >> (typeof _bldg) >> "numberOfDoors");

private _closestDist = 1000000;
private _closestIndex = -1;
for "_i" from 1 to _numDoors do
{

_doorpos = [_bldg,_i] call getDoorPos;

_dist = _toPos distance _doorpos;

if(_closestDist > _dist) then
{
_closestDist = _dist;
_closestIndex = _i;
};

};
_closestIndex
};


lockedHouses = [];

lockHouse =
{
 params ["_bldg"];

private _numDoors = getNumber (configfile >> "CfgVehicles" >> (typeof _bldg) >> "numberOfDoors");

if(_numDoors == 0) exitWith {};

if(_bldg in lockedHouses) exitwith {}; // Never twice

lockedHouses pushback _bldg;

for "_i" from 1 to _numDoors do
{

[_bldg,_i,1] call toggleDoorLock;

//_doorpos = [_bldg,_i] call getDoorPos;

};


_bldg remoteExec ["dooBreachingInitBldgClient",call targetClients,true];

};

};
