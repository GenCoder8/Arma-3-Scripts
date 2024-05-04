
#include "\a3\ui_f\hpp\definedikcodes.inc"

#define SELOBJDLG_ID 1238990


selectObjsDlgObjects = [];


openSelectObjectDlg =
{
params ["_selObjs","_callbackFn"];

createDialog "SelectObjectDlg";

private _display = findDisplay SELOBJDLG_ID;

private _list = _display displayCtrl 1500;

{
 _x params ["_name","_cfgName","_rotation"];

 _list lbadd _name;

 private _objCfg = configfile >> "CfgVehicles" >> _cfgName;

 selectObjsDlgObjects pushback [_name,_objCfg,_rotation];
} foreach _selObjs;

private _pic = _display displayCtrl 1200;
_pic ctrlShow false;

selectObjectDlgSelObject = [];
selectObjectDlgCallback = _callbackFn;
};


selectObjectDlgSel =
{
 params ["_ctrl","_index"];


_display = findDisplay SELOBJDLG_ID;

 private _pic = _display displayCtrl 1200;

 if(_index < 0) exitWith {};

 (selectObjsDlgObjects # _index) params ["_name","_objCfg","_rotation"];

 _pic ctrlShow true;
 _pic ctrlSetText format ["%1",getText (_objCfg >> "editorPreview")];

 // systemchat format ["_ctrl %1", _objCfg];

 selectObjectDlgSelObject = (selectObjsDlgObjects # _index);
};


selectObjectDlgApply =
{
  // Anyhing selected?
 if(count selectObjectDlgSelObject == 0) exitwith { hint "Nothing selected"; };


 closeDialog 0;


 selectObjectDlgSelObject params ["_name","_objCfg","_rotation"];


 [(configname _objCfg),_rotation] call selectObjectDlgCallback;

};


selectObjectDlgCancel =
{
 closeDialog 0;
};
