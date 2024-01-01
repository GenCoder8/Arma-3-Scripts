
sleep 0.01;

#define GETGROUPCFGSID 1234765

openGetGroupsDlg =
{

createDialog "GetGroupCfgsDlg";

_display = findDisplay GETGROUPCFGSID;

_sidesList = _display displayCtrl 2100;
lbClear _sidesList;
_sidesList lbAdd "East";
_sidesList lbAdd "West";
_sidesList lbAdd "Indep";


};

getSideGroupConfigs =
{

(configfile >> "CfgGroups" >> sideStr)
};

onSideSelected =
{
 params ["_ctrl","_selIndex"];
 
// hint (str _this);

_display = findDisplay GETGROUPCFGSID;

_sidesList = _display displayCtrl 2100;


_sideStr = _sidesList lbText _selIndex;
sideStr = _sideStr;

_factionList = _display displayCtrl 1500;
//lbClear _factionList;

call clearFactionsField;
call clearGroupTypesField;
call clearGroupsField;
call clearGroupInfoField;

selFaction = nil;

_cfgFactions = call getSideGroupConfigs;


_numFacs = 0;
for "_i" from 0 to (count _cfgFactions - 1) do
{
 _fac = _cfgFactions select _i;
 
 if(isclass _fac) then
 {
  _factionList lbAdd format["%1", getText(_fac >> "name")];
  _factionList lbSetData [_numFacs, configname _fac];
  
  _numFacs = _numFacs + 1;
 };
 
};
 
};

clearFactionsField =
{
_factionList = _display displayCtrl 1500;
lbClear _factionList;
_factionList lbSetCurSel -1;
};

onFactionSelected =
{
 params ["_ctrl","_selIndex"];
 
 // hint (str _this);
 
_display = findDisplay GETGROUPCFGSID;

_factionList = _display displayCtrl 1500;

 _selFac = _factionList lbData _selIndex;
 
 _selFac call showFaction;
 
};

showFaction =
{
params ["_factionStr"];

_display = findDisplay GETGROUPCFGSID;
_groupTypesList = _display displayCtrl 1501;
//lbClear _groupTypesList;

call clearGroupTypesField;
call clearGroupsField;
call clearGroupInfoField;

selFaction = _factionStr;
_grpTypes = (call getSideGroupConfigs) >> selFaction;

_numGTypes = 0;
for "_i" from 0 to (count _grpTypes - 1) do
{
 _gtype = _grpTypes select _i;
 if(isClass _gtype) then
 {
 _groupTypesList lbAdd format["%1", getText(_gtype >> "name")];
 _groupTypesList lbSetData [_numGTypes, configname _gtype];
 
 _numGTypes = _numGTypes + 1;
 };
};

};

clearGroupTypesField =
{
_groupTypesList = _display displayCtrl 1501;
lbClear _groupTypesList;
_groupTypesList lbSetCurSel -1;
};

onGroupTypeSelected =
{
 params ["_ctrl","_selIndex"];
 
_display = findDisplay GETGROUPCFGSID;
_groupTypesList = _display displayCtrl 1501;
_groupsList = _display displayCtrl 1502;

//lbClear _groupsList;
call clearGroupsField;
call clearGroupInfoField;

_selGroupType = _groupTypesList lbData _selIndex;


selGroupType = _selGroupType;
_groups = (call getSideGroupConfigs) >> selFaction >> selGroupType;
 
_numGroups= 0;
for "_i" from 0 to (count _groups - 1) do
{
 _group = _groups select _i;
 if(isClass _group) then
 {
 _groupsList lbAdd format["%1", getText(_group >> "name")];
 _groupsList lbSetData [_numGroups, configname _group];
 
 _numGroups = _numGroups + 1;
 };
};

};

clearGroupsField = 
{
_groupsList = _display displayCtrl 1502;

lbClear _groupsList;

_groupsList lbSetCurSel -1;

selGroup = nil;
};

onGroupSelected = 
{
 params ["_ctrl","_selIndex"];
 
 _display = findDisplay GETGROUPCFGSID;
 _groupsList = _display displayCtrl 1502;
 
 _selGroup = _groupsList lbData _selIndex;
 selGroup = _selGroup;
 
_groupInfo = _display displayCtrl 1503;
//lbClear _groupInfo;

call clearGroupInfoField;

_group = (call getSideGroupConfigs) >> selFaction >> selGroupType >> _selGroup;


//hintSilent format["%1 --- %2", _group, count _group ];

for "_i" from 0 to (count _group - 1) do
{
 _gi = _group select _i;
 if(isClass _gi) then
 {
  _vehType = getText (_gi >> "vehicle");
  _vehCfg = configFile >> "CfgVehicles" >> _vehType;
  
  _typeStr = "Vehicle";
  if(_vehType isKindOf "man") then
  {
  _typeStr = "Man";
  };
  
 _groupInfo lnbAddRow [_typeStr, getText (_vehCfg >> "displayName")];
 };
};

 
};

clearGroupInfoField =
{
 // _display = findDisplay GETGROUPCFGSID;
 _groupInfo = _display displayCtrl 1503;
 lbClear _groupInfo;
};

copyString =
{
 params ["_str"];
 
 copytoclipboard _str;
 
 hint format["Copied to clipboard: %1", _str];
};

copyFaction = 
{
 if(isnil "selFaction") exitwith { hint "No faction selected"; };
 
 selFaction call copyString;
};

copyGroupConfig =
{
 
 if(isnil "selGroup") exitwith { hint "No group selected"; };

 selGroup call copyString;
};

copyFullGroupConfig =
{
 if(isnil "selGroup") exitwith { hint "No group selected"; };
 
_str = format['configfile >> "CfgGroups" >> "%1" >> "%2" >> "%3" >> "%4"', sideStr, selFaction, selGroupType, selGroup];

_str call copyString;

};

GCGClose =
{
 (uiNamespace getVariable 'gcgDisp') closeDisplay 0;
};


sleep 1;
call openGetGroupsDlg;
