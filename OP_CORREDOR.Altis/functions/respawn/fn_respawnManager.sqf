/*
	File: fn_respawnManager.sqf
	Author: PiG13BR
	Date: 2024/10/07
	Updated: 2025/19/04

	Description:
		Function for handling the respawn menu. It should run on each client separately.

	Parameters:
		_player - player unit [OBJECT, defaults to player]
		_dist - distance to detect enemies nearby [NUMBER, defaults to 100]
		_enemySide - enemy side [SIDE, defaults to EAST]

	Return:
		-
*/

/*
	// On respawn, don't close dialog with ESC button
	_display = findDisplay 2000;
	_display displayAddEventHandler ["KeyDown", {(_this select 1) isEqualTo 1}];
*/

createDialog "PiG_RscRespawnMenu";

params[
	["_player", player, [objNull]],
	["_dist", 100, [0]],
	["_enemySide", east, [sideUnknown]]
];

uiNamespace setVariable ["PIG_playerObject", _player];

// Create the camera using the player pos
respawn_camera = "camera" camCreate (getposATL player);
camUseNVG false;

// Get the respawn object list
PIG_respawnList = [] call PIG_fnc_updateRespawnList;

if (count (PIG_respawnList # 1) == 0) exitWith {["No respawn point provided or not available"] call bis_fnc_error};

lbClear 592100;
// Add to the list box
{
	// Only alive objects
	private _name = "";
	// Check if it's human
	if (_x isKindOf "Man") then {
		_name = name _x; // Get profile name or the name of the entity if it's an AI
	} else {
		_name = (PIG_respawnList select 0) select _forEachIndex;
	};
	lbAdd [592100, _name];
}forEach (PIG_respawnList select 1);

// Force select the first element of the list box
if (lbCurSel 592100 == -1) then {
	lbSetCurSel [592100, 0];
};

_offSet = 20;
respawn_object = (PIG_respawnList select 1) select (lbCurSel 592100);
if (respawn_object == respawn_uss_liberty) then {_offSet = 70};

// Set camera target
respawn_camera camSetTarget respawn_object;
respawn_camera cameraEffect ["internal","back"];
respawn_camera camSetPos [(getpos respawn_object select 0) - _offSet, (getpos respawn_object  select 1) + _offSet, (getpos respawn_object  select 2) + _offSet];
respawn_camera camcommit 0;
respawn_camera camSetPos [(getpos respawn_object select 0) - _offSet, (getpos respawn_object  select 1) - _offSet, (getpos respawn_object  select 2) + _offSet];
respawn_camera camcommit 60;

(displayCtrl 592100) ctrlAddEventHandler ["LBSelChanged", {
	params ["_control", "_lbCurSel", "_lbSelection"];
	_offSet = 20;
	respawn_object = (PIG_respawnList select 1) select _lbCurSel;
	if (respawn_object == respawn_uss_liberty) then {_offSet = 70};
	
	// Set camera target
	respawn_camera camSetTarget respawn_object;
	respawn_camera cameraEffect ["internal","back"];
	respawn_camera camSetPos [(getpos respawn_object select 0) - _offSet, (getpos respawn_object  select 1) + _offSet, (getpos respawn_object  select 2) + _offSet];
	respawn_camera camcommit 0;
	respawn_camera camSetPos [(getpos respawn_object select 0) - _offSet, (getpos respawn_object  select 1) - _offSet, (getpos respawn_object  select 2) + _offSet];
	respawn_camera camcommit 60;

}];

(displayCtrl 591600) ctrlAddEventHandler ["ButtonClick", {
	params ["_control"];
	private _player = uiNamespace getVariable ["PIG_playerObject", player];

	if (respawn_object == respawn_uss_liberty) then {
		_player setVehiclePosition [respawn_object, [], 5, "CAN_COLLIDE"];
	} else {
		_player setposATL [((getPos respawn_object select 0) + 5) - (random 10),((getPos respawn_object select 1) + 5) - (random 10),(getPos respawn_object select 2)];
	};
	// Modify player's stance if respawn point is human
	if (respawn_object isKindOf "Man") then {
		_stance = unitPos respawn_object;
		switch _stance do {
			case "Up" : {
				_player playAction "PlayerStand";
			};
			case "Middle" : {
				_player playAction "PlayerCrouch";
			};
			case "Down" : {
				_player playAction "PlayerProne";
			};
		}
	};
	closeDialog 0;
}];

// Run while loop to check for enemies nearby and update the list
[_dist, _enemySide] spawn {
	params ["_dist", "_enemySide"];
	while {dialog} do {
	
		// Update list
		lbClear 592100;
		PIG_respawnList = [] call PIG_fnc_updateRespawnList;
		{
			// Only alive objects
			private _name = "";
			// Check if it's human
			if (_x isKindOf "Man") then {
				_name = name _x; // Get profile name or the name of the entity if it's an AI
			} else {
				_name = (PIG_respawnList select 0) select _forEachIndex;
			};
			lbAdd [592100, _name];
		}forEach (PIG_respawnList select 1);

		// Check for enemies nearby
		if ((respawn_object isKindOf "landVehicle") || (respawn_object isKindOf "Man")) then {
		private _nearE = (respawn_object nearEntities [["Man","Landvehicle"], _dist]) select {(side _x == _enemySide)};
			if ({alive _x} count _nearE >= 1) then {
				ctrlSetText [591600, localize "STR_RESPAWN_MENU_DEPLOY_NOT_AVAILABLE"];
				ctrlEnable [591600, false];
			} else {
				ctrlSetText [591600, localize "STR_RESPAWN_MENU_DEPLOY"];
				ctrlEnable [591600, true];
			}
		// Not a mobile/human respawn
		} else {
			ctrlSetText [591600, localize "STR_RESPAWN_MENU_DEPLOY"];
			ctrlEnable [591600, true];
		};
		sleep 0.5;
	};
};

// Closing dialog
(findDisplay 5959) displayAddEventHandler ["Unload", {
	// Delete variable
	PIG_respawnList = nil;
	// respawn_object = nil;

	respawn_camera cameraEffect ["Terminate","back"];
	camDestroy respawn_camera;
}];
