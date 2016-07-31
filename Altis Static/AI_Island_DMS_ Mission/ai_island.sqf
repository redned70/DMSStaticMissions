/*
	"Ai Island" v2.1 static mission for Altis.
	Created by [CiC]red_ned using templates by eraser1 
	Credits to "Kroenen" for creating the base.
	17 years of CiC http://cic-gaming.co.uk
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [8476.27,25123.1,4.0095582];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[	
								"easy",
								"moderate",
								"moderate",
								"difficult",
								"difficult",
								"difficult",
								"hardcore",
								"hardcore",
								"hardcore",
								"hardcore"
							];
//choose mission difficulty and set value and is also marker colour
_difficultyM = selectRandom _PossibleDifficulty;

switch (_difficultyM) do
{
	case "easy":
	{
_difficulty = "easy";									//AI difficulty
_AICount = (15 + (round (random 5)));					//AI starting numbers
_AIMaxReinforcements = (10 + (round (random 30)));		//AI reinforcement cap
_AItrigger = (10 + (round (random 5)));					//If AI numbers fall below this number then reinforce if any left from AIMax
_AIwave = (4 + (round (random 4)));						//Max amount of AI in reinforcement wave
_AIdelay = (55 + (round (random 120)));					//The delay between reinforcements
_crate_weapons0 	= (5 + (round (random 20)));		//Crate 0 weapons number
_crate_items0 		= (5 + (round (random 20)));		//Crate 0 items number
_crate_backpacks0 	= (3 + (round (random 1)));			//Crate 0 back packs number
_crate_weapons1 	= (4 + (round (random 2)));			//Crate 1 weapons number
_crate_items1 		= (10 + (round (random 40)));		//Crate 1 items number
_crate_backpacks1 	= (1 + (round (random 8)));			//Crate 1 back packs number
	};
	case "moderate":
	{
_difficulty = "moderate";
_AICount = (20 + (round (random 5))); 
_AIMaxReinforcements = (20 + (round (random 20)));
_AItrigger = (10 + (round (random 10)));
_AIwave = (5 + (round (random 3)));
_AIdelay = (55 + (round (random 120)));
_crate_weapons0 	= (10 + (round (random 15)));
_crate_items0 		= (10 + (round (random 15)));
_crate_backpacks0 	= (3 + (round (random 1)));
_crate_weapons1 	= (6 + (round (random 3)));
_crate_items1 		= (20 + (round (random 30)));
_crate_backpacks1 	= (5 + (round (random 4)));
	};
	case "difficult":
	{
_difficulty = "difficult";
_AICount = (20 + (round (random 7)));
_AIMaxReinforcements = (30 + (round (random 20)));
_AItrigger = (10 + (round (random 10)));
_AIwave = (6 + (round (random 2)));
_AIdelay = (55 + (round (random 120)));
_crate_weapons0 	= (30 + (round (random 20)));
_crate_items0 		= (15 + (round (random 10)));
_crate_backpacks0 	= (3 + (round (random 1)));
_crate_weapons1 	= (8 + (round (random 3)));
_crate_items1 		= (30 + (round (random 20)));
_crate_backpacks1 	= (6 + (round (random 4))); 
	};
	//case "hardcore":
	default
	{
_difficulty = "hardcore"; 
_AICount = (20 + (round (random 10)));
_AIMaxReinforcements = (40 + (round (random 10)));
_AItrigger = (15 + (round (random 5)));
_AIwave = (6 + (round (random 2)));
_AIdelay = (55 + (round (random 120)));
_crate_weapons0 	= (20 + (round (random 5)));
_crate_items0 		= (20 + (round (random 5)));
_crate_backpacks0 	= (2 + (round (random 1)));
_crate_weapons1 	= (10 + (round (random 2)));
_crate_items1 		= (40 + (round (random 10)));
_crate_backpacks1 	= (10 + (round (random 2)));
	};
};

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

_group =
[
	_AISoldierSpawnLocations+[_pos,_pos,_pos],			// Pass the regular spawn locations as well as the center pos 3x
	_AICount,											// Set in difficulty select
	_difficulty,										// Set in difficulty select
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

// Enable smoke on the crates due to size of area
{
	_x setVariable ["DMS_AllowSmoke", true];
} forEach [_crate0,_crate1];

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
				_AIMaxReinforcements,	// Maximum units that can be given as reinforcements (defined in difficulty selection).
				0
			]
		],
		[
			_AIdelay,		// The delay between reinforcements. >> you can change this in difficulty settings
			diag_tickTime
		],
		_AISoldierSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			_AItrigger,		// Set in difficulty select - Reinforcements will only trigger if there's fewer than X members left
			_AIwave			// X reinforcement units per wave. >> you can change this in mission difficulty section
		]
	]
];

// setup crates with items from choices
_crate_loot_values0 =
[
	_crate_weapons0,		// Set in difficulty select - Weapons
	_crate_items0,			// Set in difficulty select - Items
	_crate_backpacks0 		// Set in difficulty select - Backpacks
];
_crate_loot_values1 =
[
	_crate_weapons1,		// Set in difficulty select - Weapons
	_crate_items1,			// Set in difficulty select - Items
	_crate_backpacks1 		// Set in difficulty select - Backpacks
];

// Define mission-spawned objects and loot values with vehicle
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[],						// no vehicle prize
	[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
];

// Define Mission Start message
_msgStart = ['#FFFF00',format["A large group of %1 Admins have invaded the island and are drinking beer and eating cake",_difficultyM]];

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
	_difficultyM
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