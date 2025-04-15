//Variables
task00_completed = false;
publicVariable "task00_completed"; // Required for client respawn list
task01_completed = false;
task01_create = false;
task02_create = false;
task02_completed = false;
task03_completed = false;
secTask01_completed = false;
QRF_land_called = false;
QRF_chopper_called = false;

// Get the gas station building
gas_station = nearestObject [gasLogic, "House"];

// Add EH for all east group already spawned
_groupsEast = groups east;
{
    if (count ((units _x) inAreaArray trigger_AO) > 0) then {
        [_x] call PIG_fnc_addEventHandlers
    };
}forEach _groupsEast;

// Weather
execVM "scripts\setFog.sqf";

addMissionEventHandler ["EntityKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
    // Roadkill
	if (isNull _instigator) then { deleteVehicle _unit }; // Delete body
    if ((side _unit isEqualTo east) && {side _killer isEqualTo east}) then { deleteVehicle _unit };
}];

// Military traffic
[
    {
        !task02_completed
    }, 
    "start_traffic", 
    east, 
    [
        "O_Truck_02_fuel_F",
        "O_Truck_02_box_F",
        "O_Truck_02_covered_F",
        "O_MRAP_02_hmg_F",
        "O_Truck_03_transport_F",
        "O_Truck_03_covered_F",
        "O_APC_Wheeled_02_rcws_v2_F"
    ], "middle_traffic", "end_traffic", 30
] spawn PIG_fnc_milTraffic;

while { true } do
{
    {
        _x addCuratorEditableObjects
        [
            allPlayers
        ];
    } count allCurators;
    sleep 10;
};