
createCaptives =
{
params ["_num"];

_misPos = curMisPos;

_capGroup = createGroup civilian;

for "_i" from 1 to _num do
{
_captive = _capGroup createUnit ["uns_civilian2", _misPos, [], 0, "NONE"];

[_captive,true] call toggleCaptive;

curMisTargets pushback _captive;
};

};


toggleCaptive =
{
 params ["_man","_isCaptive",["_inClient",false]];
 
if(_isCaptive) then
{
 _man setCaptive true;
 // _man switchMove "TestSurrender";
  _man switchMove "Acts_AidlPsitMstpSsurWnonDnon_loop";
 _man disableAI "ANIM";
}
else
{
 //_man enableAI "ANIM";
 
 if(!_inClient) then
 {
  _man setCaptive false;
 }
 else
 { 
  [_man,false] remoteExecCall ["setCaptive", owner _man];
  
  [_man,"ANIM"] remoteExecCall ["enableAI", owner _man];
  
  [_man,"Acts_AidlPsitMstpSsurWnonDnon_out"] remoteExecCall ["playMove", owner _man];
  
 // _man playMove "Acts_AidlPsitMstpSsurWnonDnon_out";
 };
  
};

};

smSetupCaptives =
{

{

[_x,true] call toggleCaptive;

} foreach curMisTargets;

};

smRescueCaptives =
{
  {
   _captive = _x;
   
   // Toggle not captive on server so this script doesnt execute more than once
   [_captive,false] call toggleCaptive;
   
   [_captive] joinSilent _nearPlr; 
   
   // Have to wait before resetting the animations on client
   [_captive] spawn
   {
   params ["_captive"];
   
   // diag_log format["CAPTIVE FIRST: %1 %2", owner _captive, local _captive ];

   // Wait until client has the captive
   if(isdedicated) then
   {
   waituntil { sleep 1; !local _captive };
   };
   
   // Toggle rest of captive things off in client
    [_captive,false,true] call toggleCaptive;
   };
   
  } foreach curMisTargets;
  
};
 
smTakeControlTargets =
{
 
 if(call smNumTargetsAlive > 0) then
 {
 private _target = (curMisTargets # 0);
 if(captive _target && !isPlayer (leader (group _target))  ) then
 {
   
 private _nearPlr = [3] call smGetNearTargetPlayer;
 
 if(!isnull _nearPlr) then
 {

 _fn = getText (_misConf >> "targetsReached");
 call compile _fn;
  
   // hint "FREED!";
 };
 

 }
 else
 {
  (getText (_misConf >> "targetsReachedMsg")) call smSetTaskInfo;
  
  if(call smAreTargetsInDestination) then
  {
  [true,"",call smGetCurMissionGroup] call endSideMission;
  };
 };
 
 }
 else
 {
 [false,(getText (_misConf >> "targetsDiedMsg"))] call endSideMission;
 };
 
};

smSetupRescuableMen =
{

{
private _man = _x;

_man setCaptive true;
[_man,true] call smFreezeMan;

} foreach curMisTargets;

};

smRescueMen =
{
 {
 private _man = _x;

 // Enable the disabled AI features in smSetupRescuableMen
 _man setCaptive false;
 [_man,false] call smFreezeMan;

 [_man] joinSilent _nearPlr; 

 } foreach curMisTargets;
  
};

smSetupOfficers =
{

{

_x setCaptive true;
[_x,true] call smFreezeMan;

removeAllWeapons _x;

} foreach curMisTargets;

};

smArrestOfficer =
{

// Remain as captive...
{
[_x,false] call smFreezeMan;
} foreach curMisTargets;

curMisTargets joinSilent _nearPlr;
};

smFreezeMan =
{
 params ["_man","_freeze"];

if(_freeze) then
{
_man disableAI "TARGET";
_man disableAI "AUTOTARGET";
}
else
{
 _man enableAI "TARGET";
 _man enableAI "AUTOTARGET";
};

};

smGetCurMissionGroup =
{
private _ret = grpNull;
{
 if(!isnull (group _x)) exitwith { _ret = group _x; };
} foreach curMisTargets;
_ret
};

smDestroyTargets =
{
 if(call smNumTargetsAlive == 0) then
 {
  [true] call endSideMission;
 };
};

smSetupAccessComputer =
{
 _pc = curMisTargets select 0;
 
_clientAccessComputer =
{
params ["_target", "_caller", "_actionId", "_arguments"]; 
_target remoteExecCall["smAccessComputerDone",2];
};

 [[_pc,"<t color='#00FF00'>Access computer</t>",_clientAccessComputer,"true"]] remoteExecCall ["smAddAction",_curMisSide,_pc];
};

smAccessComputerDone =
{
 params ["_pc"];
 
 // hint format["Access PC! %1", _pc];
 
 //private _mis = _pc call smGetMissionByTarget;
 
 _pc setVariable ["wasAccessed",true];
 
};

smAccessComputer =
{
 _pc = curMisTargets select 0;
 
 if(alive _pc) then
 {
 if(_pc getVariable ["wasAccessed",false]) then
 {
  [true] call endSideMission;
 };
 }
 else
 {
 [false,"The computer was destroyed"] call endSideMission;
 };
 
};

smEndScoutMission =
{
[true] call endSideMission;
};
