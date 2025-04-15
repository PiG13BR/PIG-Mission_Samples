/*
    File: fn_detectedTimer.sqf
    Author: PiG13BR - https://github.com/PiG13BR
    Date: 2025-03-29
    Last Update: 2025-03-30
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Timer that the players have to eliminate enemy soldier/group before it transmits information about player's presence
        In this case, the mission will fail if the times runs out and the enemy is alive

    Parameter(s):
        _group - Group that spotted the players [GROUP]

    Returns:
        -
*/
params ["_group"];

// Ignore if task is completed
if (task01_completed) exitWith {};

// Don't repeat this code
if (missionNamespace getVariable "PIG_players_spotted") exitWith {};
missionNamespace setVariable ["PIG_players_spotted", true];

// Spotted before reaching the beach: directly fail
if (!task00_completed) then {
    ["End_fail", true] remoteExecCall ["BIS_fnc_endMission"];
};

// CBA's WUAE with timeout
[{({(alive _x) || {[_x] call ace_common_fnc_isAwake}} count (units _this)) < 1}, {
    // Original activation
    missionNamespace setVariable ["PIG_players_spotted", nil]; // Destroy variable to restart
}, _group, 20, {
    // Timeout activation
    if ((({(alive _x) || {[_x] call ace_common_fnc_isAwake}} count (units _this)) > 0) && {task00_completed} && {task01_create}) then {
        // Spawn QRF units. Select the leader from the group as a center.
        _centerUnit = leader _this;
        // Get last know position of the enemy (a player)
        private _lastKnowPos = [0,0,0];
        {
            _pos = _centerUnit getHideFrom _x;
            if (_pos isNotEqualTo [0,0,0] && {(_centerUnit distance _pos) < 200}) exitWith {_lastKnowPos = _pos}; // End loop if found a position
        }forEach units groupPlayers;

        private _flare = createVehicle ["F_40mm_red", (getMarkerPos "spawn_flare") vectorAdd [0,0,300], [], 30, "NONE"];
        _flare setVelocity [0,0,-15];

        if (_lastKnowPos isEqualTo [0,0,0]) then {
            // Send only QRF chopper in the default marker
            if (!QRF_chopper_called) then {[getMarkerPos "qrf_land_default"] execVM "scripts\spawnQRF_chopper.sqf";}
        } else {
            // Spawn QRF land infantry units. Seek & Destroy last know position.
            [getMarkerPos "spawn_qrf_units", east, _lastKnowPos] execVM "scripts\spawnQRF_units.sqf";
            // Spawn QRF heli chopper.
            if (!QRF_chopper_called) then {[_lastKnowPos] execVM "scripts\spawnQRF_chopper.sqf";};
        }
    };
    if ((({(alive _x) || {[_x] call ace_common_fnc_isAwake}} count (units _this)) > 0) && {!task00_completed} && {!task01_create}) then {
        ["End_fail", true] remoteExecCall ["BIS_fnc_endMission"];
    };
}] call CBA_fnc_waitUntilAndExecute;
 
