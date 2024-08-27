
#define CHATEXTDLGID 1234511

chatMessages = [];
chatChannel = 0;
chatAlpha = 1;

addMissionEventHandler ["HandleChatMessage",
{
 params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType", "_params"];

// hint format ["channel %1 %2", _channel, _isPlayerMessage];

if(_channel in [0,1]) then
{
 private _side = side (group _person);

 private _sideIndex = _side call getSideIndex;

 if(_sideIndex < 0 || _sideIndex > 3) exitWith {};

 private _color = ["#800000","#004C99","#008000","#660080"] select _sideIndex;

 chatMessages pushback [_channel,_name,_color,_text];

 _channel call chatExtLoadMessages;
};

 false
}];


chatExtOpen =
{
createDialog "ChatExtendedDlg";

private _display = findDisplay CHATEXTDLGID;



private _chatBox = _display displayCtrl 5001;
private _chatAreaSize = ctrlPosition _chatBox;

private _frame = _display ctrlCreate ["RscFrame", 5002];

_frame ctrlSetPosition _chatAreaSize;
_frame ctrlCommit 0;



private _transparency = _display displayCtrl 1900;


_transparency sliderSetRange [0, 1];

// Must set these both
_transparency sliderSetPosition chatAlpha;
[_transparency, chatAlpha] call chatExtTransparency;


 //test code
/*
for "_i" from 0 to 55 do
{
chatMessages pushback [0,"tester", "#ffff00", "Test " + (str _i) + ", test message string...." ];
};*/

 chatChannel call chatExtLoadMessages;
};

chatExtClose =
{

private _display = findDisplay CHATEXTDLGID;

private _transparency = _display displayCtrl 1900;

chatAlpha = sliderPosition _transparency;
 
};

chatExtLoadMessages =
{
 params ["_loadChannel"];

 chatChannel = _loadChannel;

private _display = findDisplay CHATEXTDLGID;

if(isnull _display) exitwith {}; // If chat not open

// Update channel text
(_display displayCtrl 1000) ctrlSetText (format ["Chat channel: %1", ["Global","Side"] select _loadChannel]);

private _chatBox = _display displayCtrl 5001;
private _chatMessages = _display displayCtrl 1100;

private _chatStr = "";

{
 _x params ["_channel","_name","_color","_text"];

 if(_loadChannel != _channel) then { continue; };

 _chatStr = _chatStr + (format["<t color='%2'>%1</t> ", _name, _color]) + _text + "<br/>";
} foreach chatMessages;

_chatMessages ctrlSetStructuredText parseText _chatStr;

private _h = ctrlTextHeight _chatMessages;
_chatMessages ctrlSetPosition [0,0, 0.9, _h];
_chatMessages ctrlCommit 0;

/*
_size = ctrlPosition _chatMessages;

_xy = ctrlPosition _chatBox;

_chatBox ctrlSetPosition [_xy # 0, _xy # 1, 0.5, 0.5];
_chatBox ctrlCommit 0;
*/
// _chatBox ctrlSetScrollValues [1, -1];



_chatBox ctrlSetAutoScrollDelay 0.01;
_chatBox ctrlSetAutoScrollSpeed 1;

//_chatBox ctrlSetAutoScrollRewind true;

};

chatExtSwitchToChannel =
{
 params ["_channel"];

 _channel call chatExtLoadMessages;
};

chatExtTransparency =
{
 params ["","_alpha"];


private _display = findDisplay CHATEXTDLGID;


_transparentControls = [3700];

_ctrls = missionConfigFile >> "ChatExtendedDlg" >> "controls";
 
for "_c" from 0 to (count _ctrls - 1) do
{
 _ctrlCfg = _ctrls select _c;

 if((configname (inheritsFrom _ctrlCfg)) != "RscButton") then { continue; };

 _transparentControls pushback (getNumber (_ctrlCfg >> "idc"));

};

{
 private _ctrl = _display displayCtrl _x;

_col = ctrlBackgroundColor _ctrl;
_col set [3, _alpha];

_ctrl ctrlSetBackgroundColor _col;
} foreach _transparentControls;

};


