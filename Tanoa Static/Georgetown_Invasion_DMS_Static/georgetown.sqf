/*
	"Georgetown Invasion" v2.1 static mission for Tanoa.
	Created by [CiC]red_ned using templates by eraser1
	Exile_Chopper_Huey_Desert increases persistent chance with difficulty
	Reinforcements of AI vehicle patrols, 2 different groups of AI so one is dedicated sniper
	This version includes AI heli
	Diffficulty of mission not linked to difficulty of AI if you want.
	17 years of CiC
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/

private ["_AICount", "_AICountSnipers", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_cash0", "_cash1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance", "_baseObjs", "_AISniperSpawnLocations", "_AIPatrolSpawnLocations", "_group2", "_veh", "_Vwin", "_dropPoint", "_heliClass", "_spawnPos"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [5765.37,10368.9,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[	
								//"easy",
								//"moderate",
								"moderate",
								//"difficult",
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
		_AICountSnipers = (2 + (round (random 4)));				//Max 20
		_AIMaxReinforcements = (20 + (round (random 30)));		//AI reinforcement cap
		_AItrigger = (10 + (round (random 5)));					//If AI numbers fall below this number then reinforce if any left from AIMax
		_AIwave = (4 + (round (random 2)));						//Max amount of AI in reinforcement wave
		_AIdelay = (55 + (round (random 120)));					//The delay between reinforcements
		_VehicleChance = 25;									//25% SpawnPersistentVehicle chance
		_crate_weapons0 	= (20 + (round (random 25)));		//Crate 0 weapons number
		_crate_items0 		= (5 + (round (random 20)));		//Crate 0 items number
		_crate_backpacks0 	= (3 + (round (random 1)));			//Crate 0 back packs number
		_crate_weapons1 	= (25+ (round (random 20)));		//Crate 1 weapons number
		_crate_items1 		= (10 + (round (random 40)));		//Crate 1 items number
		_crate_backpacks1 	= (1 + (round (random 8)));			//Crate 1 back packs number
		_cash0 = (1000 + round (random (1500)));				//Tabs for crate0
		_cash1 = (1000 + round (random (5000)));				//Tabs for crate1
	};
	case "moderate":
	{
		_difficulty = "moderate";
		_AICount = (15 + (round (random 5)));
		_AICountSnipers = (4 + (round (random 4)));				//Max 20
		_AIMaxReinforcements = (30 + (round (random 30)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (5 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_VehicleChance = 50;									//50% SpawnPersistentVehicle chance
		_crate_weapons0 	= (30 + (round (random 25)));
		_crate_items0 		= (10 + (round (random 15)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_crate_weapons1 	= (25 + (round (random 30)));
		_crate_items1 		= (20 + (round (random 30)));
		_crate_backpacks1 	= (5 + (round (random 5)));
		_cash0 = (1000 + round (random (1500)));				//Tabs for crate0
		_cash1 = (1000 + round (random (5000)));				//Tabs for crate1
	};
	case "difficult":
	{
		_difficulty = "difficult";
		_AICount = (15 + (round (random 7)));
		_AICountSnipers = (6 + (round (random 6)));				//Max 20
		_AIMaxReinforcements = (40 + (round (random 40)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (6 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_VehicleChance = 75;									//75% SpawnPersistentVehicle chance
		_crate_weapons0 	= (40 + (round (random 25)));
		_crate_items0 		= (15 + (round (random 10)));
		_crate_backpacks0 	= (3 + (round (random 3)));
		_crate_weapons1 	= (25 + (round (random 40)));
		_crate_items1 		= (30 + (round (random 20)));
		_crate_backpacks1 	= (6 + (round (random 6)));
		_cash0 = (1000 + round (random (1500)));				//Tabs for crate0
		_cash1 = (1000 + round (random (5000)));				//Tabs for crate1
	};
	//case "hardcore":
	default
	{
		_difficulty = "hardcore";
		_AICount = (15 + (round (random 10)));
		_AICountSnipers = (10 + (round (random 10)));			//Max 20
		_AIMaxReinforcements = (50 + (round (random 50)));
		_AItrigger = (15 + (round (random 10)));
		_AIwave = (6 + (round (random 4)));
		_AIdelay = (55 + (round (random 120)));
		_VehicleChance = 90;									//90% SpawnPersistentVehicle chance
		_crate_weapons0 	= (50 + (round (random 25)));
		_crate_items0 		= (20 + (round (random 25)));
		_crate_backpacks0 	= (2 + (round (random 5)));
		_crate_weapons1 	= (25 + (round (random 50)));
		_crate_items1 		= (40 + (round (random 25)));
		_crate_backpacks1 	= (10 + (round (random 2)));
		_cash0 = (1000 + round (random (1500)));				//Tabs for crate0
		_cash1 = (1000 + round (random (5000)));				//Tabs for crate1
	};
};

//define heli start, drop and class
_spawnPos	=	[5500,10000,350];
_dropPoint	=	[5765.37,10369,350];
_heliClass	=	["Exile_Chopper_Huey_Armed_Green"];

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =	[
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
// Rooftop snipers as 2nd group (20 max) - no reinforcements of these.
_AISniperSpawnLocations = 	[
								[5741.25,10396.4,8.33376],
								[5701.03,10423.4,6.84472],
								[5790.64,10473,11.6051],
								[5824.09,10515.8,10.7217],
								[5775.01,10552.9,10.7422],
								[5762.65,10668.1,9.01839],
								[5837.25,10835.2,7.21549],
								[5764.46,10227.4,10.9102],
								[5532.89,10011.9,11.0499],
								[5734.16,10144.5,8.6512],
								[5737.27,10332.6,6.52303],
								[5744.84,10238.2,12.026],
								[5724.98,10212.2,8.45481],
								[5788.08,10274.6,8.08307],
								[5832.26,10327.4,11.1234],
								[5763.99,10637.7,11.5969],
								[5707.85,10506.4,6.96054],
								[5760.84,10489.4,11.0633],
								[5830.4,10476.5,10.7212],
								[5759.04,10320.2,7.95645]
							];
// Shuffle the list of possible sniper spawn locations
_AISniperSpawnLocations = _AISniperSpawnLocations call ExileClient_util_array_shuffle;	

// Vehicle patrol locations							
_AIPatrolSpawnLocations = 	[
								[5503.89,10042.7,0],
								[5811.15,10488.8,0],
								[5785.14,10610.8,0],
								[5778.55,10756.6,0],
								[5892.39,10749.2,0],
								[5911.17,10622.2,0],
								[5769.6,10602.6,0],
								[5698.83,10372.1,0],
								[5648.25,10179.4,0],
								[5715.98,10107,0],
								[5621.89,10082.9,0]							
							];
// Shuffle the list of possible patrol spawn locations
_AIPatrolSpawnLocations = _AIPatrolSpawnLocations call ExileClient_util_array_shuffle;							

_group =	[
				_AISoldierSpawnLocations+[_pos,_pos,_pos],			// Pass the regular spawn locations as well as the center pos 3x
				_AICount		,									// Set in difficulty select
				_difficulty,										// Set in difficulty select
				"random",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;

_group2 =	[
				_AISniperSpawnLocations,							// Snipers on rooftops
				_AICountSnipers,									// Set in difficulty select
				_difficulty,										// Set in difficulty select
				"sniper",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;
			
_group3	=	[														// Helicopter support group
				_spawnPos,
				1,													// 1 only and no reinforcements
				_difficulty,
				"random",
				"bandit"
			] call DMS_fnc_SpawnAIGroup;			
			[
				_group3,
				"random",
				_difficulty,
				_side,
				[_dropPoint],
				"true",
				6,
				"true",
				_heliClass,
				[_spawnPos]
			] call DMS_fnc_SpawnHeliReinforcement;

_staticGuns =	[
					[
						_pos vectorAdd [0,0,0],			// Center pos
						_pos vectorAdd [0,-2,0],		// 2 meters South of center pos
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

// add vehicle patrol
_veh =	[
			[
				[5503.89,10042.7,0]
			],
			_group,
			"assault",
			_difficulty,
			_side
		] call DMS_fnc_SpawnAIVehicle;

// Create Buildings - this is so roadblocks only appear during mission
_baseObjs =	[
				"georgetown_buildings"
			] call DMS_fnc_ImportFromM3E_Static;
			
// Define the classnames and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions =	[
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
_missionAIUnits =	[
						_group, 		// Main AI
						_group2			// Snipers
						//_group3		//heli - if not included in the mission triggers and it wanders off it mission should still complete
					];

// Define the group reinforcements - dont include sniper _group2
_groupReinforcementsInfo =	
[
	[
		_group,			// pass the group
		[
			[
				5,		// Only 5 "waves" (5 vehicles can spawn as reinforcement over time)
				0
			],
			[
				-1,		// No need to limit the number of units since we're limiting "waves"
				0
			]
		],
		[
			_AIdelay,		// The delay between reinforcements. >> you can change this in difficulty settings
			diag_tickTime
		],
		[_AIPatrolSpawnLocations],	// Randomly chosen places for vehicle patrol respawn from 10 defined
		"random",
		_difficulty,
		_side,
		"armed_vehicle",
		[
			_AItrigger,		// Set in difficulty select - Reinforcements will only trigger if there's fewer than X members left
			"random"		// Select a random armed vehicle from "DMS_ArmedVehicles"
		]
	],
	[
		_group,			// pass the group again for foot troops
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
		[_AISoldierSpawnLocations],
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
_crate_loot_values0 =	[
							_crate_weapons0,		// Set in difficulty select - Weapons
							_crate_items0,			// Set in difficulty select - Items
							_crate_backpacks0 		// Set in difficulty select - Backpacks
						];
_crate_loot_values1 =	[
							_crate_weapons1,		// Set in difficulty select - Weapons
							_crate_items1,			// Set in difficulty select - Items
							_crate_backpacks1 		// Set in difficulty select - Backpacks
						];

// add cash to crates
_crate0 setVariable ["ExileMoney", _cash0,true];
_crate1 setVariable ["ExileMoney", _cash1,true];

// is %chance greater than random number
if (_VehicleChance >= (random 100)) then {
											_pinCode = (1000 +(round (random 8999)));
											_vehicle = ["Exile_Chopper_Huey_Desert",[5818.5,10357.4,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Convicts have successfully cleared Georgetown and stolen all the crates, Huey entry code is %1...",_pinCode]];
											_Vwin = "Win";	//just for logging purposes
											} else
											{
											_vehicle = ["Exile_Chopper_Huey_Desert",[5818.5,10357.4,0]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Convicts have successfully cleared Georgetown and stolen all the crates"];
											_Vwin = "Lose";	//just for logging purposes
											};

//export to logs for testing - comment next line out for no log
diag_log format ["Georgetown :: Called MISSION with these parameters: >>AI Group: %1  >>Cash0: %2 >>Cash1: %3 >>Vwin: %4 >>Difficulty: %5 >>Snipers: %6",_AICount,_cash0,_cash1,_Vwin,_difficultyM,_AICountSnipers];

// Define mission-spawned objects and loot values with vehicle
_missionObjs =	[
					_staticGuns+_baseObjs+[_veh],										// static gun(s). Road blocks. Patrol vehicles
					[_vehicle],															// vehicle prize
					[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]		// crates
				];	

// Define Mission Start message
_msgStart = ['#FFFF00',format["Georgetown is being invaded by %1 terrorists",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Invaders have stripped Georgetown of loot and left."];

// Define mission name (for map marker and logging)
_missionName = "Georgetown Invasion";

// Create Markers
_markers =	[
				_pos,
				_missionName,
				_difficultyM
			] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [250,250];

_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =	[
				_pos,
				[
					[
						"kill",
						[_group,_group2,_group3]
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