private["_angle","_length","_ax","_ay","_vec"];

_angle = _this select 0;
_length = _this select 1;

_ax = sin _angle * _length;
_ay = cos _angle * _length;

_vec = [_ax,_ay];

_vec