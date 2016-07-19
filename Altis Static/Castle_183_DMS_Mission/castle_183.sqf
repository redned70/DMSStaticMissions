/*
	"Castle 183" static mission for Altis.
	Created by [CiC]red_ned using templates by eraser1 
	17 years of CiC http://cic-gaming.co.uk
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [11190,8708.3,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
[11168.3,8750.48,0],
[11158.9,8748.01,0],
[11157,8736.64,0],
[11196.4,8748.43,0],
[11202.1,8735.68,0],
[11210.2,8730.38,0],
[11172.8,8709.92,0],
[11168.7,8728.12,0],
[11152.1,8695.42,4.27882],
[11155.4,8726.07,0],
[11170.9,8700.52,0],
[11147.4,8697.75,0],
[11159.5,8693.58,0],
[11156.2,8679.49,0],
[11172.9,8669.8,0.228577],
[11207.4,8689.33,0],
[11211.5,8676.58,0],
[11203.5,8718.51,0],
[11219.9,8714.55,0],
[11216.9,8697.29,0],
[11218.9,8636.99,4.95622],
[11237.7,8715.05,0],
[11230.2,8725.61,0],
[11204.9,8627.81,0],
[11206.6,8616.28,0.151505],
[11220.6,8618.61,0],
[11186.6,8755.83,0],
[11206.6,8761.21,23.6423],
[11209.5,8743.1,0],
[11195,8659.26,0],
[11204.7,8654.22,0],
[11248.5,8622.83,0],
[11235.8,8616.76,0],
[11189.7,8772.02,-0.0627747],
[11159.2,8762.37,9.83841],
[11168.3,8766.55,10.83],
[11178.4,8765.97,10.1214],
[11152.4,8748.13,8.4079],
[11149.7,8734.58,7.67348],
[11145.3,8718.93,5.74234],
[11144.4,8707.03,2.83376],
[11163.1,8700.75,0],
[11205.3,8755.98,23.1644],
[11201.1,8763.42,23.9819],
[11182.2,8672.03,11.2117],
[11190,8673.22,10.9217],
[11190.1,8666.1,11.8089],
[11181.2,8675.42,10.9217],
[11223.4,8617.72,4.36861],
[11215.3,8634.56,4.87976]
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
_pos vectorAdd [-1,0,0],		// 1 meter West of center pos
[11241.7,8717.9,0],
[11241.1,8711.61,0],
[11226,8721.05,0],
[11163.5,8751.62,0],
[11174.8,8703.32,0],
[11217.5,8729.27,0],
[11195.5,8760.27,5.46542],
[11154.8,8729.5,0],
[11142.9,8727.56,7.96967],
[11139.2,8723.38,8.40753],
[11140.4,8717.04,7.24477],
[11175.2,8770.28,10.9824],
[11168.6,8769.16,11.515],
[11178.6,8669.11,11.7619],
[11191.8,8675.42,11.7433],
[11221.3,8638.48,5.22684],
[11213.5,8631,5.08504],
[11216.6,8639.21,5.0632]
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
    [[11221.1,8630.63,0],"I_CargoNet_01_ammo_F"],
    [[11214.1,8650.32,0],"I_CargoNet_01_ammo_F"],
    [[11227.8,8727.58,0],"I_CargoNet_01_ammo_F"],
    [[11158.9,8742.59,0],"I_CargoNet_01_ammo_F"],
    [[11153.5,8713.62,0],"I_CargoNet_01_ammo_F"],
    [[11148.4,8718.24,5.7063],"I_CargoNet_01_ammo_F"],
    [[11169.7,8762.52,10.8516],"I_CargoNet_01_ammo_F"],
    [[11186,8671.48,11.2788],"I_CargoNet_01_ammo_F"]
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
			60,		// About a 1 minute delay between reinforcements.
			diag_tickTime
		],
		_AISoldierSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			25,			// Reinforcements will only trigger if there's fewer than 25 members left in the group
			5			// 5 reinforcement units per wave.
		]
	]
];

// Define mission-spawned objects and loot values
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[],
	[[_crate0,[30,125,12]],[_crate1,[30,75,10]]]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "Terrorist Pradatoru is building a new stronghold, go stop him!"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed Pradatoru and his minions"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Pradatoru has gone to get more supplies, he will be back..."];

// Define mission name (for map marker and logging)
_missionName = "Castle 183";

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
			[_pos,150]
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