
isStaticWeapon =
{
 (_this isKindof "StaticWeapon")
};

doesObjectFall =
{
 (getNumber ((configof _this) >> "fallable")) == 1
};

doesObjectGetDestroyed =
{
!(_this call doesObjectFall) && !(_this iskindof "house")
};

_h = execvm "destruct.sqf";
waituntil { scriptdone _h };


{


if(_x iskindof "Building") then
{
_x call registerFallTriggerObj;
};


if(_x call doesObjectGetDestroyed) then
{
 _x setVariable ["isDestroyable", true];
};

} foreach (nearestObjects [player, [], 1e10]);

