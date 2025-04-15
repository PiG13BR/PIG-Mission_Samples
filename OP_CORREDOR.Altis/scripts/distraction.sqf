// Move these units out of the military base
sleep 5 + (random 10); // Reaction time

{ deleteWaypoint _x } forEachReversed waypoints rGroup_1;
{ deleteWaypoint _x } forEachReversed waypoints rGroup_2;
{ deleteWaypoint _x } forEachReversed waypoints rGroup_veh;

rGroup_1 setBehaviour "AWARE";
rGroup_2 setBehaviour "AWARE";
rGroup_Veh setBehaviour "AWARE";

rGroup_1 setSpeedMode "FULL";
rGroup_1 setSpeedMode "FULL";

_wp1_grp1 = rGroup_1 addWaypoint [gas_station, 10];
_wp1_grp1 setWaypointType "SAD";
_wp1_grp2 = rGroup_2 addWaypoint [gas_station, 10];
_wp1_grp2 setWaypointType "SAD";

_wp1_grpVeh = rGroup_veh addWaypoint [gas_station, 50];
_wp1_grpVeh setWaypointType "SAD";