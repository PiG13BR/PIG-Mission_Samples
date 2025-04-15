
sleep 5;

[] remoteExecCall ["saveMissionLoadout", allPlayers, true];

sleep 1;

["End_win", true] remoteExecCall ["BIS_fnc_endMission"];