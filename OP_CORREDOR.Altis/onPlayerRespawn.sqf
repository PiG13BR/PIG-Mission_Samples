// When players spawn for the first time, they will also read this script.
params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

waitUntil {!isNil "task00_completed"};

// respawned = 1;
[_newUnit, 100, east] call PIG_fnc_respawnManager;

// When respawn, call the addAction for the players
[_newUnit] call PIG_fnc_addActionPlayers;

sleep 60;
deleteVehicle _oldUnit;
