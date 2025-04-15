params ["_veh"];

_veh addEventHandler ["HandleDamage", {
    params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];

    if (!_directHit && _damage > 0.5) then {
        _unit setDamage 1; 
        _unit removeEventHandler [_thisEvent, _thisEventHandler]
    };
}];