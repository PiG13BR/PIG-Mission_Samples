waitUntil {sleep 1; alive player};

//-----------------------------------------------------------------
// Arsenal
[] call KPLIB_fnc_initArsenal;

[] execVM "scripts\opfor_sam_position.sqf";

saveMissionLoadout = compile preprocessFileLineNumbers "scripts\saveMissionloadout.sqf";

