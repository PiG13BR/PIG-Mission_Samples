/*
	File: fn_respawnManager.sqf
	Author: PiG13BR
	Date: -
	Updated: 2025/13/04

	Description:
	Function for handling the respawn menu

	Parameters:
	-

	Return:
	-
*/

/*
	// On respawn, don't close dialog with ESC button
	_display = findDisplay 2000;
	_display displayAddEventHandler ["KeyDown", {(_this select 1) isEqualTo 1}];
*/

createDialog "PiG_RscRespawnMenu";

// Create the camera using the player pos
respawn_camera = "camera" camCreate (getposATL player);
camUseNVG false;


// Get the respawn object list
PIG_respawnList = [] call compileFinal preprocessFileLineNumbers "scripts\respawnList.sqf";

if (count PIG_respawnList == 0) exitWith {["No respawn point provided or available."] call bis_fnc_error};

lbClear 2100;
// Add to the list box
{
	// Only alive objects
	if (alive _x) then {
		private _name = "";
		if (_x isKindOf "Man") then {
			_name = name _x; // Get profile name
		} else {
			_name = (PIG_respawnList select 0) select _forEachIndex;
		};
		lbAdd [2100, _name];
	} else {
		hint "";
	}
}forEach (PIG_respawnList select 1);

// Force select the first element of the list box
if (lbCurSel 2100 == -1) then {
	lbSetCurSel [2100, 0];
};

respawn_object = (PIG_respawnList select 1) select (lbCurSel 2100);

// Mobile respawn? Human respawn point? Make sure enemies are not nearby
if ((respawn_object isKindOf "landVehicle") || {respawn_object isKindOf "Man"}) then {
	private _nearE = (respawn_object nearEntities [["Man","Landvehicle"], 100]) select {(side _x == east)};
	if ({alive _x} count _nearE >= 1) then {
		ctrlSetText [1600, "Não Disponível"];
		ctrlEnable [1600, false];
	} else {
		ctrlSetText [1600, "Realocar"];
		ctrlEnable [1600, true];
	}
// Not a mobile respawn
} else {
	ctrlSetText [1600, "Realocar"];
	ctrlEnable [1600, true];
};


// Set camera target
respawn_camera camSetTarget respawn_object;
respawn_camera cameraEffect ["internal","back"];
respawn_camera camSetPos [(getpos respawn_object select 0) - 70, (getpos respawn_object  select 1) + 70, (getpos respawn_object  select 2) + 70];
respawn_camera camcommit 0;
respawn_camera camSetPos [(getpos respawn_object select 0) - 70, (getpos respawn_object  select 1) - 70, (getpos respawn_object  select 2) + 70];
respawn_camera camcommit 60;

(displayCtrl 2100) ctrlAddEventHandler ["LBSelChanged", {
	params ["_control", "_lbCurSel", "_lbSelection"];

	respawn_object = (PIG_respawnList select 1) select _lbCurSel;

	// Mobile respawn? Human respawn point? Make sure enemies are not nearby
	if ((respawn_object isKindOf "landVehicle") || {respawn_object isKindOf "Man"}) then {
		private _nearE = (respawn_object nearEntities [["Man","Landvehicle"], 100]) select {(side _x == east)};
		if ({alive _x} count _nearE >= 1) then {
			ctrlSetText [1600, "Não Disponível"];
			ctrlEnable [1600, false];
		} else {
			ctrlSetText [1600, "Realocar"];
			ctrlEnable [1600, true];
		}
	// Not a mobile respawn
	} else {
		ctrlSetText [1600, "Realocar"];
		ctrlEnable [1600, true];
	};

	// Set camera target
	respawn_camera camSetTarget respawn_object;
	respawn_camera cameraEffect ["internal","back"];
	respawn_camera camSetPos [(getpos respawn_object select 0) - 70, (getpos respawn_object  select 1) + 70, (getpos respawn_object  select 2) + 70];
	respawn_camera camcommit 0;
	respawn_camera camSetPos [(getpos respawn_object select 0) - 70, (getpos respawn_object  select 1) - 70, (getpos respawn_object  select 2) + 70];
	respawn_camera camcommit 60;

}];

(displayCtrl 1600) ctrlAddEventHandler ["ButtonClick", {
	params ["_control"];
	if (respawn_object == respawn_uss_liberty) then {
		player setVehiclePosition [respawn_object, [], 5, "CAN_COLLIDE"];
	} else {
		player setposATL [((getPos respawn_object select 0) + 5) - (random 10),((getPos respawn_object select 1) + 5) - (random 10),(getPos respawn_object select 2)];
	};
	// Modify player's stance if respawn point is human
	if (respawn_object isKindOf "Man") then {
		_stance = unitPos respawn_object;
		switch _stance do {
			case "Up" : {
				player playAction "PlayerStand";
			};
			case "Middle" : {
				player playAction "PlayerCrouch";
			};
			case "Down" : {
				player playAction "PlayerProne";
			};
		}
	};
	closeDialog 0;
}];

// Closing dialog
(findDisplay 6666) displayAddEventHandler ["Unload", {
	// Clear variables
	respawn_object = nil;
	PIG_respawnList = nil;

	respawn_camera cameraEffect ["Terminate","back"];
	camDestroy respawn_camera;
}];