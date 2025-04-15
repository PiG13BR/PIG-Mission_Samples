params ["_group"];

if (!isServer) exitWith {};

/*
_unit addEventHandler ["FiredNear", {
    params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
    [_unit] call PIG_fnc_detectedTimer; 
}];
/*_unit addEventHandler ["AnimChanged", {
    params ["_unit", "_anim"];
    [_unit] call PIG_fnc_detectedTimer; 
}];
_unit addEventHandler ["Hit", {
    params ["_unit", "_source", "_damage", "_instigator"];
    [_unit] call PIG_fnc_detectedTimer; 
}];

_unit addMPEventHandler ["MPKilled", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];
    [_unit] call PIG_fnc_detectedTimer; 
}];*/

/* Too much sensible.

_group addEventHandler ["EnemyDetected", {
	params ["_group", "_newTarget"];
    if (side _newTarget == west) then {
        [_group] call PIG_fnc_detectedTimer;
    }
}];
*/

_group addEventHandler ["KnowsAboutChanged", {
	params ["_group", "_targetUnit", "_newKnowsAbout", "_oldKnowsAbout"];
    if (side _targetUnit == west && {_newKnowsAbout > 3}) then {
        [_group] call PIG_fnc_detectedTimer;
    }
}];

// Simple EH for drawing attention of nearby units. Move them close to the fired position.
{
    _x addEventHandler ["FiredMan", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
    // Draw attention to nearby units (100m)
    _entities = (_unit nearEntities ["Man", 100]) select {(side _x == east) && {vehicle _x == _x}};
    {
        if (_x getVariable "PIG_unit_attention_drawed") then { continue }; // Check if the unit is in this variable, ignore it if it does
        private _grp = group _x;
        _grp setBehaviour "AWARE";
        _grp setSpeedMode "LIMITED"; // Unit will move with caution
        {
            _x doMove (getPos _unit);
            _x setVariable ["PIG_unit_attention_drawed", true]; // Store this unit in this variable
        }forEach units _grp;
    }forEach _entities;
}];
}forEach units _group
