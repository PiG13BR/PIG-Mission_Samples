// CREDITS DetrimentalDave (https://www.reddit.com/r/armadev/comments/1k62se/i_wrote_a_replacement_for_bis_fnc_taskpatrol/)
// ADDITIONS By PiG13BR

if (!isServer) exitWith {};
// [unit, start, range, amount, "behaviour", "speed"] execVM "taskPatrol.sqf"

// Unit that should patrol
_unit   = _this select 0;
 
// Starting location
_start  = _this select 1;
 
// Maximum range
_range  = _this select 2;
 
// Amount of waypoints
_amount = _this select 3;

// Units behaviour
_behaviour = _this select 4;

// Units speed
_speed = _this select 5;
 
_grp = group _unit;
 
_i = 1;
 
while { _i < _amount} do {
 
    _distance = random _range;
    _wdir = random 259;
    _wx = (_start select 0) + (_distance * (sin _wdir));
    _wy = (_start select 1) + (_distance * (cos _wdir));
    _wp = _grp addWaypoint [ [_wx,_wy] , 10, _i ];
 
    if ( _i == 1 ) then {
        _wp setWaypointType "MOVE";
        [_grp, _i] setWaypointBehaviour _behaviour;
        [_grp, _i] setWaypointSpeed _speed;
        [_grp, _i] setWaypointCombatMode "YELLOW";
        [_grp, _i] setWaypointFormation "FILE";
    };
 
    _i = _i + 1;
    
};
 
_wp = _grp addWaypoint [_start,10,_amount];
[_grp, _amount] setWaypointType "CYCLE";