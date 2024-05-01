

_h = execvm "combatEngineer.sqf";
waituntil { scriptdone _h };

_h = execvm "objectSelectDlg.sqf";
waituntil { scriptdone _h };

getObjectSize =
{
 private _veh = _this;
 private ["_bbr","_p1","_p2"]; 
 
 _bbr = 0 boundingBoxReal _veh;
 _p1 = _bbr select 0;
 _p2 = _bbr select 1;

 // Width, Length, Height
 [abs ((_p2 select 0) - (_p1 select 0)), abs ((_p2 select 1) - (_p1 select 1)), abs ((_p2 select 2) - (_p1 select 2))]
};



sleep 0.01;
call ceOpenObjectSelect; // Begin testing

hint "Hold ctrl and scroll mouse middle wheel to move the object. Press H to change editing mode";


// Test functions

userAddAction =
{
 params ["_actOwner","_text","_action","_condition",["_radius",3]];
 
private _id = _actOwner addAction [_text, _action, nil, 1.5, true, true,"",_condition,_radius];

_id
};


_id = [player,"place objs", {

call ceOpenObjectSelect;

}, "!call ceIsPlacing" ] call userAddAction;



