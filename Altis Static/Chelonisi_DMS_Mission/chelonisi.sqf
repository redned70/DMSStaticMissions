/*
	"Chelonisi Power" static mission for Altis.
	Created by [CiC]red_ned using templates by eraser1 
	17 years of CiC http://cic-gaming.co.uk
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [16696.7,13598,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
_AISoldierSpawnLocations =
[
[16952.6,13403.9,0],
[16939.6,13394.4,0],
[16825.3,13557.9,0],
[16804.1,13557.9,0],
[16837.6,13622.8,0],
[16838.3,13671.3,0],
[16803.9,13700.3,0],
[16774.7,13709.5,0],
[16679,13707.3,0],
[16667.2,13684.5,0],
[16659.2,13696.7,4.42485],
[16662.4,13689.5,4.42485],
[16743.9,13651,0],
[16772.5,13650.8,0],
[16735.2,13638.5,0],
[16723.4,13625,0],
[16772.6,13595.5,0],
[16776.7,13588.7,2.99077],
[16783.2,13587.1,3.31053],
[16729.7,13595.1,0],
[16747.2,13551.1,0],
[16732.6,13557.2,0],
[16718.8,13533.1,0],
[16694.6,13525.2,0],
[16684.9,13519.3,0],
[16740.3,13467.1,0],
[16742.8,13467.9,0],
[16706.7,13478.9,0],
[16682,13427.9,0],
[16668.1,13403.7,0],
[16645.9,13454.4,0],
[16674.2,13479.9,4.0421],
[16668.3,13476.5,4.48973],
[16583.3,13449.3,0],
[16582.6,13449.3,0],
[16603.5,13529,0],
[16618.5,13524.4,0],
[16589.9,13503,0],
[16575.5,13509.5,0],
[16538.6,13604.3,0],
[16538.9,13610.2,0],
[16583.6,13604.8,0],
[16649.2,13581.5,0],
[16663.7,13565.5,0],
[16669.6,13581.1,0],
[16593.2,13563,0],
[16587.1,13574.6,3.98674],
[16581.7,13569.8,4.189],
[16642.1,13615.4,0],
[16709.7,13549.9,0],
[16713.2,13591.8,0]
];

// Create AI
_AICount = 30 + (round (random 5));


_group =
[
	_AISoldierSpawnLocations,			// only do mapped AI spawns
	_AICount,
	_difficulty,
	"random",
	_side
] call DMS_fnc_SpawnAIGroup_MultiPos;


_staticGuns =
[
	[
		[16829.5,13569.5,0.0359752],	//only do mapped guns
		[16781.6,13583,3.46684],
		[16736.5,13628.1,0],
		[16754,13653,0],
		[16807.6,13677.9,0],
		[16666.4,13691.2,4.01622],
		[16584.1,13578.3,4.02518],
		[16661.9,13578.1,0],
		[16592.5,13488,0],
		[16671.9,13483.7,3.8167],
		[16716.1,13569.1,0],
		[16740.2,13548.7,0],
		[16812,13709.2,9.63884],
		[16688.9,13573.4,9.93271],
		[16652.8,13458.2,0],
		[16637.6,13532,0]
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
	[[16589.2,13493.4,0],"I_CargoNet_01_ammo_F"],
	[[16563.1,13509.6,0],"I_CargoNet_01_ammo_F"],
	[[16659.5,13583.5,0],"I_CargoNet_01_ammo_F"],
	[[16664.6,13410.5,9.54246],"I_CargoNet_01_ammo_F"],
	[[16710,13473,0.386646],"I_CargoNet_01_ammo_F"],
	[[16720.2,13546.7,0],"I_CargoNet_01_ammo_F"],
	[[16809.3,13708.9,9.66289],"I_CargoNet_01_ammo_F"],
	[[16754.4,13612.9,0],"I_CargoNet_01_ammo_F"]
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
			25,			// Reinforcements will only trigger if there's fewer than 10 members left in the group
			5			// 5 reinforcement units per wave.
		]
	]
];

// Define mission-spawned objects and loot values
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[],
	[[_crate0,[50,150,12]],[_crate1,[25,100,10]]]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "Thats an awful lot of power being used on Chelonisi, find out why."];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully cleared Chelonisi of terrorists"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Chelonisi has gone dark, but they will return!"];

// Define mission name (for map marker and logging)
_missionName = "Chelonisi Power";

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