params["_grp"];

_grp setBehaviour "SAFE";
_grp setSpeedMode "LIMITED";
{[_x] call PIG_fnc_addFlashlight}forEach units _grp;

_wp1 = _grp addWaypoint [opfor_radar_1, 10];
_wp2 = _grp addWaypoint [opfor_sam_1, 10];
_wp3 = _grp addWaypoint [opfor_sam_2, 10];
_wp4 = _grp addWaypoint [opfor_sam_3, 10];
_wp5 = _grp addWaypoint [opfor_radar_1, 10];
_wp5 setWaypointType "CYCLE";