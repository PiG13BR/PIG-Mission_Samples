// https://youtu.be/t_IjrUiNjgo?si=n2j8Av-Th4L66ppv
// https://controlc.com/3dbe0a0a (Original code)
// [this] execVM "scripts\spotDeadBodies.sqf"

if (!isServer) exitWith {};

params["_unit", ["_distance", 12, [0]], ["_fieldOfView", 45, [0]], ["_searchTime", 25, [0]]];

private _grp = group _unit;
InternalFieldOfView = cos(_fieldOfView);

_fex_body_detection = {
    params["_deadBody", "_soldier"];

    // if (!canSuspend) exitWith {_this spawn _fex_body_detection};

    // calculating soldier's arc of view, comparing it with the position of the dead body
    _direction = vectorDir _soldier;
    _body_location = position _deadBody;
    _test_vector = vectorNormalized ((_body_location) vectorDiff (position _soldier));
    _dotProduct = (_test_vector) vectorDotProduct (_direction);
    _isInside = _dotProduct > InternalFieldOfView;

    //if the body is inside the arc, see if it isn't blocked by an object
    if (_isInside) then {
        _ins = lineIntersectsSurfaces
        [
        eyePos _soldier,
        eyePos _deadBody,
        _soldier,
        _deadBody,
        true,
        1,
        "GEOM",
        "NONE"
        ];
        //if not, make the soldier aware of the body
        if (isNil {_ins select 0}) then {
            //this is where you call a script with the soldier's reaction
            if (alive _soldier || {[_soldier] call ace_common_fnc_isAwake}) then {
                private _flare = createVehicle ["F_40mm_white", (getPos _soldier) vectorAdd [0,0,300], [], 30, "NONE"];
                _flare setVelocity [0,0,-15];
                [_soldier] execVM "scripts\foundBodyReaction.sqf";
                sleep 5; // Reaction time to call reinforcements. Schedule called from unschedule.
                [getMarkerPos "spawn_qrf_units", east, getPos _deadBody] execVM "scripts\spawnQRF_units.sqf";
            };
            _isInside = true;
        } else {
            _isInside = false;
        };
    //if the body is obstructed by an object, or outside the arc, do nothing		
    } else {
        _isInside = false;
        //hint "Soldier could not see any dead bodies in his field of view.";
    };

    _isInside
};

_fnc_PIG_deadBodiesSearch = {
    params ["_searchUnit", "_distance"];
    _bodyFound = false;

    _deadBodies = [];
    _deadBodies = allDeadMen select {_x distance _searchUnit < _distance};
    if (_deadBodies isNotEqualTo []) then {
        // Check soldier's field of view for each body
        {
            _insideAngle = [(_deadBodies select _forEachIndex), _searchUnit] call _fex_body_detection;
            if (_insideAngle) exitWith {_bodyFound = true}; // Exit loop if found a body within fov
        }forEach _deadBodies
    };

    _bodyFound // Return
};

while {!(_grp getVariable ["PIG_bodyFound", false])} do {
    //if ((group _unit) getVariable "PIG_bodyFound") exitWith {}; // This group will stop looking for more bodies
    private _bodyFound = [_unit, _distance] call _fnc_PIG_deadBodiesSearch;
    sleep 2;
};