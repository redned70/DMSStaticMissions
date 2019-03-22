/*
	"Stranded Bandits" v2.1 static mission for Napf.
	Created by [CiC]red_ned using templates by eraser1 
	Credits to Pradatoru for mapping
	19 years of CiC http://cic-gaming.co.uk
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/
private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_cash", "_AISoldierSpawnLocations", "_RocketChance", "_MineChance1", "_MineChance2", "_MineNumber1", "_MineRadius1", "_MineNumber2", "_MineRadius2", "_Minefield1", "_Minefield2", "_cleanMines1", "_cleanMines2", "_temp", "_temp2", "_temp3", "_logLauncher"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [4630.79,16651.6,0]; //insert the center here

// Possible Minefield Positions
_Minefield1 = [4630.79,16651.6,0];	// not really using this one this time
_Minefield2 = [4630.79,16651.6,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

// Create temp Buildings
_baseObjs =	[
				"Stranded_Bandits_Objects"
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
								"hardcore"
							];
//choose mission difficulty and set value and is also marker colour
_difficultyM = selectRandom _PossibleDifficulty;

switch (_difficultyM) do
{
	case "easy":
	{
		_difficulty = "easy";									//AI difficulty
		_AICount = (20 + (round (random 5)));					//AI starting numbers
		_AIMaxReinforcements = (10 + (round (random 30)));		//AI reinforcement cap
		_AItrigger = (10 + (round (random 5)));					//If AI numbers fall below this number then reinforce if any left from AIMax
		_AIwave = (4 + (round (random 4)));						//Max amount of AI in reinforcement wave
		_AIdelay = (55 + (round (random 120)));					//The delay between reinforcements
		_cash = (250 + round (random (500)));					//this gives 250 to 750 cash
		_crate_weapons0 	= (5 + (round (random 20)));		//Crate 0 weapons number
		_crate_items0 		= (5 + (round (random 20)));		//Crate 0 items number
		_crate_backpacks0 	= (3 + (round (random 1)));			//Crate 0 back packs number
		_crate_weapons1 	= (4 + (round (random 2)));			//Crate 1 weapons number
		_crate_items1 		= (10 + (round (random 40)));		//Crate 1 items number
		_crate_backpacks1 	= (1 + (round (random 8)));			//Crate 1 back packs number
		_RocketChance = 25;
		_MineChance1 = -1;
		_MineChance2 = 25;
		_MineNumber1 = (0 + (round (random 10)));
		_MineNumber2 = (5 + (round (random 5)));
		_MineRadius1 = (50 + (round (random 15)));
		_MineRadius2 = (55 + (round (random 10)));
	};
	case "moderate":
	{
		_difficulty = "moderate";
		_AICount = (25 + (round (random 5)));
		_AIMaxReinforcements = (20 + (round (random 20)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (5 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (500 + round (random (750)));					//this gives 500 to 1250 cash	
		_crate_weapons0 	= (10 + (round (random 15)));
		_crate_items0 		= (10 + (round (random 15)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_crate_weapons1 	= (6 + (round (random 3)));
		_crate_items1 		= (20 + (round (random 30)));
		_crate_backpacks1 	= (5 + (round (random 4)));
		_RocketChance = 33;
		_MineChance1 = -1;
		_MineChance2 = 33;
		_MineNumber1 = (5 + (round (random 10)));
		_MineNumber2 = (5 + (round (random 15)));
		_MineRadius1 = (60 + (round (random 25)));
		_MineRadius2 = (65 + (round (random 20)));;
	};
	case "difficult":
	{
		_difficulty = "difficult";
		_AICount = (30 + (round (random 7)));
		_AIMaxReinforcements = (30 + (round (random 20)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (6 + (round (random 2)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (750 + round (random (1000)));					//this gives 750 to 1750 cash
		_crate_weapons0 	= (30 + (round (random 20)));
		_crate_items0 		= (15 + (round (random 10)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_crate_weapons1 	= (8 + (round (random 3)));
		_crate_items1 		= (30 + (round (random 20)));
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
		_AICount = (30 + (round (random 10)));
		_AIMaxReinforcements = (40 + (round (random 20)));
		_AItrigger = (15 + (round (random 5)));
		_AIwave = (6 + (round (random 2)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (1000 + round (random (1500)));					//this gives 1000 to 2500 cash
		_crate_weapons0 	= (20 + (round (random 5)));
		_crate_items0 		= (20 + (round (random 5)));
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
_AISoldierSpawnLocations = 	[
								[4528.88,16639.9,0.0106294],
								[4535.82,16578.3,0.00635147],
								[4552.44,16698.6,0.00791645],
								[4552.88,16641.9,0.00993013],
								[4553.08,16541.7,0.00705671],
								[4568.22,16534.5,0.00216722],
								[4573.48,16518.8,0.0140932],
								[4576.7,16531.3,0.00177741],
								[4577.67,16730,0.0285118],
								[4582.83,16663.8,0.00459766],
								[4585.87,16527.3,0.00413895],
								[4590.91,16542.2,0.00182772],
								[4595.79,16524.3,0.00627279],
								[4607.22,16521.6,0.00468874],
								[4615.84,16690.5,0.00131226],
								[4622.18,16509,0.0121088],
								[4623.51,16683.7,0.000292778],
								[4624.3,16520.9,0.00686669],
								[4626.68,16532.6,0.00221014],
								[4628.39,16689.9,0.000524521],
								[4635.98,16523.1,0.00837851],
								[4636.4,16750.5,0.0348511],
								[4649.41,16759.8,0.023098],
								[4649.5,16716.1,0.00282764],
								[4656.43,16604.7,0.00161171],
								[4666.3,16562.7,0.00155687],
								[4668.85,16679.3,0.00634098],
								[4669.87,16700.4,0.00255966],
								[4670.81,16729.9,0.00873947],
								[4683.61,16548.9,0.0332415],
								[4687.96,16716.4,0.00846958],
								[4697.24,16605.7,0.00490332],
								[4704.97,16767.1,0.00475049],
								[4714.03,16724.7,0.00952601],
								[4723.26,16601,0.0128973],
								[4730.82,16714.2,0.0115728],
								[4733.91,16660.3,0.00080061],
								[4758.21,16651,0.00872707]
							];
// Shuffle the list of possible patrol spawn locations
_AISoldierSpawnLocations = _AISoldierSpawnLocations call ExileClient_util_array_shuffle;							
							
_group = 	[
				_AISoldierSpawnLocations,			// Pass the regular spawn locations
				_AICount,
				_difficulty,
				"random",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;

/*	// Uncomment to stop Ai wandering off
{_x disableAI "PATH";} forEach (units _group);
*/		
			
_staticGuns = 	[
					[
						[4566.67,16662.4,-6.62804e-005],
						[4567.05,16642.9,0.00342894],
						[4606.58,16554,6.10352e-005],
						[4608.08,16653.1,-3.52859e-005],
						[4623.66,16696.7,-5.24521e-005],
						[4637.93,16592,1.90735e-006],
						[4666.03,16546.2,0.000133514],
						[4666.52,16657.3,-0.000113487],
						[4668.02,16632.5,-5.57899e-005],
						[4707.77,16596.8,-2.24113e-005],
						[4722.06,16727.2,4.33922e-005],
						[4740.95,16649.3,0.00133705]
					],
					_group,
					"assault",
					_difficulty,
					"bandit",
					"random"
				] call DMS_fnc_SpawnAIStaticMG;

// Define the class names and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions = 	[
									[[4540.56,16597.8,0.0407569],"I_CargoNet_01_ammo_F"],
									[[4603.5,16734,-0.0155315],"I_CargoNet_01_ammo_F"],
									[[4633.61,16576.3,0.03163],"I_CargoNet_01_ammo_F"],
									[[4638.88,16597,0.00613213],"I_CargoNet_01_ammo_F"],
									[[4663.41,16649,-0.0232091],"I_CargoNet_01_ammo_F"],
									[[4675.16,16657.6,0.00152779],"I_CargoNet_01_ammo_F"],
									[[4675.49,16556.6,0.0239859],"I_CargoNet_01_ammo_F"],
									[[4711.97,16604.9,-0.0361085],"I_CargoNet_01_ammo_F"],
									[[4719.87,16730.1,-0.0390954],"I_CargoNet_01_ammo_F"],
									[[4744.22,16666.7,0.000927925],"I_CargoNet_01_ammo_F"]
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
_missionAIUnits = 	[
						_group 		// We only spawned the single group for this mission
					];

// Define the group reinforcements
_groupReinforcementsInfo = 	[
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
_crate_loot_values0 = 	[
							_crate_weapons0,		// Set in difficulty select - Weapons
							_crate_items0,			// Set in difficulty select - Items
							_crate_backpacks0 		// Set in difficulty select - Backpacks
						];
_crate_loot_values1 = 	[
							_crate_weapons1,		// Set in difficulty select - Weapons
							_crate_items1,			// Set in difficulty select - Items
							_crate_backpacks1 		// Set in difficulty select - Backpacks
						];

// add cash to crate
_crate1 setVariable ["ExileMoney", _cash,true];						
						
// Define mission-spawned objects and loot values
_missionObjs = 	[
					_staticGuns+_baseObjs,			// static gun(s). Add so they get cleaned up.
					[],
					[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]],
					_cleanMines1,
					_cleanMines2
				];

// Define Mission Start message
_msgStart = ['#FFFF00',format["%1 Bandits are stranded on an island, go kill them.",_difficultyM]];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the Bandits and stole all the loot"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Bandits got off the island taking all the goodies..."];

// Define mission name (for map marker and logging)
_missionName = "Stranded Bandits";

// Create Markers
_markers = 	[
				_pos,
				_missionName,
				_difficultyM
			] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [200,200];

_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added = 	[
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