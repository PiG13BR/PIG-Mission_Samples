params ["_grp", "_centerPos"];

_grp setBehaviour "COMBAT";
_grp setBehaviour "RED";

_wp1 = _grp addWaypoint [_centerPos, 100];
_wp1 setWaypointType "LOITER";
