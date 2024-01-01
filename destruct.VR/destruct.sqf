
#define BELOW_OBJ_Z 0.1
#define MAX_ITERS 1000
#define Z_DOWN_VAL 0.25

dropPieces =
{
 params ["_center"];

private _pieces = nearestObjects [_center, [], 100];

private _needsUpdate = true;
private _maxIters = MAX_ITERS;

while { _needsUpdate && _maxIters > 0 } do
{
_needsUpdate = false;
_maxIters = _maxIters - 1;

{
 private _obj = _x;
 private _pos = getposATL _obj;

if(typeof _obj != "Land_HBarrier_01_line_3_green_F") then { continue; };

private _startPos = getposASL _obj;


private _bbr = boundingBoxReal _obj;
private _p1 = _bbr select 0;
private _p2 = _bbr select 1;
private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));

private _closestHeight = nil;
private _smallestDif = 100000000;

private _zAdd = _maxHeight / 2;

{

private _edgePos = _startPos getPos [_x * (_maxWidth / 2 - 0.1), 90 + getdir _obj];
_edgePos set [2,_startPos # 2];

 // drawLine3D [ aslToagl _edgePos, aslToagl (_edgePos vectorAdd [0,0,-5]), [1,0,0,1] ];

 // systemchat ("_zAdd " + str _zAdd );

_intersections = lineIntersectsSurfaces [_edgePos vectorAdd [0,0, + _maxHeight - Z_DOWN_VAL], _edgePos vectorAdd [0,0,-55], _obj, objnull, true, -1, "GEOM"];

if(count _intersections > 0) then
{
 private _contact = _intersections # 0;
 private _cpos = _contact # 0;

 private _heightDif = ((_startPos # 2) - (_cpos # 2));

if(_heightDif > 0 && _heightDif < _smallestDif) then
{
 _smallestDif = _heightDif;

 _closestHeight = _cpos # 2;

};

}; // foreach _intersections;

} foreach [-1,0,1];


if(!isnil "_closestHeight") then
{

if(_obj == barrr_13) then
{
 systemchat ( format["dbg %1 %2", _closestHeight, _smallestDif] );
};

 // if(_closestHeight < 0) then { _closestHeight = 0; };

_curPos = _pos;
_newpos = aslToATL [_pos # 0, _pos # 1, _closestHeight];

if((_newpos # 2) < 0) then { _newpos set [2,0]; };

if(abs ((_newpos # 2) - (_curPos # 2)) < 0.1) then
{
 continue;
};

 _obj setposATL _newpos;

// _needsUpdate = true;

};


} foreach _pieces;

};


if(_maxIters == 0) then
{
 systemchat "Max iters reached!";
};


};






onEachFrame
{
_obj = barrr_13; 

_startPos = getPosASL _obj;


private _bbr = boundingBoxReal _obj;
private _p1 = _bbr select 0;
private _p2 = _bbr select 1;
private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));

{
_edgePos = _startPos getPos [_x * (_maxWidth / 2 - 0.1), 90 + getdir _obj];
_edgePos set [2,_startPos # 2];

 drawLine3D [ aslToagl (_edgePos vectorAdd [0,0, + _maxHeight - Z_DOWN_VAL ]), aslToagl (_edgePos vectorAdd [0,0,-55]), [1,0,0,1] ];

} foreach [-1,0,1];

};
