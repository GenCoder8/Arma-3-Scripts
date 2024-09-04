
#define CHATEXTDLGID 1234511

#define CHAT_USER_COLORS ["#800000","#004C99","#008000","#660080"]

chatExtMessages = [];
chatExtChannel = 0;
chatExtAlpha = 1;

chatExtProcessChatMsg =
{
 params ["_array","_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType", "_params"];

 if(!(_channel in [0,1])) exitwith {};

 private _side = side (group _person);

 private _sideIndex = _side call getSideIndex;

 if(_sideIndex < 0 || _sideIndex > 3) exitWith {};

 private _color = CHAT_USER_COLORS select _sideIndex;

 _array pushback [_channel,_name,_color,_text];
};

if(isServer) then
{

chatExtSideMessages = createHashmap;

addMissionEventHandler ["HandleChatMessage",
{
 params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType", "_params"];

 diag_log "Server HandleChatMessage called";

 private _side = side (group _person);

 diag_log format ["Server HandleChatMessage %1 %2",_channel,_side];

 if(_channel == 0) then
 {
 _side = sideLogic;
 };

 private _msgArray = chatExtSideMessages getOrDefault [_side,[],true];

 ([_msgArray] + _this) call chatExtProcessChatMsg;

 diag_log format ["_msgArray now %1", _msgArray];
}];




addMissionEventHandler ["PlayerConnected",
{
params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

[_uid] spawn
{
params ["_uid"];

diag_log format ["PlayerConnected step 1 > %1 %2", _uid];


private _player = objNull;

waituntil { sleep 0.01; _player = _uid call getPlayerObj; !isnull _player };

 private _side = side (group _player);

diag_log format ["PlayerConnected step 2 > %1 %2", _player, _side];


// _array select [count _array - 200];

 private _msgs = (chatExtSideMessages getOrDefault [sideLogic, []]) + (chatExtSideMessages getOrDefault [_side, []]);

/// [_msgs] remoteExecCall ["chatExtReceiveMsgs",_player];

};

}];



/*
addMissionEventHandler ["OnUserSelectedPlayer",
{
 params ["_networkId", "_playerObject", "_attempts"];

diag_log "USER SELECTED";



}];
*/
};

if(hasInterface) then
{
addMissionEventHandler ["HandleChatMessage",
{
 params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType", "_params"];

// TODO SIDE

if(_channel in [0,1]) then
{
 // hint format ["channel %1 %2 %3 %4", time, _channel, _isPlayerMessage,_forcedDisplay];


/*
 private _side = side (group _person);

 private _sideIndex = _side call getSideIndex;

 if(_sideIndex < 0 || _sideIndex > 3) exitWith {};

 private _color = CHAT_USER_COLORS select _sideIndex;

 chatExtMessages pushback [_channel,_name,_color,_text];
*/

 ([chatExtMessages] + _this) call chatExtProcessChatMsg;

 _channel call chatExtLoadMessages;
};

 false
}];

chatExtReceiveMsgs =
{
params ["_msgs"];

diag_log format ["chatExtReceiveMsgs %1", _msgs ];

// Get new messages
private _newMsgs = _msgs select
{
 _x params ["_channel","_name","_color","_text"];

 private _fi = chatExtMessages findIf
 {
  _x params ["_echannel","_eName","_ecolor","_eText"];
  (_name == _eName && _text == _eText)
 };

 // is new?
 _fi < 0
};

chatExtMessages insert [0, _newMsgs];

};



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
_transparency sliderSetPosition chatExtAlpha;
[_transparency, chatExtAlpha] call chatExtTransparency;


 //test code
/*
for "_i" from 0 to 55 do
{
chatExtMessages pushback [0,"tester", "#ffff00", "Test " + (str _i) + ", test message string...." ];
};*/

 chatExtChannel call chatExtLoadMessages;
};

chatExtClose =
{

private _display = findDisplay CHATEXTDLGID;

private _transparency = _display displayCtrl 1900;

chatExtAlpha = sliderPosition _transparency;
 
};

chatExtLoadMessages =
{
 params ["_loadChannel"];

 chatExtChannel = _loadChannel;

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
} foreach chatExtMessages;

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


private _transparentControls = [3700];

// Select buttons
private _ctrlCfgs = missionConfigFile >> "ChatExtendedDlg" >> "Controls";
 
for "_c" from 0 to (count _ctrlCfgs - 1) do
{
 private _ctrlCfg = _ctrlCfgs select _c;

 if((configname (inheritsFrom _ctrlCfg)) != "RscButton") then { continue; };

 _transparentControls pushback (getNumber (_ctrlCfg >> "idc"));

};

// Apply alpha to controls
{
 private _ctrl = _display displayCtrl _x;

private _color = ctrlBackgroundColor _ctrl;
_color set [3, _alpha];

_ctrl ctrlSetBackgroundColor _color;
} foreach _transparentControls;

};


};

