

_h = execvm "combatEngineer.sqf";
waituntil { scriptdone _h };

_h = execvm "objectSelectDlg.sqf";
waituntil { scriptdone _h };



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



