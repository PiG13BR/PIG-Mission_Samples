// Put all weapons here
PIG_arsenalWeapons = (PIG_smgs + PIG_pistols);
// Put all Magazines, and throwable items such as grenades
PIG_arsenalMagazines = (PIG_mags + PIG_grenades);
// Put here uniforms, vests, facemasks, nvgs, binoculares, medical items, tool items, attachments...
PIG_arsenalItems = (PIG_uniforms + PIG_vests + PIG_pilot_helmets + PIG_facewears + PIG_rifles_optics + PIG_rail_attach + PIG_rifles_grip + PIG_binos + PIG_ace_commom_tools + PIG_ace_commom_medical_items + PIG_commom_items + PIG_radio + PIG_ace_misc);
// Put only backpacks here
PIG_arsenalBackpacks = (PIG_backpacks + PIG_backpacks_radio);

[] call compileFinal preprocessFileLineNumbers "presets\arsenal\init_arsenal.sqf";