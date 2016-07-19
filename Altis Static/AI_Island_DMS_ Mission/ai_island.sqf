/*
	"Ai Island" static mission for Altis.
	Created by [CiC]red_ned using templates by eraser1 
	Credits to "Kroenen" for creating the base.
	17 years of CiC http://cic-gaming.co.uk
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [8476.27,25123.1,4.0095582];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
[8435.86,25050.7,0],
[8424.41,25054.5,0],
[8473.88,25057.6,0],
[8467.45,25054.6,0],
[8480.42,25081.6,0],
[8490.28,25075.3,0],
[8549.45,25043.7,0],
[8450.97,25177,0],
[8440.4,25184.4,0],
[8400.37,25149.9,0.753296],
[8479.99,25185.3,0],
[8484.67,25182.5,0],
[8488.71,25179.6,0],
[8493.91,25162.5,0],
[8543.77,25149.9,0],
[8551.9,25119.1,0],
[8514.54,25097.9,0],
[8483.86,25110.1,0],
[8435.38,25116.4,0],
[8447.62,25104.2,0],
[8438.01,25135.3,0],
[8436.95,25170.6,0],
[8442.45,25198.6,0],
[8449.65,25207.8,0],
[8381.02,25109.4,0],
[8379.57,25116.6,0],
[8415.75,25011.5,0],
[8490.89,25135.1,0],
[8512.8,25124.9,0],
[8518.46,25095.5,0],
[8519.71,25092.4,0],
[8533.05,25098.9,0],
[8463.94,25163.6,0]
];

// Create AI
_AICount = 30 + (round (random 5));


_group =
[
	_AISoldierSpawnLocations+[_pos,_pos,_pos],			// Pass the regular spawn locations as well as the center pos 3x
	_AICount,
	_difficulty,
	"random",
	_side
] call DMS_fnc_SpawnAIGroup_MultiPos;


_staticGuns =
[
	[
		_pos vectorAdd [-20,0,0],		// 5 meters West of center pos
		_pos vectorAdd [0,-5,0],		// 5 meters South of center pos
		[8484.460938,25136.369141,11.476425],	
		[8549.388672,25137.927734,1.074234],		
		[8476.307617,25122.962891,0.00145721],
		[8471.302734,25081.150391,9.855461]
	],
	_group,
	"assault",
	_difficulty,
	"bandit",
	"random"
] call DMS_fnc_SpawnAIStaticMG;



// Define the classnames and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions =
[
	[[8443.98,25179.5,0],"I_CargoNet_01_ammo_F"],
	[[8482.86,25078.1,0],"I_CargoNet_01_ammo_F"],
	[[8547.06,25050.9,0],"I_CargoNet_01_ammo_F"]
];

{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list
_crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;


// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;
_crate1 = [_crateClasses_and_Positions select 1 select 1, _crateClasses_and_Positions select 1 select 0] call DMS_fnc_SpawnCrate;

// Disable smoke on the crates so that the players have to search for them >:D
{
	_x setVariable ["DMS_AllowSmoke", false];
} forEach [_crate0,_crate1];

/*
// Don't think an armed AI vehicle fit the idea behind the mission. You're welcome to uncomment this if you want.
_veh =
[
	[
		[_pos,100,random 360] call DMS_fnc_SelectOffsetPos,
		_pos
	],
	_group,
	"assault",
	_difficulty,
	_side
] call DMS_fnc_SpawnAIVehicle;
*/


// Define mission-spawned AI Units
_missionAIUnits =
[
	_group 		// We only spawned the single group for this mission
];

// Define the group reinforcements
_groupReinforcementsInfo =
[
	[
		_group,			// pass the group
		[
			[
				0,		// Let's limit number of units instead...
				0
			],
			[
				100,	// Maximum 100 units can be given as reinforcements.
				0
			]
		],
		[
			120,		// About a 4 minute delay between reinforcements.
			diag_tickTime
		],
		_AISoldierSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			20,			// Reinforcements will only trigger if there's fewer than 10 members left in the group
			6			// 7 reinforcement units per wave.
		]
	]
];

// Define mission-spawned objects and loot values
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[],
	[[_crate0,[50,150,15]],[_crate1,[50,150,15]]]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "A large group of Admins have invaded the island and are drinking beer and eating cake"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the Admins and claimed all the cake and beer for themselves!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The Admins have finished their beer and cake and buggered off..."];

// Define mission name (for map marker and logging)
_missionName = "Ai Island";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficulty
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 20;
_circle setMarkerSize [300,300];


_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =
[
	_pos,
	[
		[
			"kill",
			_group
		],
		[
			"playerNear",
			[_pos,100]
		]
	],
	_groupReinforcementsInfo,
	[
		_time,
		DMS_StaticMissionTimeOut call DMS_fnc_SelectRandomVal
	],
	_missionAIUnits,
	_missionObjs,
	[_missionName,_msgWIN,_msgLOSE],
	_markers,
	_side,
	_difficulty,
	[[],[]]
] call DMS_fnc_AddMissionToMonitor_Static;

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_fnc_AddMissionToMonitor_Static! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	_cleanup = [];
	{
		_cleanup pushBack _x;
	} forEach _missionAIUnits;

	_cleanup pushBack ((_missionObjs select 0)+(_missionObjs select 1));
	
	{
		_cleanup pushBack (_x select 0);
	} foreach (_missionObjs select 2);

	_cleanup call DMS_fnc_CleanUp;


	// Delete the markers directly
	{deleteMarker _x;} forEach _markers;


	// Reset the mission count
	DMS_MissionCount = DMS_MissionCount - 1;
};


// Notify players
[_missionName,_msgStart] call DMS_fnc_BroadcastMissionStatus;



if (DMS_DEBUG) then
{
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,_AICount,_difficulty,_time]) call DMS_fnc_DebugLog;
};