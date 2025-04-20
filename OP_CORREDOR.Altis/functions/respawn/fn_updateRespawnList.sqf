/*
	File: fn_updateRespawnList.sqf
	Author: PiG13BR
	Date: 2025/19/04
	Updated: 2025/19/04

	Description:
		Update the respawn list by checking the respawn objects

	Parameters:
		-

	Return:
		-
*/


private _respawn_list = [] call compileFinal preprocessFileLineNumbers "respawnList.sqf";
private _updatedList = [[],[]];

{
    // Check for nil variables and alive entities
    if ((!isNull _x) || {(alive _x) || {[_x] call ace_common_fnc_isAwake}}) then { 
        (_updatedList # 0) pushBackUnique ((_respawn_list # 0) select _forEachIndex); 
        (_updatedList # 1) pushBackUnique ((_respawn_list # 1) select _forEachIndex); 
    } else { continue };
}forEach _respawn_list # 1;

_updatedList