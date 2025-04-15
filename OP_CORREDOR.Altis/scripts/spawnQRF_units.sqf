// Activated by spotDeadBodies.sqf or fn_detectedTimer.sqf
// Will run once

params["_spawnPos", "_side", "_movePos"];

// Manage the spawned group if this script is called again
if (QRF_land_called) exitWith {
    // Move them to the new location
    if (({(alive _x) || {[_x] call ace_common_fnc_isAwake}} count (units QRF_LAND_GROUP)) > 0) then {
        { deleteWaypoint _x } forEachReversed waypoints QRF_LAND_GROUP;
        private _wp1 = QRF_LAND_GROUP addWaypoint [_movePos, 50];
        _wp1 setWaypointType "SAD";
        QRF_LAND_GROUP setSpeedMode "FULL";
        QRF_LAND_GROUP setBehaviour "AWARE";

        _wp1 setWaypointStatements [toString {
            true
        }, toString {
            {
                _x setSpeedMode "LIMITED";
            }forEach thisList
        }];
    }
};

_grp = [_spawnPos, _side, 
[
    "O_Soldier_SL_F", 
    "O_Soldier_AR_F", 
    "O_Soldier_GL_F", 
    "O_soldier_M_F", 
    "O_Soldier_A_F", 
    "O_medic_F"
],
[], [], [], [], [], 0, false] call BIS_fnc_spawnGroup;

{[_x] call PIG_fnc_addFlashlight}forEach units _grp;

private _wp1 = _grp addWaypoint [_movePos, 50];
_wp1 setWaypointType "SAD";
_grp setSpeedMode "FULL";
_grp setBehaviour "AWARE";

_wp1 setWaypointStatements [toString {
    true
}, toString {
    {
        _x setSpeedMode "LIMITED";
    }forEach thisList
}];

QRF_LAND_GROUP = _grp;
QRF_land_called = true;
