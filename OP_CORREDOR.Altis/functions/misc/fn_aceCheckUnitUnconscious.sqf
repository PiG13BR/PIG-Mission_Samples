/*
	File: fn_aceCheckUnitUnconscious.sqf
	Author: PiG13BR
	Date: 2024-10-11
    Last Update: 2024-10-11
    License: MIT License - http://www.opensource.org/licenses/MIT

	Description:
		Check unit unconscious state (ACE)

	Parameter(s):
		_unit - unit to check state [OBJECT - Infantry unit]
	
	Returns:
		State of the unit [BOOL]
*/

params ["_unit"];

_unconscious = false;

_unconscious = [_unit] call ace_common_fnc_isAwake;

_unconscious