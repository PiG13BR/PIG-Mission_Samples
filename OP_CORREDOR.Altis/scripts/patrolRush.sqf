params ["_grp"];

[_grp, 1000, 30, [], [getPos (leader _grp)], true] spawn lambs_wp_fnc_taskRush;