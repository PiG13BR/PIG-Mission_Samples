/*
    File: blacklist.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2020-05-11
    Last Update: 2020-08-05
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        List of blacklisted items for the arsenal, if KPLIB_presetArsenal is set to 0 in the config.
*/

// Blacklisted item classnames
KPLIB_arsenalBlacklist = [
    "B_AA_01_weapon_F",
    "B_AT_01_weapon_F",
    "B_GMG_01_A_weapon_F",
    "B_GMG_01_high_weapon_F",
    "B_GMG_01_weapon_F",
    "B_HMG_01_A_weapon_F",
    "B_HMG_01_high_weapon_F",
    "B_HMG_01_support_F",
    "B_HMG_01_support_high_F",
    "B_HMG_01_weapon_F",
    "B_Mortar_01_support_F",
    "B_Mortar_01_weapon_F",
    "B_Respawn_Sleeping_bag_blue_F",
    "B_Respawn_Sleeping_bag_brown_F",
    "B_Respawn_Sleeping_bag_F",
    "B_Respawn_TentA_F",
    "B_Respawn_TentDome_F",
    "B_UAV_01_backpack_F",
    "B_UAV_06_backpack_F",
    "B_UAV_06_medical_backpack_F",
    "B_UGV_02_Demining_backpack_F",
    "B_UGV_02_Science_backpack_F",
    "C_IDAP_UAV_01_backpack_F",
    "C_IDAP_UAV_06_antimine_backpack_F",
    "C_IDAP_UAV_06_backpack_F",
    "C_IDAP_UAV_06_medical_backpack_F",
    "C_IDAP_UGV_02_Demining_backpack_F",
    "C_UAV_06_backpack_F",
    "C_UAV_06_medical_backpack_F",
    "I_AA_01_weapon_F",
    "I_AT_01_weapon_F",
    "I_C_HMG_02_high_weapon_F",
    "I_C_HMG_02_support_F",
    "I_C_HMG_02_support_high_F",
    "I_C_HMG_02_weapon_F",
    "I_E_AA_01_weapon_F",
    "I_E_AT_01_weapon_F",
    "I_E_GMG_01_A_Weapon_F",
    "I_E_GMG_01_high_Weapon_F",
    "I_E_GMG_01_Weapon_F",
    "I_E_HMG_01_A_Weapon_F",
    "I_E_HMG_01_high_Weapon_F",
    "I_E_HMG_01_support_F",
    "I_E_HMG_01_support_high_F",
    "I_E_HMG_01_Weapon_F",
    "I_E_HMG_02_high_weapon_F",
    "I_E_HMG_02_support_F",
    "I_E_HMG_02_support_high_F",
    "I_E_HMG_02_weapon_F",
    "I_E_Mortar_01_support_F",
    "I_E_Mortar_01_Weapon_F",
    "I_E_UAV_01_backpack_F",
    "I_E_UAV_06_backpack_F",
    "I_E_UAV_06_medical_backpack_F",
    "I_E_UGV_02_Demining_backpack_F",
    "I_E_UGV_02_Science_backpack_F",
    "I_G_HMG_02_high_weapon_F",
    "I_G_HMG_02_support_F",
    "I_G_HMG_02_support_high_F",
    "I_G_HMG_02_weapon_F",
    "I_GMG_01_A_weapon_F",
    "I_GMG_01_high_weapon_F",
    "I_GMG_01_weapon_F",
    "I_HMG_01_A_weapon_F",
    "I_HMG_01_high_weapon_F",
    "I_HMG_01_support_F",
    "I_HMG_01_support_high_F",
    "I_HMG_01_weapon_F",
    "I_HMG_02_high_weapon_F",
    "I_HMG_02_support_F",
    "I_HMG_02_support_high_F",
    "I_HMG_02_weapon_F",
    "I_Mortar_01_support_F",
    "I_Mortar_01_weapon_F",
    "I_UAV_01_backpack_F",
    "I_UAV_06_backpack_F",
    "I_UAV_06_medical_backpack_F",
    "I_UGV_02_Demining_backpack_F",
    "I_UGV_02_Science_backpack_F",
    "O_AA_01_weapon_F",
    "O_AT_01_weapon_F",
    "O_GMG_01_A_weapon_F",
    "O_GMG_01_high_weapon_F",
    "O_GMG_01_weapon_F",
    "O_HMG_01_A_weapon_F",
    "O_HMG_01_high_weapon_F",
    "O_HMG_01_support_F",
    "O_HMG_01_support_high_F",
    "O_HMG_01_weapon_F",
    "O_Mortar_01_support_F",
    "O_Mortar_01_weapon_F",
    "O_UAV_01_backpack_F",
    "O_UAV_06_backpack_F",
    "O_UAV_06_medical_backpack_F",
    "O_UGV_02_Demining_backpack_F",
    "O_UGV_02_Science_backpack_F",
    "RHS_AGS30_Gun_Bag",
    "RHS_AGS30_Tripod_Bag",
    "RHS_DShkM_Gun_Bag",
    "RHS_DShkM_TripodHigh_Bag",
    "RHS_DShkM_TripodLow_Bag",
    "RHS_Kord_Gun_Bag",
    "RHS_Kord_Tripod_Bag",
    "RHS_Kornet_Gun_Bag",
    "RHS_Kornet_Tripod_Bag",
    "RHS_M2_Gun_Bag",
    "RHS_M2_MiniTripod_Bag",
    "RHS_M2_Tripod_Bag",
    "rhs_M252_Bipod_Bag",
    "rhs_M252_Gun_Bag",
    "RHS_Metis_Gun_Bag",
    "RHS_Metis_Tripod_Bag",
    "RHS_Mk19_Gun_Bag",
    "RHS_Mk19_Tripod_Bag",
    "RHS_NSV_Gun_Bag",
    "RHS_NSV_Tripod_Bag",
    "RHS_Podnos_Bipod_Bag",
    "RHS_Podnos_Gun_Bag",
    "RHS_SPG9_Gun_Bag",
    "RHS_SPG9_Tripod_Bag",
    "rhs_Tow_Gun_Bag",
    "rhs_TOW_Tripod_Bag",
    "UK3CB_BAF_L111A1",
    "UK3CB_BAF_L134A1",
    "UK3CB_BAF_L16_Tripod",
    "UK3CB_BAF_L16",
    "UK3CB_BAF_M6",
    "UK3CB_BAF_Tripod",
    "uns_M1_81mm_mortar_US_Bag",
    "uns_M1919_low_US_Bag",
    "uns_M2_60mm_mortar_US_Bag",
    "uns_m2_high_US_Bag",
    "uns_M2_low_US_Bag",
    "uns_M30_107mm_mortar_US_Bag",
    "uns_M60_high_US_Bag",
    "uns_M60_low_US_Bag",
    "uns_MK18_low_US_Bag",
    "uns_STABO_US_Bag",
    "uns_Tripod_Bag",
    "Uns_US_searchlight_Bag"
];