
#define prepro Compile preprocessFileLineNumbers

getAngle = prepro "math\getAngleFn.sqf";
getVecLength = prepro "math\getVecLengthFn.sqf";
getVecDir = prepro "math\getVecDirFn.sqf";
getvector = prepro "math\getvectorFn.sqf";
addvector = prepro "math\addVecFn.sqf";




isPosGround =
{
 scopename "ipg";
 params ["_around","_areaSize"];
 private _ret = true;
 
 for "_depth" from 1 to _areaSize step 10 do
 {
 for "_d" from 0 to 360 step 45 do
 {
  private _vec = [_d,_depth] call getVector;
  private _checkpos = [_around,_vec] call addVector;
  
  if(surfaceIsWater _checkpos) then
  {
   _ret = false;
   breakTo "ipg";
  };
 };
 };
 _ret
};


seekGround =
{
 scopename "seekGround";
 params ["_pos","_areaSize"];
 private _ret = [];
 private _closestDist = 1000000;
 
for "_d" from 0 to 360 step 22.5 do 
{
 
 _groundFound = false;
 _groundStartPos = [];
 _cdist = 1000000;
 
#define RSTEP 10
 
 for "_s" from 0 to 250 step RSTEP do
 {
 scopename "testsg";
 
 _reachDist = _s * RSTEP;
 
  _vec = [_d,_reachDist] call getVector;
  
  _spos = [_pos,_vec] call addVector;
  
  
  if(!_groundFound) then
  {
   _cdist = _reachDist;
   if(_reachDist >= _closestDist) then
   {
    breakout "testsg";
   };
  };
 
  if([_spos,_areaSize] call isPosGround) then // Ground found
  {
   if(!_groundFound) then
   {
   _groundFound = true;
   _groundStartPos = _spos;
   }
   else
   {
   _dist = _groundStartPos distance2D _spos;
   
   if(_dist >= (_areaSize * 2)) then
   {
/*
    _di = 0;
    while { _di < _dist} do
	{
	_vec = [_d,_di] call getVector;
	_dpos = [_groundStartPos,_vec] call addVector;
	
    [_dpos,"shore","ColorGreen"] call createDebugMarker;
	
	_di = _di + 25;
	};
	*/
	
	_vec = [_d,_dist / 2] call getVector;
	_cenpos = [_groundStartPos,_vec] call addVector;
	
    //[_cenpos,format["center  ---> %1", _cdist],"ColorRed"] call createDebugMarker;
	
	//breakout "testsg";
	
   _ret = _cenpos;
   _closestDist = _cdist;
   
   breakout "testsg";
   
    //breakto "seekGround";
   };
   
   };
  }
  else
  {
   _groundFound = false;
  };
 
 };
 
};

if(count _ret > 0) then
{
//[_ret,"closest","ColorYellow"] call createDebugMarker;
};

_ret
};





sleep 0.1;

_tpos = getmarkerpos "town";

#define SPACE_REQ_FOR_MISSION 250

#define LOC_SEARCH_STEP 22.5


_validPos = [];

_rdir = random 360;
for "_d" from 0 to 360 step LOC_SEARCH_STEP do
{
scopename "getFreeMisPos";

_v = [_rdir, 200] call getvector;
_checkPos = [_tpos,_v] call addvector;

_ne = _checkPos nearEntities SPACE_REQ_FOR_MISSION;


if(!([_checkPos,50] call isPosGround)) then
{
_checkPos = [_checkPos,50] call seekGround;
};

// Must not be near spawned forces
if(count _ne == 0) then
{

_validPos = _checkPos;

/*
_nearPlace = [places, _checkPos] call getNearestPlace;

// Todo doesnt yet work
// No places near
if((_nearPlace select PLACE_POS) distance2D _checkPos > 750 ) then
{
_validPos = _checkPos;
breakout "getFreeMisPos";
};
*/
};

_rdir = _rdir + LOC_SEARCH_STEP;
};

if(count _validPos > 0) then
{
_m = createMarker ["testtownpos",_validPos];
_m setMarkerType "hd_dot";
_m setMarkerText "test mis pos";
}
else
{
 systemchat "NO VALID MISSION TOWN POS";
};
