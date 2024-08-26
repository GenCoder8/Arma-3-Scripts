
#define CHATEXTDLGID 1234511

chatMessages = [];
chatChannel = 0;

addMissionEventHandler ["HandleChatMessage",
{
 params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType", "_params"];

 hint format ["channel %1 %2", _channel, _isPlayerMessage];

 if(_channel in [0,1]) then
{
 chatMessages pushback [_channel,_name,_text];

 _channel call chatExtLoadMessages;
};

 false
}];


//createDisplay
//findDisplay 46 createDisplay "RscCredits";

// waituntil { ! isnull (findDisplay 46) };

//findDisplay 46 createDisplay "ChatExtendedDlg";

/*
cutRsc["ChatExtended","PLAIN",0]; // Todo BIS_fnc_rscLayer?


private _display = uiNamespace getVariable ['ChatExtOverlay',displayNull];

_chatFrame = _display displayCtrl 2300;

_chatMessages = _display ctrlCreate ["RscStructuredText", 1234512, _chatFrame];
_chatMessages ctrlSetPosition [0,0,1,1];
_chatMessages ctrlCommit 0;


_chatMessages ctrlSetStructuredText parseText "Teeest <br/> sdfsdfds <br/> hjghjghjgh";
*/

chatExtOpen =
{
createDialog "ChatExtendedDlg";

private _display = findDisplay CHATEXTDLGID;


// _chatMessages = _display displayCtrl 1100;

// _chatMessages ctrlSetStructuredText parseText "Teeest <br/> sdfsdfds <br/> hjghjghjgh";

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


private _chatMessages = _display displayCtrl 1100;

private _chatStr = "";

{
 _x params ["_channel","_name","_text"];

 if(_loadChannel != _channel) then { continue; };

 _chatStr = _chatStr + _name + ": " + _text + "<br/>";
} foreach chatMessages;

_chatMessages ctrlSetStructuredText parseText _chatStr;

};

chatExtSwitchToChannel =
{
 params ["_channel"];

 _channel call chatExtLoadMessages;
};

sleep 0.01;

waituntil { ! isnull (findDisplay 46) };

call chatExtOpen;

