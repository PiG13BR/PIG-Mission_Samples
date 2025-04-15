_markers = ["spawn_sam_1", 
    "spawn_sam_2", 
    "spawn_sam_3", 
    "spawn_sam_4", 
    "spawn_sam_5", 
    "spawn_sam_6", 
    "spawn_sam_7",
    "spawn_sam_8",
    "spawn_sam_9",
    "spawn_sam_10",
    "spawn_sam_11",
    "spawn_sam_12",
    "spawn_sam_13",
    "spawn_sam_14"
];

// Select marker for sam
_sam_1_marker = selectRandom _markers;

// Select a dif marker
_markers = _markers - [_sam_1_marker];
_sam_2_marker = selectRandom _markers;

// Select a dif marker
_markers = _markers - [_sam_2_marker];
_sam_3_marker = selectRandom _markers;

// Select a dif marker
_markers = _markers - [_sam_3_marker];
_radar_marker = selectRandom _markers;

opfor_sam_1 setPos (getMarkerPos _sam_1_marker);
opfor_sam_2 setPos (getMarkerPos _sam_2_marker);
opfor_sam_3 setPos (getMarkerPos _sam_3_marker);
opfor_radar_1 setPos (getMarkerPos _radar_marker);