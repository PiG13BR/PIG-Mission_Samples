// Save player loadout into profilenamespace
if (hasInterface) then {
    _loadout = getUnitLoadout player;
    profileNamespace setVariable ["OP_CORREDOR_LOADOUT", _loadout];
};