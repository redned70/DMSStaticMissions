/*
	"Kore Factory" v2.0 static mission for Altis.
	Created by [CiC]red_ned using templates by eraser1
	Hardcore mode has Exile_Car_Ural_Covered_Military with 50% its persistent
	Credits to Pradatoru for mapping
	17 years of CiC
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_CoinTossP", "_CoinToss", "_msgWIN", "_vehicle", "_pinCode"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [6175.67,16243.9,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[	
								"easy",
								"moderate",
								"difficult",
								"hardcore"
							];
//choose mission difficulty and set value and is also marker colour
_difficultyM = _PossibleDifficulty call BIS_fnc_selectRandom;

//easy
if (_difficultyM isEqualTo "easy") then {
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
//moderate
if (_difficultyM isEqualTo "moderate") then {
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
//difficult
if (_difficultyM isEqualTo "difficult") then {
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
//hardcore								
if (_difficultyM isEqualTo "hardcore") then {
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


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
[6317.96,16220.2,0],
[6074.86,16263,0],
[6100.03,16208.9,0],
[6204.37,16222.3,0.878017],
[6062.78,16194.5,15.2872],
[6245.5,16272.7,0.0406151],
[6183.64,16272.5,0],
[6155.11,16228.1,0],
[6212.57,16210,0],
[6156.73,16292.9,0],
[6144.64,16254.9,0],
[6060.77,16222,0],
[6273.74,16219.4,0],
[6214.52,16255.3,0],
[6121.09,16239.8,0],
[6205.06,16235.7,0]
];

_group =
[
	_AISoldierSpawnLocations+[_pos,_pos,_pos],			// Pass the regular spawn locations as well as the center pos 3x
	_AICount,											// Set in difficulty select
	_difficulty,										// Set in difficulty select
	"random",
	_side
] call DMS_fnc_SpawnAIGroup_MultiPos;

//Reduce Static guns if mission is easy
if (_difficultyM isEqualTo "easy") then {
_staticGuns =
[
	[
		[6272.85,16301.2,15.8243],
		[6129.94,16272.1,1.3512],
		[6242.14,16211.7,0.632]
	],
	_group,
	"assault",
	_difficulty,
	"bandit",
	"random"
] call DMS_fnc_SpawnAIStaticMG;
										} else
										{
_staticGuns =
[
	[
		_pos vectorAdd [-5,0,0],	// 5 meters West of center pos
		_pos vectorAdd [0,-5,0],	// 5 meters South of center pos
		[6272.85,16301.2,15.8243],
		[6129.94,16272.1,1.3512],
		[6242.14,16211.7,0.632]
	],
	_group,
	"assault",
	_difficulty,
	"bandit",
	"random"
] call DMS_fnc_SpawnAIStaticMG;
										};


// Define the classnames and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions =
[
	[[6158.78,16211.3,0.281509],"I_CargoNet_01_ammo_F"],
	[[6145.2,16262.8,0],"I_CargoNet_01_ammo_F"],
	[[6055.41,16237.9,0],"I_CargoNet_01_ammo_F"],
	[[6297.12,16218.4,0],"I_CargoNet_01_ammo_F"],
	[[6112.29,16229.5,0],"I_CargoNet_01_ammo_F"]
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

// If mission is Hardcore then do coin toss calculation for vehicle and message for pin code
// If not hardcore then set objects without vehicle or win message with pin code
if (_difficultyM isEqualTo "hardcore") then {
												_CoinTossP = ["Heads", "Tails"];
												_CoinToss = _CoinTossP call BIS_fnc_selectRandom;
		if (_CoinToss isEqualTo "Heads") then {
											_pinCode = (1000 +(round (random 8999)));
											_vehicle = ["Exile_Car_Ural_Covered_Military",[6188.366699, 16272.720703, 0.00143814],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Convicts have successfully killed everyone and stolen all the crates, Ural entry code is %1...",_pinCode]];
											} else
											{
											_vehicle = ["Exile_Car_Ural_Covered_Military",[6188.366699, 16272.720703, 0.00143814]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Convicts have successfully killed everyone and stolen all the crates"];
											};
// Define mission-spawned objects and loot values with vehicle
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[_vehicle],				// vehicle prize
	[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
];	
											} else
											{
// Define mission-spawned objects and loot values without vehicle
_missionObjs =
[
	_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
	[],
	[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
];											
											_msgWIN = ['#0080ff',"Convicts have successfully killed everyone and stolen all the crates"];											
											};
											
// Define Mission Start message
_msgStart = ['#FFFF00', "Terrorists are raiding a factory"];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Terrorists got bored and buggered off taking all the goodies..."];

// Define mission name (for map marker and logging)
_missionName = "Kore Factory";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficultyM
] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [275,100];


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
	_difficultyM,
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