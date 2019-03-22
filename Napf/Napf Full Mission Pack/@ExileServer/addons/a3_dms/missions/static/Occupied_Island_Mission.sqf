/*
	"Occupied Island" v2.1 static mission for Napf.
	Helicoptor increases persistent chance with difficulty
	Created by [CiC]red_ned using templates by eraser1 
	Credits to Pradatoru for mapping
	19 years of CiC
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance", "_Vehiclelist", "_VehiclePrize", "_cash", "_baseObjs", "_group2", "_RocketChance", "_MineChance1", "_MineChance2", "_MineNumber1", "_MineRadius1", "_MineNumber2", "_MineRadius2", "_Minefield1", "_Minefield2", "_cleanMines1", "_cleanMines2", "_temp", "_temp2", "_temp3", "_logLauncher"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [8352.4,18347.4,0]; //insert the center here

// Possible Minefield Positions
_Minefield1 = [8352.4,18347.4,0];	// not really using this one this time
_Minefield2 = [8352.4,18347.4,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

// Create Buildings - this is so roadblocks only appear during mission
_baseObjs =	[
				"Occupied_Island_Objects"
			] call DMS_fnc_ImportFromM3E_3DEN_Static;

//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[	
								"easy",
								"moderate",
								"moderate",
								"difficult",
								"difficult",
								"difficult",
								"hardcore",
								"hardcore",
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
		_AIMaxReinforcements = (10 + (round (random 30)));		//AI reinforcement cap
		_AItrigger = (10 + (round (random 5)));					//If AI numbers fall below this number then reinforce if any left from AIMax
		_AIwave = (6 + (round (random 2)));						//Max amount of AI in reinforcement wave
		_AIdelay = (55 + (round (random 120)));					//The delay between reinforcements
		_VehicleChance = 10;									//10% SpawnPersistentVehicle chance
		_cash = (250 + round (random (500)));					//this gives 250 to 750 cash			
		_crate_weapons0 	= (5 + (round (random 20)));		//Crate 0 weapons number
		_crate_items0 		= (5 + (round (random 10)));		//Crate 0 items number
		_crate_backpacks0 	= (3 + (round (random 1)));			//Crate 0 back packs number
		_crate_weapons1 	= (4 + (round (random 2)));			//Crate 1 weapons number
		_crate_items1 		= (10 + (round (random 10)));		//Crate 1 items number
		_crate_backpacks1 	= (1 + (round (random 5)));			//Crate 1 back packs number
		_RocketChance = 25;
		_MineChance1 = -1;										// 0-100 for percentage chance or -1 to disable
		_MineChance2 = 25;										// 0-100 for percentage chance or -1 to disable
		_MineNumber1 = (0 + (round (random 10)));
		_MineNumber2 = (0 + (round (random 5)));
		_MineRadius1 = (50 + (round (random 15)));
		_MineRadius2 = (55 + (round (random 10)));
	};
	case "moderate":
	{
_difficulty = "moderate";
		_AICount = (20 + (round (random 5)));
		_AIMaxReinforcements = (20 + (round (random 20)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (7 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_VehicleChance = 20;									//20% SpawnPersistentVehicle chance
		_cash = (500 + round (random (750)));					//this gives 500 to 1250 cash			
		_crate_weapons0 	= (5 + (round (random 15)));
		_crate_items0 		= (5 + (round (random 15)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_crate_weapons1 	= (6 + (round (random 3)));
		_crate_items1 		= (20 + (round (random 20)));
		_crate_backpacks1 	= (5 + (round (random 4)));
		_RocketChance = 33;
		_MineChance1 = -1;
		_MineChance2 = 33;
		_MineNumber1 = (0 + (round (random 10)));
		_MineNumber2 = (0 + (round (random 15)));
		_MineRadius1 = (60 + (round (random 25)));
		_MineRadius2 = (65 + (round (random 20)));;
	};
	case "difficult":
	{
		_difficulty = "difficult";
		_AICount = (20 + (round (random 7)));
		_AIMaxReinforcements = (30 + (round (random 20)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (8 + (round (random 4)));
		_AIdelay = (55 + (round (random 120)));
		_VehicleChance = 75;									//75% SpawnPersistentVehicle chance
		_cash = (750 + round (random (1000)));					//this gives 750 to 1750 cash			
		_crate_weapons0 	= (10 + (round (random 10)));
		_crate_items0 		= (10 + (round (random 10)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_crate_weapons1 	= (8 + (round (random 3)));
		_crate_items1 		= (30 + (round (random 10)));
		_crate_backpacks1 	= (6 + (round (random 4)));
		_RocketChance = 75;
		_MineChance1 = -1;
		_MineChance2 = 75;
		_MineNumber1 = (10 + (round (random 10)));
		_MineNumber2 = (15 + (round (random 15)));
		_MineRadius1 = (70 + (round (random 35)));
		_MineRadius2 = (75 + (round (random 30)));
	};
	//case "hardcore":
	default
	{
		_difficulty = "hardcore";
		_AICount = (20 + (round (random 15)));
		_AIMaxReinforcements = (40 + (round (random 10)));
		_AItrigger = (15 + (round (random 5)));
		_AIwave = (9 + (round (random 5)));
		_AIdelay = (55 + (round (random 120)));
		_VehicleChance = 90;									//90% SpawnPersistentVehicle chance
		_cash = (1000 + round (random (1500)));					//this gives 1000 to 2500 cash			
		_crate_weapons0 	= (20 + (round (random 5)));
		_crate_items0 		= (30 + (round (random 5)));
		_crate_backpacks0 	= (2 + (round (random 1)));
		_crate_weapons1 	= (10 + (round (random 2)));
		_crate_items1 		= (40 + (round (random 10)));
		_crate_backpacks1 	= (10 + (round (random 2)));
		_RocketChance = 100;
		_MineChance1 = -1;
		_MineChance2 = 100;
		_MineNumber1 = (15 + (round (random 20)));
		_MineNumber2 = (15 + (round (random 25)));
		_MineRadius1 = (75 + (round (random 40)));
		_MineRadius2 = (75 + (round (random 45)));
	};
};

// Chose the prize heli
_Vehiclelist =	[
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_Digital",
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_Elliptical",
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_Furious",
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_GrayWatcher",
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_Jeans",
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_Light",
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_Shadow",
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_Sheriff",
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_Speedy",
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_Sunset",
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_Vrana",
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_Wasp",
				"B_Heli_Light_01_armed_F",
				"Exile_Chopper_Hummingbird_Civillian_Wave"
				];
_VehiclePrize = selectRandom _Vehiclelist;

//add launchers if chance great enough
if (_RocketChance >= (random 100)) then {
											_temp = DMS_ai_use_launchers;
											DMS_ai_use_launchers = true;
											_temp2 = DMS_ai_use_launchers_chance;
											DMS_ai_use_launchers_chance = 100;
											_logLauncher = "1";
										} else
										{
											_temp = DMS_ai_use_launchers;
											DMS_ai_use_launchers = false;
											_temp2 = DMS_ai_use_launchers_chance;
											DMS_ai_use_launchers_chance = 0;
											_logLauncher = "0";
										};

// Make sure mine clean up is on, but we will handle it too
_temp3 = DMS_despawnMines_onCompletion;
DMS_despawnMines_onCompletion = true;

//add minefields if chance great enough
if (_MineChance1 >= (random 100)) then 	{
							_cleanMines1 = 		[
													_pos,
													_difficulty,
													[_MineNumber1,_MineRadius1],
													_side
												] call DMS_fnc_SpawnMinefield;
										} else
										{
							_cleanMines1 = [];
										};

if (_MineChance2 >= (random 100)) then 	{
							_cleanMines2 =		[
													_Minefield2,
													_difficultyM,
													[_MineNumber2,_MineRadius2],
													_side
												] call DMS_fnc_SpawnMinefield;
										} else
										{
							_cleanMines2 = [];
										};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =	[
								[8212.23,18271.1,0.0057162],
								[8222.25,18252.1,0.00318491],
								[8234.72,18287.1,0.00703526],
								[8237.02,18314.2,0.00937068],
								[8244.31,18266.6,0.00833917],
								[8251.65,18304.6,0.0105202],
								[8272.05,18294,0.00201082],
								[8273.02,18353.3,0.00746107],
								[8274.49,18392,0.00750953],
								[8293.41,18327.1,0.00268269],
								[8295.67,18402.1,0.0103669],
								[8297.76,18266.5,0.0177245],
								[8330.07,18253.9,0.0262746],
								[8333.93,18275,0.0139422],
								[8340.9,18426.7,0.0204295],
								[8345.59,18398.9,0.00874519],
								[8346.47,18324.1,0.00383282],
								[8361.26,18284.9,0.0247369],
								[8372.35,18292.3,0.0362554],
								[8381.93,18406,0.0132051],
								[8384.75,18390.1,0.0086565],
								[8387.91,18348.4,0.00032711],
								[8392.7,18366.3,0.00144577],
								[8400.49,18395.6,0.00409794],
								[8405.63,18438.5,0.0268729],
								[8408.66,18313,0.0232339],
								[8412.15,18412.3,0.0105028],
								[8414,18382.3,0.00263977],
								[8442.02,18376,0.0035696],
								[8449.43,18384.5,0.0004282],
								[8449.68,18344.2,0.0179019],
								[8455.47,18418.1,0.00336742],
								[8473.83,18448,0.0176075],
								[8473.94,18413.5,0.00600576],
								[8482.97,18377,0.0118651]
							];
// Shuffle the list of possible patrol spawn locations
_AISoldierSpawnLocations = _AISoldierSpawnLocations call ExileClient_util_array_shuffle;	

_group =	[
				_AISoldierSpawnLocations,							// Pass the regular spawn locations no center pos as centre off ground
				_AICount,											// Set in difficulty select
				_difficulty,										// Set in difficulty select
				"random",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;

/*	// Uncomment to stop Ai wandering off
{_x disableAI "PATH";} forEach (units _group);
*/

_group2 =	[                                                       // Helicopter support group
				[8358.72,18332,250],                 				//heli reinforcements
				1,
				"random",
				"random",
				"bandit"
			] call DMS_fnc_SpawnAIGroup;
			[
			_group2,
			"random",
			_difficulty,
			"bandit",
			[8358.72,18332,200],
			true,
			10,
			false,
			"Exile_Chopper_Huey_Armed_Green",
			[6238,20457,500]
			] call DMS_fnc_SpawnHeliReinforcement;

//stop freezing on ai heli
//_group2 setVariable ["DMS_AllowFreezing",true];
			
//Reduce Static guns if mission is easy
if (_difficultyM isEqualTo "easy") then {
_staticGuns =	[
					[
						[8238.99,18291.3,3.46527],
						//[8254.15,18331.3,3.71283],
						[8283.13,18381.4,4.00052],
						[8287.68,18319.5,3.29018e-005],
						//[8289.9,18309.3,5.72205e-005],
						[8326.76,18409.3,3.8398],
						[8330.34,18310.5,0.000242233],
						[8370.92,18418.8,4.15464],
						//[8372.54,18328.8,-0.000118256],
						[8426.62,18385,7.72476e-005],
						[8441.3,18382.7,0.000117302],
						[8454.81,18431,3.65036]
					],
					_group,
					"assault",
					_difficulty,
					"bandit",
					"random"
				] call DMS_fnc_SpawnAIStaticMG;	
										} else {
_staticGuns =	[
					[
						[8238.99,18291.3,3.46527],
						[8254.15,18331.3,3.71283],
						[8283.13,18381.4,4.00052],
						[8287.68,18319.5,3.29018e-005],
						[8289.9,18309.3,5.72205e-005],
						[8326.76,18409.3,3.8398],
						[8330.34,18310.5,0.000242233],
						[8370.92,18418.8,4.15464],
						[8372.54,18328.8,-0.000118256],
						[8426.62,18385,7.72476e-005],
						[8441.3,18382.7,0.000117302],
						[8454.81,18431,3.65036]
					],
						_group,
						"assault",
						_difficulty,
						"bandit",
						"random"
					] call DMS_fnc_SpawnAIStaticMG;		
											};

// Define the classnames and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions =	[
									[[8262.01,18270.4,0.00437617],"I_CargoNet_01_ammo_F"],
									[[8328.68,18340.3,0.00204945],"I_CargoNet_01_ammo_F"],
									[[8335,18320.5,0.114648],"I_CargoNet_01_ammo_F"],
									[[8402.63,18347,0.00142956],"I_CargoNet_01_ammo_F"],
									[[8419.94,18386.7,0.0520735],"I_CargoNet_01_ammo_F"],
									[[8487.8,18402.9,0.00422955],"I_CargoNet_01_ammo_F"]
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
						_group 		// We only spawned the single group for this mission
					];

// Define the group reinforcements
_groupReinforcementsInfo =	[
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

// is %chance greater than random number
if (_VehicleChance >= (random 100)) then {
											_pinCode = (1000 +(round (random 8999)));
											_vehicle = [_VehiclePrize,[8440.32,18421.7,1.21977],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Convicts have successfully cleared the island and have stolen all the crates, Heli entry code is %1...",_pinCode]];
											} else
											{
											_vehicle = [_VehiclePrize,[8440.32,18421.7,1.21977]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Convicts have successfully cleared the island and stolen all the crates"];
											};
											// set vehicle direction
											_vehicle setDir (35.073);

// add cash to _vehicle
_vehicle setVariable ["ExileMoney", _cash,true];												
	
// Define mission-spawned objects and loot values with vehicle
_missionObjs =	[
					_staticGuns+_baseObjs,			// static gun(s). Road blocks appear on start for mission in this one +_baseObjs+[_veh]
					[_vehicle],								// vehicle prize
					[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]],
					_cleanMines1,
					_cleanMines2
				];	

// Define Mission Start message
_msgStart = ['#FFFF00',format[" %1 Invaders are occupying an island",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Invaders have got away with all the loot..."];

// Define mission name (for map marker and logging)
_missionName = "Occupied Island";

// Create Markers
_markers =	[
				_pos,
				_missionName,
				_difficultyM
			] call DMS_fnc_CreateMarker;
			
_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [250,100];

_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =	[
				_pos,
				[
					[
						"kill",
						[_group,_group2]
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