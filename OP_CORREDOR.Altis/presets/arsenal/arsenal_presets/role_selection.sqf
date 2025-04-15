/* 
	Script by PiG13BR
*/

// Define roles classnames
_officer = "";
_tleader = "B_recon_TL_F";
_mg = "";
_rifleman = "";
_engineer = "B_recon_exp_F";
_medic = "B_recon_medic_F";
_rifleman_LAT = "";
_rifleman_LAT2 = "";
_rifleman_HAT = "";
_rifleman_HAT_assist = "";
_granadier = "";
_pilot = "";
_marksman = "B_recon_M_F";

// Get the class name (must match with one above!!)
_classRole = typeOf player;

switch (_classRole) do {
	case _officer : {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\officer_role.sqf";
	};
	case _tleader : {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\tleader_role.sqf";
	};
	case _mg : {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\mg_role.sqf";
	};
	case _rifleman : {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\rifleman_role.sqf";
	};
	case _medic : {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\medic_role.sqf";
	};
	case _engineer : {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\engineer_role.sqf";
	};
	case _rifleman_LAT : {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\lat_role.sqf";
	};
	case _rifleman_LAT2: {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\lat2_role.sqf";
	};
	case _rifleman_HAT : {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\hat_role.sqf";
	};
	case _rifleman_HAT_assist : {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\rifleman_role.sqf";
	};
	case _granadier : {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\granadier_role.sqf";
	};
	case _marksman : {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\marksman_role.sqf";
	};
	case _pilot : {
		[] call compileFinal preprocessFileLineNumbers "presets\arsenal\arsenal_presets\roles\pilot_role.sqf";
	};
	case default {	
	["No classname match found, check the role_selection.sqf"] call bis_fnc_error
	}
}