// Put all weapons here
PIG_arsenalWeapons = (PIG_rifles_marksman + PIG_pistols);
// Put all Magazines, and throwable items such as grenades
PIG_arsenalMagazines = (PIG_mags + PIG_grenades);
// Put here uniforms, vests, facemasks, nvgs, binoculares, medical items, tool items, attachments...
PIG_arsenalItems = (PIG_uniforms + PIG_vests + PIG_helmets + PIG_caps + PIG_facewears + PIG_rail_attach + PIG_rifles_grip + PIG_rifles_bipod + PIG_binos + PIG_ace_commom_tools + PIG_ace_commom_medical_items + PIG_commom_items + PIG_radio + PIG_ace_misc + PIG_marskman_optics + PIG_nvgs + PIG_uav_terminals + PIG_portable_drones);
// Put only backpacks here
PIG_arsenalBackpacks = (PIG_backpacks);

[] call compileFinal preprocessFileLineNumbers "presets\arsenal\init_arsenal.sqf";