private["_a1","_a2","_tangdist"];

_a1 = _this select 0;
_a2 = _this select 1;

_a1 = _a1 call make360;
_a2 = _a2 call make360;


_tangdist = _a1 - _a2;
if(_tangdist > 180) then { _tangdist = -(360 - _tangdist); };
if(_tangdist < -180) then { _tangdist = 360 + _tangdist; };
//_tangdist = abs _tangdist;


_tangdist