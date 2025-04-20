/*
	Author: PiG13BR
*/

private _respawnList = [];

if (!task00_completed) then {
	// At start, spawning in the uss liberty is posible
	_respawnList = [
		["USS Liberty"],
		[respawn_uss_liberty]
	]
} else {
	_humanRP = [];
	// After reaching the beach, uss liberty rp will became unavailable. Only human rp in the AO.
	_humanRP = (units groupPlayers) select {(vehicle _x == _x) && {_x inArea trigger_AO} && {(alive _x) || {!([_x] call PIG_fnc_aceCheckUnitUnconscious)}}};
	if (count _humanRP == 0) exitWith {_respawnList = []};
	_respawnList = [
		// At start, spawning in the uss liberty is posible
		[], // It will get the profile names
		_humanRP
	]
};

// Return
_respawnList