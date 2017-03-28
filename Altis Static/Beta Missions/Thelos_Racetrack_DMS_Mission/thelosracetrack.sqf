/*
	"Thelos Racetrack" v2.1 static mission for Altis.
	Created by [CiC]red_ned using templates by eraser1
	Choice of prize vehicle increases persistent chance with difficulty
	Reinforcements of AI random vehicle patrols and AI foot troops
	Diffficulty of mission not linked to difficulty of AI if you want.
	18 years of CiC - easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_cash0", "_cash1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance", "_baseObjs", "_AIPatrolSpawnLocations", "_group3", "_veh", "_vehClass", "_vehClassP", "_Vwin", "_dropPoint", "_heliClass", "_heliClassP", "_spawnPos", "_veh_wave", "_PossibleVehicleClass", "_VehicleClass"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [22147.1,14467.4,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[	
								"easy",
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
		_AIMaxReinforcements = (20 + (round (random 30)));		//AI reinforcement cap
		_AItrigger = (10 + (round (random 5)));					//If AI numbers fall below this number then reinforce if any left from AIMax
		_AIwave = (4 + (round (random 2)));						//Max amount of AI in reinforcement wave
		_AIdelay = (55 + (round (random 120)));					//The delay between reinforcements
		_veh_wave = (1 + (round (random 1)));					//Amount of possible vehicle reinforcement waves 
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
		_AIMaxReinforcements = (30 + (round (random 30)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (5 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_veh_wave = (1 + (round (random 2)));					//Amount of possible vehicle reinforcement waves 
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
		_AIMaxReinforcements = (40 + (round (random 40)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (6 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_veh_wave = (2 + (round (random 2)));					//Amount of possible vehicle reinforcement waves 
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
		_AIMaxReinforcements = (50 + (round (random 50)));
		_AItrigger = (15 + (round (random 10)));
		_AIwave = (6 + (round (random 4)));
		_AIdelay = (55 + (round (random 120)));
		_veh_wave = (3 + (round (random 2)));					//Amount of possible vehicle reinforcement waves 
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

//define heli start, drop and possible classes
_spawnPos	=	[(22147 + (round (random 500))),(14467 + (round (random 500))),350];		//randomised a little
_dropPoint	=	[(22147 + (round (random 25))),(14467 + (round (random 25))),350];			//randomised a little
_heliClassP	=	[
					"Exile_Chopper_Huey_Armed_Green",
					"Exile_Chopper_Huey_Armed_Desert",
					"Exile_Chopper_Huey_Desert",
					"Exile_Chopper_Huey_Green"
				];									//you can add helis from other mods, just remember comma every line except last
//choose helicoptor class from list
_heliClass = selectRandom _heliClassP;

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =	[
								[22109.5,14458.2,0],
								[22114.1,14427.5,0],
								[22117.2,14393.5,0],
								[22170.5,14387.8,0],
								[22188,14411.1,0],
								[22183.4,14468.4,0],
								[22176.4,14524.8,0],
								[22168.1,14550.7,0],
								[22120.3,14548.9,0],
								[22137.8,14497.1,0],
								[22137.7,14477.2,0],
								[22137.1,14442.4,0],
								[22146.5,14409.8,0],
								[22195.2,14397,0],
								[22198.6,14378,0],
								[22209.6,14433.5,0],
								[22196.1,14536.5,0],
								[22186.5,14565.5,0],
								[22193.1,14562.6,0],
								[22224.2,14568.3,0],
								[22184.5,14548.9,0],
								[22167.1,14566.8,0],
								[22094,14559,0],
								[22086.7,14548.9,0],
								[22084.7,14535.3,0],
								[22086,14511.4,0],
								[22087,14497.7,0],
								[22089.9,14460.1,0],
								[22085.5,14442.1,0],
								[22089.8,14416.5,0],
								[22090,14379.4,0],
								[22101.7,14363.4,0],
								[22165.5,14445.9,0],
								[22165.5,14470.9,0],
								[22165.5,14499,0],
								[22167,14425.1,0],
								[22161.8,14400.5,0]
							];					
// Shuffle the list of possible AI spawn locations
_AISoldierSpawnLocations = _AISoldierSpawnLocations call ExileClient_util_array_shuffle;

// Vehicle patrol locations							
_AIPatrolSpawnLocations = 	[
								[22257.6,14522.7,0],
								[22257.5,14522.8,0],
								[22283.8,14374.5,0],
								[22228.9,14376.9,0],
								[22168.5,14356.2,0.217107],
								[22071.4,14376.6,0.217107],
								[22143.7,14607.4,0.217108],
								[22249.2,14657.9,0.217108]						
							];
// Shuffle the list of possible patrol spawn locations
_AIPatrolSpawnLocations = _AIPatrolSpawnLocations call ExileClient_util_array_shuffle;			//shufffle for reinforcements				

// Possible AI patrol vehicle classes and chose random
_vehClassP = 	[
					"random",								//this is the DMS select from DMS_ArmedVehicles comment out if you only want your vehicle types selected from list.
					"Exile_Car_Offroad_Armed_Guerilla01",
					"Exile_Car_Offroad_Armed_Guerilla02",
					"Exile_Car_Offroad_Armed_Guerilla03",
					"Exile_Car_Offroad_Armed_Guerilla04",
					"Exile_Car_Offroad_Armed_Guerilla05",
					"Exile_Car_Offroad_Armed_Guerilla06",
					"Exile_Car_Offroad_Armed_Guerilla07",
					"Exile_Car_Offroad_Armed_Guerilla08",
					"Exile_Car_Offroad_Armed_Guerilla09",
					"Exile_Car_Offroad_Armed_Guerilla10",
					"Exile_Car_Offroad_Armed_Guerilla11",
					"Exile_Car_Offroad_Armed_Guerilla12"
				];											//you can add vehicles from other mods, just remember comma every line except last
//now chose a patrol vehicle
_vehClass = selectRandom _vehClassP;

_group =	[
				_AISoldierSpawnLocations+[_pos,_pos],			// Pass the regular spawn locations as well as the center pos 2x
				_AICount		,									// Set in difficulty select
				_difficulty,										// Set in difficulty select
				"random",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;
			
_group3	=	[														// Helicopter support group
				_spawnPos,
				1,				
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
						//_pos vectorAdd [0,0,0],			// Center pos
						//_pos vectorAdd [0,-2,0],			// 2 meters South of center pos
						[22189.2,14390.5,0],
						[22116.5,14381.7,0],
						[22103.8,14541.4,0],
						[22163,14564,0],
						[22158.5,14541.5,0],
						[22150.1,14509.5,0],
						[22157.8,14410.6,0],
						[22141.8,14446.4,0],
						[22153.5,14482.2,0],
						[22098.8,14487.1,0],
						[22154.9,14431.7,0],
						[22152.3,14454.5,0]
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
				[_AIPatrolSpawnLocations]						// list of locations defined above
			],
			_group,
			"assault",
			_difficulty,
			_side,
			_vehClass											//optional line for chosing the vehicle class, defined above
		] call DMS_fnc_SpawnAIVehicle;
			
// Define the classnames and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions =	[
									[[22152.8,14470.7,0.515044],"I_CargoNet_01_ammo_F"],
									[[22151.1,14496.5,0.535644],"I_CargoNet_01_ammo_F"],
									[[22152.2,14444.5,0.552725],"I_CargoNet_01_ammo_F"],
									[[22152.9,14419.9,0.721792],"I_CargoNet_01_ammo_F"],
									[[22157.6,14416.1,0.017786],"I_CargoNet_01_ammo_F"],
									[[22156,14517.7,0.38419000],"I_CargoNet_01_ammo_F"],
									[[22133.6,14458.4,0.057161],"I_CargoNet_01_ammo_F"],
									[[22132.5,14475.4,0.000000],"I_CargoNet_01_ammo_F"],
									[[22133.2,14492.4,0.020000],"I_CargoNet_01_ammo_F"],
									[[22132.3,14439.5,0.000000],"I_CargoNet_01_ammo_F"]
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
						_group 		// Main AI
					];

//chose a different patrol vehicle for reinforcements
_vehClass = selectRandom _vehClassP;

// Define the group reinforcements
_groupReinforcementsInfo =	
[
	[
		_group,			// pass the group
		[
			[
				_veh_wave,		// Set in difficulty select -"waves" ( vehicles can spawn as reinforcement over time)
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
		[_AIPatrolSpawnLocations],	// Randomly chosen places for vehicle patrol respawn
		"random",
		_difficulty,
		_side,
		"armed_vehicle",
		[
			_AItrigger,		// Set in difficulty select - Reinforcements will only trigger if there's fewer than X members left
			_vehClass		// Select a random armed vehicle from list above
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

//create possible prize vehicle list (you can add any heli or land vehicle if you want but it spawns on heli pad)
_PossibleVehicleClass 		= [	
								"Exile_Chopper_Huey_Armed_Green",
								"Exile_Chopper_Huey_Armed_Desert",
								"Exile_Chopper_Huey_Desert",
								"Exile_Chopper_Huey_Green",
								"Exile_Chopper_Huey_Armed_Green",					// adding twice to double the chance
								"Exile_Chopper_Huey_Armed_Desert",					// adding twice to double the chance
								"Exile_Chopper_Huey_Desert",						// adding twice to double the chance
								"Exile_Chopper_Huey_Green",							// adding twice to double the chance
								"Exile_Chopper_Hellcat_FIA",
								"Exile_Chopper_Hummingbird_Civillian_Digital",
								"Exile_Chopper_Hummingbird_Civillian_Elliptical",
								"Exile_Chopper_Hummingbird_Civillian_Furious",
								"Exile_Chopper_Hellcat_Green",
								"Exile_Chopper_Hummingbird_Civillian_Shadow",
								"Exile_Chopper_Hummingbird_Civillian_Sheriff",
								"Exile_Chopper_Hummingbird_Civillian_Vrana",
								"Exile_Chopper_Hummingbird_Civillian_Wasp",
								"Exile_Chopper_Hummingbird_Civillian_Wave"
							];
//choose the vehicle for prize
_VehicleClass = selectRandom _PossibleVehicleClass;

// is %chance greater than random number
if (_VehicleChance >= (random 100)) then {
											_pinCode = (1000 +(round (random 8999)));
											_vehicle = [_VehicleClass,[22127.7,14531.7,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Convicts have successfully cleared Thelos Racetrack and stolen all the crates, %1 entry code is %2...",_VehicleClass,_pinCode]];
											_Vwin = "Win";	//just for logging purposes
											} else
											{
											_vehicle = [_VehicleClass,[22127.7,14531.7,0]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Convicts have successfully cleared Thelos Racetrack and stolen all the crates"];
											_Vwin = "Lose";	//just for logging purposes
											};

//export to logs for testing - comment next line out for no log
diag_log format ["Thelos Racetrack:: Called MISSION with these parameters: >>AI Group: %1  >>Cash0: %2 >>Cash1: %3 >>Vwin: %4 >>Difficulty: %5",_AICount,_cash0,_cash1,_Vwin,_difficultyM];

// Define mission-spawned objects and loot values with vehicle
_missionObjs =	[
					_staticGuns+[_veh],													// static gun(s). Patrol vehicles
					[_vehicle],															// vehicle prize
					[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]		// crates
				];	

// Define Mission Start message
_msgStart = ['#FFFF00',format["Thelos Racetrack is being invaded by %1 terrorists",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Invaders have stripped Thelos Racetrack of loot and left."];

// Define mission name (for map marker and logging)
_missionName = "Thelos Racetrack";

// Create Markers
_markers =	[
				_pos,
				_missionName,
				_difficultyM
			] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [200,100];

_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =	[
				_pos,
				[
					[
						"kill",
						[_group,_group3]
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