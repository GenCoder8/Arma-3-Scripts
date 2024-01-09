
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

if(_x call doesObjectFall) then
{

_x call registerFallableObj;

};

} foreach (nearestObjects [player, [], 1e10]);

