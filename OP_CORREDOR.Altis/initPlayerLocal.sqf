params[ "_player", "_didJIP" ];

player addEventHandler ["Killed", { player setVariable ["PIG_DeathLoadout", getUnitLoadout player]; }];
player addEventHandler ["Respawn", { private _loadout = player getVariable "PIG_DeathLoadout"; if (!isNil "_loadout") then { player setUnitLoadout _loadout; }; }];

// Intro
[str ("Operação Corredor Livre - Altis"), str("Horas antes da invasão"), str(date select 1) + "." + str(date select 2) + "." + str(date select 0) + " " + "|" + " " + str(date select 3) + ":" + str(date select 4)] call BIS_fnc_infoText;