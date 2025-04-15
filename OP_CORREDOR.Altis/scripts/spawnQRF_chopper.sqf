if (QRF_chopper_called) exitWith {};

params["_lastKnowPos"];

[
    getMarkerPos "heli_spawn", 
    "O_Heli_Light_02_dynamicLoadout_F", 
    east, 
    [	
        "O_Soldier_SL_F", 
        "O_Soldier_AR_F", 
        "O_Soldier_GL_F", 
        "O_soldier_M_F", 
        "O_Soldier_A_F", 
        "O_medic_F"
    ], 
    _lastKnowPos, 
    [150,300], 
    120, 
    false, 
    "scripts\patrolHunt.sqf"
] call PIG_fnc_heliDropTroops;

QRF_chopper_called = true;