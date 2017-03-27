/*
	"Bomos" v2.1 static mission for Altis.
	Created by [CiC]red_ned using templates by eraser1 
	18 years of CiC http://cic-gaming.co.uk
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_cash0", "_cash1", "_msgWIN"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [2414.53,22288.7,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

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
		_AICount = (15 + (round (random 5)));					//AI starting numbers
		_AIMaxReinforcements = (10 + (round (random 30)));		//AI reinforcement cap
		_AItrigger = (10 + (round (random 5)));					//If AI numbers fall below this number then reinforce if any left from AIMax
		_AIwave = (4 + (round (random 4)));						//Max amount of AI in reinforcement wave
		_AIdelay = (55 + (round (random 120)));					//The delay between reinforcements
		_cash0 = (250 + round (random (500)));					//this gives 250 to 750 cash
		_cash1 = (250 + round (random (500)));					//this gives 250 to 750 cash
		_crate_weapons0 	= (5 + (round (random 20)));		//Crate 0 weapons number
		_crate_items0 		= (5 + (round (random 20)));		//Crate 0 items number
		_crate_backpacks0 	= (3 + (round (random 1)));			//Crate 0 back packs number
		_crate_weapons1 	= (4 + (round (random 2)));			//Crate 1 weapons number
		_crate_items1 		= (10 + (round (random 40)));		//Crate 1 items number
		_crate_backpacks1 	= (1 + (round (random 8)));			//Crate 1 back packs number
	};
	case "moderate":
	{
		_difficulty = "moderate";
		_AICount = (20 + (round (random 5)));
		_AIMaxReinforcements = (20 + (round (random 20)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (5 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_cash0 = (500 + round (random (750)));					//this gives 500 to 1250 cash	
		_cash1 = (500 + round (random (750)));					//this gives 500 to 1250 cash	
		_crate_weapons0 	= (10 + (round (random 15)));
		_crate_items0 		= (10 + (round (random 15)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_crate_weapons1 	= (6 + (round (random 3)));
		_crate_items1 		= (20 + (round (random 30)));
		_crate_backpacks1 	= (5 + (round (random 4)));
	};
	case "difficult":
	{
		_difficulty = "difficult";
		_AICount = (20 + (round (random 7)));
		_AIMaxReinforcements = (30 + (round (random 20)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (6 + (round (random 2)));
		_AIdelay = (55 + (round (random 120)));
		_cash0 = (750 + round (random (1000)));					//this gives 750 to 1750 cash
		_cash1 = (750 + round (random (1000)));					//this gives 750 to 1750 cash
		_crate_weapons0 	= (20 + (round (random 20)));
		_crate_items0 		= (15 + (round (random 10)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_crate_weapons1 	= (8 + (round (random 3)));
		_crate_items1 		= (30 + (round (random 20)));
		_crate_backpacks1 	= (6 + (round (random 4)));
	};
	//case "hardcore":
	default
	{
		_difficulty = "hardcore";
		_AICount = (20 + (round (random 10)));
		_AIMaxReinforcements = (40 + (round (random 10)));
		_AItrigger = (15 + (round (random 5)));
		_AIwave = (6 + (round (random 2)));
		_AIdelay = (55 + (round (random 120)));
		_cash0 = (1000 + round (random (1500)));					//this gives 1000 to 2500 cash
		_cash1 = (1000 + round (random (1500)));					//this gives 1000 to 2500 cash
		_crate_weapons0 	= (30 + (round (random 10)));
		_crate_items0 		= (20 + (round (random 5)));
		_crate_backpacks0 	= (2 + (round (random 1)));
		_crate_weapons1 	= (10 + (round (random 2)));
		_crate_items1 		= (40 + (round (random 10)));
		_crate_backpacks1 	= (10 + (round (random 2)));
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
_AISoldierSpawnLocations =
							[
								[2086.76,22181.3,0],
								[2230.49,22162.8,0],
								[2248.99,22170.2,0],
								[2234.91,22178.2,0],
								[2241,22159.2,18.0424],
								[2282.4,22180.1,0],
								[2309.33,22374.1,0],
								[2318.27,22380.8,0],
								[2320.53,22389.6,0],
								[2305.52,22389.1,31.2191],
								[2371.86,22429,0],
								[2367.3,22423.4,0],
								[2361.02,22428.1,0],
								[2492.92,22416.8,0],
								[2489.23,22423.3,25.048],
								[2479.47,22426.5,0],
								[2470.83,22279.4,0],
								[2584.03,22116.1,0],
								[2614.44,22251.1,0],
								[2649.7,22130.3,0],
								[2404.84,22291.4,0],
								[2359,22332.6,0],
								[2278.91,22263.6,0],
								[2461.15,22131.6,0],
								[2552.37,22133.2,0],
								[2554.97,22163.6,0],
								[2677.63,22113.2,0],
								[2659.76,22084.7,0],
								[2673.19,22103.8,0],
								[2646.21,22138.8,0],
								[2641.31,22160.6,0],
								[2634.2,22274.1,0],
								[2630.65,22368.9,0],
								[2483.65,22421.7,0],
								[2324.94,22407.3,0],
								[2100.3,22183.2,0],
								[2133.11,22172,0],
								[2294.21,22174.2,0],
								[2294.75,22182,0],
								[2442.29,22257.6,0],
								[2489.25,22223.5,0]
							];

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
						//_pos vectorAdd [-5,0,0],		// 5 meters West of center pos
						_pos vectorAdd [0,-5,0],		// 5 meters South of center pos
						[2505.22,22432.2,0],
						[2006.28,22156.8,4.87243],
						[2247.48,22157.4,0],
						[2299.72,22182.1,0]
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
									[[2305.08,22389.6,0.083992],"I_CargoNet_01_ammo_F"],
									[[2364.02,22426.5,0.141647],"I_CargoNet_01_ammo_F"],
									[[2489.12,22425.9,-0.0554581],"I_CargoNet_01_ammo_F"],
									[[2238.04,22159.5,0.0163651],"I_CargoNet_01_ammo_F"],
									[[2079.59,22185.9,0.262085],"I_CargoNet_01_ammo_F"]
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
// add cash to crate
_crate0 setVariable ["ExileMoney", _cash0,true];	
_crate1 setVariable ["ExileMoney", _cash1,true];	

// Define mission-spawned objects and loot values
_missionObjs =
				[
					_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
					[],
					[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
				];

// Define Mission Start message
_msgStart = ['#FFFF00',format["A large group of %1 Terrorists have invaded Bomos",_difficultyM]];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the Terrorists and claimed all the crates"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The Terrorists have buggered off..."];

// Define mission name (for map marker and logging)
_missionName = "Bomos Invasion";

// Create Markers
_markers =
			[
				_pos,
				_missionName,
				_difficultyM
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