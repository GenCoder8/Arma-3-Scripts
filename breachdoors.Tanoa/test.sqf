_bldg = nearestBuilding player;
_i = 1;
 private _sel = format["Door_%1", _i];

[_bldg,"<t color='#FFFF00'>Test!</t>",
{
 params ["_target", "_caller", "_actionId", "_arguments"];

 hint "test";

},
[],format["true",_i],_sel] call addHouseAction;



