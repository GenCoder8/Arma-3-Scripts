private["_a"];

_a = _this;


if(_a > 360) then { _a = _a - ((floor(_a / 360)) * 360); };
if(_a < 0) then { _a = 360 + _a + ((floor((abs _a) / 360)) * 360); };


_a