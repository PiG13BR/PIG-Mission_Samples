task01_completed = true;

// Spawn sam position while there's still fog
[
    [
        "spawn_sam_1", 
        "spawn_sam_2", 
        "spawn_sam_3", 
        "spawn_sam_4", 
        "spawn_sam_5", 
        "spawn_sam_6", 
        "spawn_sam_7",
        "spawn_sam_8",
        "spawn_sam_9",
        "spawn_sam_10",
        "spawn_sam_11",
        "spawn_sam_12",
        "spawn_sam_13",
        "spawn_sam_14"
    ]
] execVM "scripts\spawnSam.sqf";

sleep 5;

60 setFog [0.1, 0.1, 30];
60 setOvercast 0.3;

task02_create = true;

// Add crew to the VLS
_grp = createVehicleCrew uss_freedom_vls;
_grp setGroupIdGlobal ["Fire Sky (VLS)"];

[[west, "HQ"], "Sistema vertical de lança misseis disponível!"] remoteExec ["sideChat"];

sleep 10 + (random 30);

[getMarkerPos "heli_spawn", "O_Heli_Light_02_dynamicLoadout_F", east, 
    [
        "O_Soldier_SL_F", 
        "O_Soldier_AR_F", 
        "O_Soldier_GL_F", 
        "O_soldier_M_F", 
        "O_Soldier_AA_F", 
        "O_Soldier_AAT_F", 
        "O_Soldier_A_F", 
        "O_medic_F"
    ], 
getMarkerPos "heli_landing", [10,30] , 80, false, "scripts\patrolSam.sqf"] call PIG_fnc_heliDropTroops;