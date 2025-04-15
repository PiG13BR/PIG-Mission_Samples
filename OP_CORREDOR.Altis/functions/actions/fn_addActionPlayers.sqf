/* 
	Author: PiG13BR
	fn_addActionPlayers.sqf

	Description:
	Each player will receive these addActions.

	Parameters:
	0 - OBJECT (player)

	Return:
	-
*/

params ["_player"];

// -----------------------------------------------------------------------------------
// ARSENAL

_player addAction [["<img size='2' image='images\icons\ui_arsenal.paa'/>", "<t size='1.3' color='#E99B00'>", "ARSENAL", "</t>"] joinString "", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[] execVM "presets\arsenal\open_arsenal.sqf";
}, nil, 1000, true, true, "", "
isNull (objectParent _this)
&& {
	alive _this
}
&& {
	_this distance arsenal_players < 6
}"];
