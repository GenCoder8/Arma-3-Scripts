
/*
barrr addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

 systemchat "KILLED";


}];
*/

isStaticWeapon =
{
 (_this isKindof "StaticWeapon")
};

doesObjectFall =
{
 (getNumber ((configof _this) >> "fallable")) == 1
};

execvm "destruct.sqf";
