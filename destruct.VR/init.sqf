
isStaticWeapon =
{
 (_this isKindof "StaticWeapon")
};

doesObjectFall =
{
 (getNumber ((configof _this) >> "fallable")) == 1
};


_h = execvm "destruct.sqf";
waituntil { scriptdone _h };


{


if(_x iskindof "Building") then
{
_x call registerFallTriggerObj;
};


if(_x call doesObjectFall) then
{
};

} foreach (nearestObjects [player, [], 1e10]);

