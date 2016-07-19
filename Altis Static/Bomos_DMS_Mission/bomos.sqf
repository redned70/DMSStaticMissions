/*
	"Bomos" static mission for Altis.
	Created by [CiC]red_ned using templates by eraser1 
	17 years of CiC http://cic-gaming.co.uk
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [2414.53,22288.7,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
[2086.76,22181.3,0],
[2230.49,22162.8,0],
[2248.99,22170.2,0],
[2234.91,22178.2,0],
[2241,22159.2,18.0424],
[2282.4,22180.1,0],
[2309.33,22374.1,0],
[2318.27,22380.8,0],
[2320.53,22389.6,0],
[2305.52,22389.1,31.2191],
[2371.86,22429,0],
[2367.3,22423.4,0],
[2361.02,22428.1,0],
[2492.92,22416.8,0],
[2489.23,22423.3,25.048],
[2479.47,22426.5,0],
[2470.83,22279.4,0],
[2584.03,22116.1,0],
[2614.44,22251.1,0],
[2649.7,22130.3,0],
[2404.84,22291.4,0],
[2359,22332.6,0],
[2278.91,22263.6,0],
[2461.15,22131.6,0],
[2552.37,22133.2,0],
[2554.97,22163.6,0],
[2677.63,22113.2,0],
[2659.76,22084.7,0],
[2673.19,22103.8,0],
[2646.21,22138.8,0],
[2641.31,22160.6,0],
[2634.2,22274.1,0],
[2630.65,22368.9,0],
[2483.65,22421.7,0],
[2324.94,22407.3,0],
[2100.3,22183.2,0],
[2133.11,22172,0],
[2294.21,22174.2,0],
[2294.75,22182,0],
[2442.29,22257.6,0],
[2489.25,22223.5,0]
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
		//_pos vectorAdd [-5,0,0],		// 5 meters West of center pos
		_pos vectorAdd [0,-5,0],		// 5 meters South of center pos
		[2505.22,22432.2,0],
		[2006.28,22156.8,4.87243],
		[2247.48,22157.4,0],
		[2299.72,22182.1,0]
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
	[[2305.08,22389.6,0.083992],"I_CargoNet_01_ammo_F"],
	[[2364.02,22426.5,0.141647],"I_CargoNet_01_ammo_F"],
	[[2489.12,22425.9,-0.0554581],"I_CargoNet_01_ammo_F"],
	[[2238.04,22159.5,0.0163651],"I_CargoNet_01_ammo_F"],
	[[2079.59,22185.9,0.262085],"I_CargoNet_01_ammo_F"]
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
			120,		// About a 2 minute delay between reinforcements.
			diag_tickTime
		],
		_AISoldierSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			20,			// Reinforcements will only trigger if there's fewer than 10 members left in the group
			5			// 5 reinforcement units per wave.
		]
	]
];

// Define mission-spawned objects and loot values
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[],
	[[_crate0,[50,50,2]],[_crate1,[3,150,10]]]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "A large group of Admins have invaded Bomos"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the Admins and claimed all the crates"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The Admins have buggered off..."];

// Define mission name (for map marker and logging)
_missionName = "Bomos Invasion";

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