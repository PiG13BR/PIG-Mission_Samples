params ["_markers"];

// Select marker for sam
_sam_1_marker = selectRandom _markers;
opfor_sam_1 = createVehicle ["O_SAM_System_04_F", (getMarkerPos _sam_1_marker)];

// Select a dif marker
_markers = _markers - [_sam_1_marker];
_sam_2_marker = selectRandom _markers;
opfor_sam_2 = createVehicle ["O_SAM_System_04_F", (getMarkerPos _sam_2_marker)];

_markers = _markers - [_sam_2_marker];
_sam_3_marker = selectRandom _markers;
opfor_sam_3 = createVehicle ["O_SAM_System_04_F", (getMarkerPos _sam_3_marker)];

_markers = _markers - [_sam_3_marker];
_radar_marker = selectRandom _markers;
opfor_radar_1 = createVehicle ["O_SAM_System_04_F", (getMarkerPos _radar_marker)];

{[_x] execVm "scripts\addEH_SAM.sqf"}forEach [opfor_sam_1, opfor_sam_2, opfor_sam_3, opfor_radar_1]