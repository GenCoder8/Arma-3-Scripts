targetClients =
{
 ([0,-2] select isdedicated)
};


getAngle = 
{
private ["_angle","_p1","_x1","_y1","_p2","_x2","_y2"];

_p1 =  _this select 0;
_x1 = _p1 select 0;
_y1 = _p1 select 1;

_p2 =  _this select 1;
_x2 = _p2 select 0;
_y2 = _p2 select 1;


_angle = ( _x2 - _x1) atan2 (_y2 - _y1);

_angle
};

getValueInRange =
{
private ["_value","_min"];
_value = _this select 0;
_valueLow = _this select 1;
_valueHigh = _this select 2;
_min = _this select 3;
_max = _this select 4;

_value = (((_value - _valueLow) / (_valueHigh - _valueLow)) * (_max - _min) + _min);

// Result := ((Input - InputLow) / (InputHigh - InputLow)) * (OutputHigh - OutputLow) + OutputLow;
// http://gamedev.stackexchange.com/questions/33441/how-to-convert-a-number-from-one-min-max-set-to-another-min-max-set

_value
};
