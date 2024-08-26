
#define CHATEXTDLGID 1234511

chatMessages = [];
chatChannel = 0;

addMissionEventHandler ["HandleChatMessage",
{
 params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType", "_params"];

// hint format ["channel %1 %2", _channel, _isPlayerMessage];

if(_channel in [0,1]) then
{
 chatMessages pushback [_channel,_name,_text];

 _channel call chatExtLoadMessages;
};

 false
}];


chatExtOpen =
{
createDialog "ChatExtendedDlg";

private _display = findDisplay CHATEXTDLGID;

/* test code
for "_i" from 0 to 55 do
{
chatMessages pushback [0,"tester", "Test " + (str _i) + ", test message string...." ];
};*/

 chatChannel call chatExtLoadMessages;
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
 _x params ["_channel","_name","_text"];

 if(_loadChannel != _channel) then { continue; };

 _chatStr = _chatStr + _name + ": " + _text + "<br/>";
} foreach chatMessages;

_chatMessages ctrlSetStructuredText parseText _chatStr;

_h = ctrlTextHeight _chatMessages;
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

sleep 0.01;

waituntil { ! isnull (findDisplay 46) };

call chatExtOpen;

