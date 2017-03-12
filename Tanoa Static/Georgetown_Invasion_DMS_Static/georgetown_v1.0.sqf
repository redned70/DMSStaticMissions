/*
	"Georgetown Invasion" v1.0 - Hardcore static mission for Tanoa.
	This version excludes AI heli and patrol vehicles.
	Set difficulty and lower logic levels.
	Created by [CiC]red_ned using templates by eraser1 
	17 years of CiC http://cic-gaming.co.uk
*/

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [5765.37,10368.9,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

// Set general mission difficulty
_difficulty = "hardcore";

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	[5739.91,10301.2,0],
	[5720.12,10242.9,0],
	[5693.45,10177.8,0],
	[5731.93,10162.6,0],
	[5705.9,10118.9,0],
	[5717.31,10077.4,0],
	[5565.75,9897.22,0],
	[5556.96,9911.44,0],
	[5529.53,9922.53,0],
	[5503.74,10030.3,0],
	[5578.77,10048.2,0],
	[5625.2,10063.9,0],
	[5651.92,10109.3,0],
	[5666.7,10171.2,0],
	[5664.16,10258.3,0],
	[5713.34,10401.4,0],
	[5818.65,10373.4,0],
	[5818.57,10445.9,0],
	[5791.23,10569.9,0],
	[5796.77,10614.2,0],
	[5782.76,10700.8,0],
	[5800.82,10796.3,0],
	[5859.48,10827,0],
	[5870.57,11007.3,0],
	[5867.14,11010.9,0],
	[5852.48,10750.7,0],
	[5920.26,10600.3,0],
	[5980.07,10574.8,0],
	[5984.41,10583.4,0],
	[5765.45,10480.6,0],
	[5774.28,10351.5,0],
	[5766.5,10380.1,0],
	[5730.95,9991.98,0],
	[5781.21,10188.3,0],
	[5755.8,10215.8,0]
];

// Create AI
_AICount = 20 + (round (random 5));

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
		_pos vectorAdd [-5,0,0],		// 5 meters West of center pos
		_pos vectorAdd [0,-5,0],		// 5 meters South of center pos
		[5841.33,10837.6,7.02381],
		[5852.05,10834.8,0],
		[5996.15,10567.3,0],
		[5976.56,10596.7,3.05931],
		[5987.16,10588.6,0.25619],
		[5513.95,9915.8,0],
		[5539.56,9919.56,0.0459909],
		[5564.54,9903.37,0],
		[5730.09,10002.3,3.52505],
		[5715.29,10032,3.29457],
		[5751.59,10385.6,0],
		[5748.03,10360.1,3.34197],
		[5488.29,10046.1,0],
		[5799.66,10560.4,3.19466],
		[5702.8,10400.8,0],
		[5768.91,10186.1,0]
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
	[[5777.83,10349.7,0],"I_CargoNet_01_ammo_F"],
	[[5754.64,10393.5,0.0875998],"I_CargoNet_01_ammo_F"],
	[[5727.57,10366,0.258264],"I_CargoNet_01_ammo_F"],
	[[5767.56,10384,0.821316],"I_CargoNet_01_ammo_F"],
	[[5751.11,10363.5,0.0801148],"I_CargoNet_01_ammo_F"]
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
				50,	// Maximum 100 units can be given as reinforcements.
				0
			]
		],
		[
			180,		// About a 3 minutes delay between reinforcements.
			diag_tickTime
		],
		_AISoldierSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			20,			// Reinforcements will only trigger if there's fewer than 10 members left in the group
			5			// 7 reinforcement units per wave.
		]
	]
];

// Define mission-spawned objects and loot values
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[],
	[[_crate0,[100,50,5]],[_crate1,[50,100,10]]]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "Georgetown is being invaded"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully cleared Georgetown and stolen all the crates"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Invaders have stripped Georgetown of loot and left."];

// Define mission name (for map marker and logging)
_missionName = "Georgetown Invasion";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficulty
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [150,150];

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