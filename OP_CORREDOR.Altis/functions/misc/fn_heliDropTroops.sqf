/*
	File: fn_heliDropTroops.sqf
	Author: PiG13BR
	Date: 2025/04/05
	Updated: 2025/13/05

	Description:
		Spawn a helicopter with troops on it. It will drop the troops in the position and return to the spawn position to despawn as default.
		The infantry actions and heli action after dropping troops will be determined by the _scriptTroops and _scriptHeli parameters, respectively.
		As default the helicopter will despawn at spawn point.
		As default the troops on the ground will stay in the drop area

	Parameter(s):
		_spawnHeli - spawn position of the helicopter and troops. The troops will be moved into heli's cargo. [POSITION]
		_heliType - classname of the helicopter [STRING]
		_side - side of the helicopter and troops [SIDE]
		_units - classnames of the units [ARRAY]
		_centerPos - position where the troops will be dropped [POSITION]
		_centerRadius - radius from the _centerPos, min and max values [ARRAY, defaults to [10,100]]
		_flyInHeight - [NUMBER, defaults to 120]
		_airDrop - land or paradrop units? [BOOL, defaults to FALSE]
		_scriptTroops - script path for the troops on the ground. By default the units will patrol the area using BIS_fnc_taskPatrol. [STRING, defaults to ""].
			Argument passed for the troop's script is: [_groupTroops]
		_scriptHeli - script path for the heli after dropping units. By default the heli will RTB and despawn in the same spawn position [STRING, defaults to ""]
			Arguments passed for the heli's script are: [_groupPilot, _safePos]

	Return(s):
		ARRAY
			_heli - Spawned helicopter (OBJECT)
			_groupTroops - Infantry troops (GROUP)
			_centerPos - Position of landing/paradrop (POSITION)
*/

if (!isServer) exitWith {};

params[
	"_spawnHeli",
	"_heliType",
	"_side",
	"_units",
	"_centerPos",
	["_centerRadius", [10, 100], [[]], [2]],
	["_flyInHeight", 120, [0]],
	["_airDrop", false, [FALSE]],
	["_scriptTroops", "", [""]],
	["_scriptHeli", "", [""]]
];

// Heli spawn
private _heli = createVehicle [_heliType, _spawnHeli, [], 10, "FLY"];
_heli allowDamage false; // Safety
// Create the crew for this heli
// (DrPastah) createVehicleCrew does not work with Transport Unload waypoints for helicopters. You need to spawn the pilots separately and then get them into the helicopter in order to get Transport Unload waypoints to work.
// Create just to get the classnames
_heliCrewPlaceHolder = createVehicleCrew _heli;
private _groupPilot = createGroup _side;

{	
	_crewType = typeOf _x;
	_crewUnit = _groupPilot createUnit [_crewType, _spawnHeli, [], 10, "NONE"];
	deleteVehicle _x; // Delete the placeholder crew
	_crewUnit moveInAny _heli; // driver > commander > gunner
}forEach units _heliCrewPlaceHolder;

deleteGroup _heliCrewPlaceHolder;

private _pilot = driver _heli;
_pilot allowFleeing 0;
_pilot setSkill 1;

{_x allowDamage false}forEach units _groupPilot; // Safety

// Pilot behaviour
_groupPilot setBehaviour "CARELESS";
_groupPilot setCombatMode "BLUE";
{_x disableAI "TARGET"}forEach units _groupPilot;

_heli flyInHeight [_flyInHeight, true];

// Spawn troops and move into heli's cargo
private _groupTroops = [_spawnHeli, _side, _units,[], [], [], [], [], 0, false] call BIS_fnc_spawnGroup;
{_x allowDamage false}forEach units _groupTroops; // Safety
{_x moveInCargo _heli} forEach units _groupTroops;
_groupTroops setBehaviour "AWARE";
_groupTroops setCombatMode "RED";
if (_scriptTroops isNotEqualTo "") then {
	_groupTroops setVariable ["PIG_scriptTroops", _scriptTroops]; // Store script into a variable
};
{_x allowDamage true}forEach units _groupTroops;

// Allow damage for helicopter and it's crew
{_x allowDamage true}forEach units _groupPilot;
_heli allowDamage true;
_heli allowCrewInImmobile true;

// Heli first waypoint
private _min = (_centerRadius # 0);
private _max = (_centerRadius # 1);

private _safePos = [_centerPos, _min , _max, 5, 0, 0.2, 0, [blacklist_area_1, blacklist_area_2]] call BIS_fnc_findSafePos;
private _wp1 = _groupPilot addWaypoint [_safePos, 10];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "FULL";
_wp1 setWaypointCompletionRadius 100;

// Troops waypoint
private _wp1Troops = _groupTroops addWaypoint [_safePos, 20];

_groupPilot setVariable ["PIG_centerPos_land", _safePos]; // Store the land position into a variable

// Land area/Air drop
if (!_airDrop) then {
	_wp1Troops setWaypointType "GETOUT";

	// Land and disembark
	createVehicle ["Land_HelipadEmpty_F", _safePos, [], 10, "NONE"];
	private _wp2 = _groupPilot addWaypoint [_safePos, 10];
	_wp2 setWaypointType "TR UNLOAD";
	_wp2 setWaypointStatements [
		// Condition
		toString {
			this distance2d ((group this) getVariable "PIG_centerPos_land") < 200
		}, 
		// On activation
		toString {
			(vehicle this) land "get out";
			{
				_unit = (_x # 0);
				unassignVehicle _unit;
				[_unit] allowGetIn false;
			}forEach ((fullCrew [(vehicle this), "cargo", false])); 
		}
	];
	if (_scriptHeli isEqualTo "") then {
		// RTB
		private _wp3 = _groupPilot addWaypoint [_spawnHeli, 10];
		_wp3 setWaypointType "MOVE";
		_wp3 setWaypointStatements [
			// Condition
			toString {
				true
			},
			// On activation
			toString {
				{
					deleteVehicle _x
				} foreach thisList + [vehicle this]
			}
		];
	} else {
		[_groupPilot, _safePos] execVM _scriptHeli;
	}
} else {
	// Paradrop
	_wp1Troops setWaypointType "MOVE";

	private _offset_dir = vectorNormalized (_safePos vectorFromTo _spawnHeli);
	private _offset_pos = _safePos vectorAdd (_offset_dir vectorMultiply -500);
	_offset_pos set [2,0];
	private _heli_wp_offset = _groupPilot addWaypoint [_offset_pos, 50];
	_heli_wp_offset setWaypointType "MOVE";
	_heli_wp_offset setWaypointSpeed "FULL";
	_heli_wp_offset setWaypointCompletionRadius 200;

	_wp1 setWaypointStatements [
		// Condition
		toString {
			(this distance2d ((group this) getVariable "PIG_centerPos_land") < 300) || (damage (vehicle this) > 0.2)
		},
		// On activation
		toString {
			[this] spawn {
				params ["_this"];
				{
					_unit = (_x # 0);
					removeBackpack _unit; 
					_unit addBackPack "B_parachute";
					unassignVehicle _unit;
    				moveout _unit;
					sleep 0.5
    			}forEach ((fullCrew [(vehicle _this), "cargo", false])); 
			}
		}
	];
	if (_scriptHeli isEqualTo "") then {
		// RTB
		_wp2 = _groupPilot addWaypoint [_spawnHeli, 10];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointCompletionRadius 100;
		_wp2 setWaypointStatements [
			// Condition
			toString {
				true
			},
			// On activation
			toString {
				{
					deleteVehicle _x
				} foreach thisList + [vehicle this]
			}
		];
	} else {
		[_groupPilot, _safePos] execVM _scriptHeli;
	}
};

if (_scriptTroops isEqualTo "") then {
	_wp1Troops setWaypointStatements [
		// Condition
		toString {
			true
		},
		// On activation
		toString {
			[(group this), (getPos this), 300] call BIS_fnc_taskPatrol;
		}
	];
} else {
	_wp1Troops setWaypointStatements [
		// Condition
		toString {
			{isTouchingGround _x} count units (group this) == {(alive _x) && ([_x] call ace_common_fnc_isAwake)} count units (group this)
		},
		// On activation
		toString {
			[group this] execVM ((group this) getVariable "PIG_scriptTroops");
		}
	];
};

[_heli, _groupTroops, _safePos]
