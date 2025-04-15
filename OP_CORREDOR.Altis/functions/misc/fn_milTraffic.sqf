/*
    fn_milTraffic.sqf
    Author: PiG13BR

    Description: Spawns a vehicle with a delay in a location and despawn it in another location, creating a traffic.
    The vehicles mantains the same speed.

    Parameters:
    0: CODE - Condition to be used in a while do loop. 
    1: STRING - Marker (spawns and start the traffic)
    2: SIDE - east, west, independent, civilian
    3: ARRAY - Array of vehicles classnames ["","",""]
    4: STRING - Marker (half-way point for the traffic)
    5: STRING - Marker (despawns)
    6: NUMBER - Delay between spawns (> 10) 

    // [{loop condition}, "markerStart", side, ["vehicle_class_name_F"], "middleMarker", "endMarker", delay] execVM "scripts\milTraffic.sqf";
*/
if (!isServer) exitWith {};

params["_condition","_markerStart","_side","_vehicles","_middleMarker","_endMarker","_delay"];

if (_delay <= 10) exitWith {["It needs more delay to work properly (> 10)"] call bis_fnc_error};

// Get info
private _spawnPos = getMarkerPos _markerStart;
private _dir = markerDir _markerStart;
private _middleWpPos = getMarkerPos _middleMarker;
private _despawnPos = getMarkerPos _endMarker;

// Select the vehicle and spawn it
while _condition do {
private _selectVeh = _vehicles call BIS_fnc_selectRandom;
_veh = [_spawnPos, _dir, _selectVeh, _side] call BIS_fnc_spawnVehicle;
_grp = _veh select 2;
_grp deleteGroupWhenEmpty true;
(_veh select 0) forceSpeed 13.8; // 50 km/h

sleep 1;

{_x disableAI "TARGET"; _x disableAI "WEAPONAIM"}forEach units _grp;

_wpt1 = _grp addWaypoint [_middleWpPos,0];
_wpt1 setWaypointType "MOVE"; 
_wpt1 setWaypointBehaviour "CARELESS";

_wpt2 = _grp addWaypoint [_despawnPos,0];
_wpt2 setWaypointStatements ["true", "{deleteVehicle _x;} foreach thisList + [vehicle this]"];

sleep _delay
}