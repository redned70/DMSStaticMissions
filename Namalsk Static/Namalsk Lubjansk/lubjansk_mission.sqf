/*
	"Lubjansk" static mission for Namalsk.
	Created by [CiC]red_ned using templates by eraser1 
	17 years of CiC http://cic-gaming.co.uk
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [4456.71,11232.6,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
[4410.3,11292,0.398696],
[4428.31,11232.2,0],
[4407.66,11240.8,0],
[4444.49,11273.9,0],
[4486.99,11288.8,0],
[4491.61,11239.5,0],
[4474.58,11220.8,0],
[4465.58,11213.4,0],
[4473.11,11146,0.103943],
[4457.3,11152,0],
[4455.41,11130.6,0],
[4469.99,11191.6,0],
[4490.31,11264.8,0.702977],
[4490.8,11256.6,0.699592],
[4487.6,11222.1,0.669372],
[4430.79,11214.6,0.329555],
[4426.03,11205.1,0.299984],
[4471.93,11203,0.367413]
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
		_pos vectorAdd [0,-5,0],		// 5 meters South of center pos
		[4423.37,11279.7,0.403339],
		[4430.6,11228.4,0],
		[4465.26,11133.4,-0.0176592],	
		[4483.47,11285.9,0],
		[4485.37,11263.8,0.693156],	
		[4484.22,11221.1,0.697772],	
		[4434.34,11208.1,-0.0666306]
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
	[[4489.99,11285.5,0.0304077],"I_CargoNet_01_ammo_F"],
	[[4486.13,11255.7,0.692561],"I_CargoNet_01_ammo_F"],
	[[4483.57,11211.8,0.962618],"I_CargoNet_01_ammo_F"],
	[[4416.89,11292.2,0.426895],"I_CargoNet_01_ammo_F"],
	[[4425.23,11281.3,0.415057],"I_CargoNet_01_ammo_F"],
	[[4424.27,11290.3,3.72787],"I_CargoNet_01_ammo_F"],
	[[4424.27,11290.3,7.61803],"I_CargoNet_01_ammo_F"]
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
				75,	// Maximum 100 units can be given as reinforcements.
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
	[[_crate0,[25,25,2]],[_crate1,[12,50,10]]]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "Terrorists are raiding Lubjansk harbour"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the terrorists and stolen all the crates"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The terrorists got bored and buggered off taking all the goodies..."];

// Define mission name (for map marker and logging)
_missionName = "Lubjansk Harbour";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficulty
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [200,200];


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