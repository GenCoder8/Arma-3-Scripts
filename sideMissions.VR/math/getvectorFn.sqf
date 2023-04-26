private["_angle","_length","_x","_y","_vec"];

_angle = _this select 0;
_length = _this select 1;

_x = sin _angle * _length;
_y = cos _angle * _length;

_vec = [_x,_y];

_vec