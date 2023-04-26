
smAddAction =
{
 params ["_args"];

 private _id = _args call userAddAction;
 
 (_args select 0) setVariable ["actionId",_id];
};

smRemoveAction =
{
 params ["_obj"];
 
 private _id = _obj getVariable ["actionId",-1];
 if(_id < 0) exitWith {};
 
 _obj removeAction _id;
};