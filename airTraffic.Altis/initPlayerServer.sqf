
params ["_player", "_didJIP"];

waituntil { sleep 1; !isnil "registerAirtraffic" };

(vehicle _player) call registerAirtraffic;
