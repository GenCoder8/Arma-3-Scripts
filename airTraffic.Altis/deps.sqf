
userMessage =
{
 scopename "um";
 
 private ["_msg","_target"];
 
 if(typename _this == "ARRAY") then
 {
  _msg = _this select 0;
  _target = _this select 1;
 }
 else
 {
  _msg = _this;
 };
 
 if(isDedicated) then
 {
 if(!isRemoteExecuted) then { "userMessage (dedicated) not isRemoteExecuted" call errmsg; breakOut "um"; };

 _target = remoteExecutedOwner; 
 
 if(isnil "_target") then
 {
  ["Invalid args in userMessage (dedicated) (%1)",_this] call errmsg;
 };
 
  _msg remoteExecCall ["userMessageClient", _target];
 }
 else
 {
  _msg call userMessageClient;
 };

};

userMessageClient =
{
private ["_msg"];

_msg = _this;

//player sidechat _msg;
hint _msg;

};

colNumToFloat =
{
 params ["_r","_g","_b"];
 
 [_r / 255, _g / 255, _b / 255, 1]
};