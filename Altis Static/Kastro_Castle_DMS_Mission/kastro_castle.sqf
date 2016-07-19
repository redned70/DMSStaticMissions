/*
	"Kavala Castle" static mission for Altis.
	Created by [CiC]red_ned using templates by eraser1 
	Credits to Lunchbox for mapping
	17 years of CiC http://cic-gaming.co.uk
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [3064.69,13170,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
[2967.45,13248.8,1.96467],
[2966.91,13242.3,2.30811],
[2962.07,13245.6,3.92431],
[2990.79,13286.2,7.06806],
[2999.94,13278.8,0],
[2992.92,13291.4,9.97234],
[2994.59,13296.8,30.9156],
[3068.88,13218.1,0],
[3086.05,13211.9,0],
[3103.4,13205.3,0],
[3101.65,13192.6,0],
[3088.33,13200.3,7.02203],
[3094.91,13204.2,3.68614],
[3216.93,13181.7,0],
[3198.77,13183.4,10.7426],
[3198.11,13190.7,8.383],
[3203.31,13187.8,22.2176],
[3195.74,13160.9,0],
[3157.58,13128.7,0],
[3149.45,13166.9,0],
[3107.72,13176.6,0],
[3086.36,13182.6,0],
[3071.56,13203.8,0],
[3184.1,13167.4,0.00261688],
[3179.36,13145.9,15.4842],
[3186.66,13146.2,3.88949],
[3185.41,13152.4,3.88949],
[3172.03,13106.5,0],
[3183.86,13093.6,6.87532],
[3122.48,13088.5,0],
[3104,13089.3,0],
[3088.38,13095.1,0],
[3058.6,13104.4,0],
[3006.78,13132.5,0],
[2997.24,13154,0],
[3021.64,13204.3,0],
[3063.43,13256.9,0],
[3094.02,13279.7,10.0292],
[3134.24,13240,23.3271],
[3142.79,13239.9,19.9164],
[3139.27,13247.3,32.1685],
[3133.7,13226.6,0],
[3020.21,13117.7,23.1222],
[3027.01,13114,15.9791],
[3021.48,13110.5,23.4439],
[3086.76,13153.6,0],
[3094.43,13058.2,0],
[3117.62,13054.5,0],
[3145.06,13050.1,0],
[3262.44,13099,0]
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
_pos vectorAdd [-5,0,0],		// 5 meters West of center pos
[3175,13121.1,14.3893],
[3176.8,13143,6.37492],
[3076.92,13228.2,6.1297],
[3120.96,13206.3,0],
[3179.46,13165,0],
[3108.45,13156.5,0],
[3133.36,13097.6,0.0566711],
[3118.96,13102.7,10.7199],
[3164.29,13188.2,0]
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
    [[3049.73,13202.9,18.3091],"I_CargoNet_01_ammo_F"],
    [[2995.75,13238.9,-0.0138435],"I_CargoNet_01_ammo_F"],
    [[2992.14,13289.1,7.87374],"I_CargoNet_01_ammo_F"],
    [[3053.48,13255.4,-0.0370255],"I_CargoNet_01_ammo_F"],
    [[3151.6,13084.6,8.69122],"I_CargoNet_01_ammo_F"],
    [[3177.64,13150.8,3.96083],"I_CargoNet_01_ammo_F"],
    [[3118.58,13210.5,0],"I_CargoNet_01_ammo_F"]
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
_msgStart = ['#FFFF00', "CiC-Admins have invaded the castle gift shop"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the CiC-Admins and stolen all the crates"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"CiC-Admins got bored and buggered off taking all the goodies..."];

// Define mission name (for map marker and logging)
_missionName = "Kavala Castle";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficulty
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
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