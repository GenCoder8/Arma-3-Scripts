
isStaticWeapon =
{
 (_this isKindof "StaticWeapon")
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

