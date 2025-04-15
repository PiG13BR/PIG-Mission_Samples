params ["_soldier"];

private _grp = group _soldier; 
if (!(_grp getVariable ["PIG_bodyFound", false])) exitWith {}; // Don't repeat for this group
_grp setVariable ["PIG_bodyFound", true];

{ 
    deleteWaypoint _x;
} forEachReversed waypoints (_grp);



// [_grp, 500] spawn lambs_wp_fnc_taskCreep;
[leader _grp, getPos _soldier, 200, 5, "AWARE", "LIMITED"] execVM "taskPatrol.sqf";