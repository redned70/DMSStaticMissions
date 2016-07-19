/*
	"Military Junkyard" static mission for Altis.
	Created by [CiC]red_ned using templates by eraser1 
	Mapping by [CiC]red_ned and Pradatoru
	17 years of CiC http://cic-gaming.co.uk
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [6094.97,12612.9,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	[6027.1,12680.4,0],
	[6042.73,12674.7,0],
	[6054.54,12641.5,0],
	[6042.31,12630.6,0],
	[6063.17,12656.3,0],
	[6076.07,12680.6,0],
	[6110.13,12688.1,0],
	[6103.07,12657,0],
	[6159.39,12691.7,0],
	[6125.28,12635.6,0],
	[6114.9,12603.3,0],
	[6142.7,12587.2,0],
	[6132.2,12577.7,0],
	[6097.11,12570.1,0],
	[6088.07,12563.5,0],
	[6073.22,12560.7,0],
	[6056.5,12557.1,0],
	[6021.49,12554.4,0],
	[6019.59,12573.4,0],
	[6014.77,12604.7,0],
	[6014.22,12627.8,0],
	[5968.84,12648.1,0],
	[5989.81,12676.4,0],
	[5959.71,12633.5,0],
	[5947.17,12590.2,0],
	[5941.26,12553.2,0],
	[5938.12,12513.6,0],
	[5935.2,12504.2,3.70382],
	[5933.15,12497.3,4.33274],
	[5965.67,12482.2,0],
	[5974.28,12502.6,0],
	[5981.75,12517.6,0],
	[5986.03,12526.6,0],
	[6032.64,12528.4,0],
	[6043.96,12546.2,0],
	[5998.73,12571.5,0]
];

// Create AI
_AICount = 25 + (round (random 5));


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
	[6027.27,12695.3,0],
	[6052.7,12695.6,0],
	[6124.95,12679.5,0.0772552],
	[6075.14,12663.2,0],
	[5967.52,12579.6,2.64754],
	[5968.27,12594.7,3.83613],
	[5966.66,12562.8,2.79882],
	[5965.49,12545,2.59589],
	[5944.36,12633.5,12.1842],
	[5967,12640.2,0],
	[5971.04,12684,0],
	[6031.15,12590.3,0],
	[6047.44,12538.3,17.4298],
	[6052.82,12542.4,17.0943],
	[6076.89,12600,0]
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
	[[6014.65,12545.9,0],"I_CargoNet_01_ammo_F"],
	[[5998.48,12580.3,3.78252],"I_CargoNet_01_ammo_F"],
	[[6083.06,12669.1,0],"I_CargoNet_01_ammo_F"],
	[[6085.62,12629.8,0],"I_CargoNet_01_ammo_F"],
	[[6056.47,12536.6,17.5502],"I_CargoNet_01_ammo_F"],
	[[5998.86,12603.7,3.78252],"I_CargoNet_01_ammo_F"],
	[[5997.91,12559.2,3.96569],"I_CargoNet_01_ammo_F"],
	[[5963.36,12664.3,-0.0194626],"I_CargoNet_01_ammo_F"]
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
			90,		// About a 1 1/2 minute delay between reinforcements.
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
	[[_crate0,[50,150,12]],[_crate1,[20,150,10]]]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "A large group of terrorists have invaded the military junkyard"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the terrorists and claimed all the crates"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The terrorists have gone off to find more parts for their vehicles..."];

// Define mission name (for map marker and logging)
_missionName = "Military Junkyard";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficulty
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 20;
_circle setMarkerSize [250,250];


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