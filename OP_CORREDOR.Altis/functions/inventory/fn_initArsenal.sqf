/*
    File: fn_initArsenal.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2020-05-11
    Last Update: 2020-09-26
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Loads the arsenal preset and adjusts the available arsenal gear accordingly.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

private _crawled = [] call KPLIB_fnc_crawlAllItems;

PIG_arsenalWeapons = [];
PIG_arsenalMagazines = [];
PIG_arsenalItems = [];
PIG_arsenalBackpacks = [];
KPLIB_arsenalBlacklist = [];
KPLIB_arsenalAllowed = [];
KPLIB_arsenalAllowedExtension = [];
PIG_arsenalConfig_ready = false;
PIG_roleSelection_ready = false;

[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\arsenal_config.sqf";
//waitUntil {sleep 0.1; PIG_arsenalConfig_ready};
[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\role_selection.sqf";
//waitUntil {sleep 0.1; PIG_roleSelection_ready};
[] call compile preprocessFileLineNumbers "presets\arsenal\allowedExtension.sqf";
//[] call compile preprocessFileLineNumbers "presets\arsenal\blacklist.sqf";


if (PIG_arsenalWeapons isEqualTo []) then {PIG_arsenalWeapons = (_crawled select 0) select {!(_x in KPLIB_arsenalBlacklist)};};
[missionNamespace, PIG_arsenalWeapons] call BIS_fnc_addVirtualWeaponCargo;
KPLIB_arsenalAllowed append PIG_arsenalWeapons;

if (PIG_arsenalMagazines isEqualTo []) then {PIG_arsenalMagazines = (_crawled select 1) select {!(_x in KPLIB_arsenalBlacklist)};};
[missionNamespace, PIG_arsenalMagazines] call BIS_fnc_addVirtualMagazineCargo;
KPLIB_arsenalAllowed append PIG_arsenalMagazines;

if (PIG_arsenalItems isEqualTo []) then {PIG_arsenalItems = (_crawled select 2) select {!(_x in KPLIB_arsenalBlacklist)};};
[missionNamespace, PIG_arsenalItems] call BIS_fnc_addVirtualItemCargo;
KPLIB_arsenalAllowed append PIG_arsenalItems;

if (PIG_arsenalBackpacks isEqualTo []) then { PIG_arsenalBackpacks = (_crawled select 3) select {!(_x in KPLIB_arsenalBlacklist)};};
[missionNamespace, PIG_arsenalBackpacks] call BIS_fnc_addVirtualBackpackCargo;
KPLIB_arsenalAllowed append PIG_arsenalBackpacks;

[player, (PIG_arsenalWeapons + PIG_arsenalMagazines + PIG_arsenalItems + PIG_arsenalBackpacks)] call ace_arsenal_fnc_addVirtualItems;

// Support for CBA disposable launchers, https://github.com/CBATeam/CBA_A3/wiki/Disposable-Launchers
if !(configProperties [configFile >> "CBA_DisposableLaunchers"] isEqualTo []) then {
    private _disposableLaunchers = ["CBA_FakeLauncherMagazine"];
    {
        private _loadedLauncher = cba_disposable_LoadedLaunchers get _x;
        if (!isNil "_loadedLauncher") then {
            _disposableLaunchers pushBack _loadedLauncher;
        };

        private _normalLauncher = cba_disposable_NormalLaunchers get _x;
        if (!isNil "_normalLauncher") then {
            _normalLauncher params ["_loadedLauncher"];
            _disposableLaunchers pushBack _loadedLauncher;
        };
    } forEach KPLIB_arsenalAllowed;
    KPLIB_arsenalAllowed append _disposableLaunchers;
};

{
    // Handle CBA optics, https://github.com/CBATeam/CBA_A3/wiki/Scripted-Optics
    if (missionNamespace getVariable ["CBA_optics", false]) then {
        private _pipOptic = CBA_optics_PIPOptics getVariable _x;
        if (!isNil "_pipOptic") then {
            KPLIB_arsenalAllowedExtension pushBackUnique _pipOptic;
        };

        private _nonPipOptic = CBA_optics_NonPIPOptics getVariable _x;
        if (!isNil "_nonPipOptic") then {
            KPLIB_arsenalAllowedExtension pushBackUnique _nonPipOptic;
        };
    };

    // Handle CBA (MRT) Accessories, https://github.com/CBATeam/CBA_A3/wiki/Accessory-Functions
    private _itemCfg = configFile >> "CfgWeapons" >> _x;
    if (!isNull _itemCfg) then {
        private _nextItem = getText (_itemCfg >> "MRT_SwitchItemPrevClass");
        if (_nextItem != "") then {
            KPLIB_arsenalAllowedExtension pushBackUnique _nextItem;
        };

        private _prevItem = getText (_itemCfg >> "MRT_SwitchItemNextClass");
        if (_prevItem != "") then {
            KPLIB_arsenalAllowedExtension pushBackUnique _prevItem;
        };
    };
} forEach KPLIB_arsenalAllowed;

KPLIB_arsenalAllowed append KPLIB_arsenalAllowedExtension;

// Lowering to avoid issues with incorrect capitalized classnames in KPLIB_fnc_checkGear
KPLIB_arsenalAllowed = KPLIB_arsenalAllowed apply {toLower _x};

true