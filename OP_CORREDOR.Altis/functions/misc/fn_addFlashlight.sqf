/*
    Author: PiG13BR

    Description
        Remove night vision and add flashlights to the unit. Force flashlights on.
*/

if (!isServer) exitWith {};

params ["_unit"];

_unit unlinkItem hmd _unit;
_unit addPrimaryWeaponItem "acc_flashlight"; 
_unit enableGunLights "forceOn";