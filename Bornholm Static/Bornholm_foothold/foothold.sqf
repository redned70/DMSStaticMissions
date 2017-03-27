/*
	"Operation Foothold" v2.1 static mission for Bornholm.
	Created by [CiC]red_ned using templates by eraser1 
	18 years of CiC http://cic-gaming.co.uk
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_cash0", "_cash1"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [7100.12,15745.2,0]; //insert the centre here

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
		_crate_weapons0 	= (30 + (round (random 20)));
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
		_crate_weapons0 	= (20 + (round (random 5)));
		_crate_items0 		= (20 + (round (random 5)));
		_crate_backpacks0 	= (2 + (round (random 1)));
		_crate_weapons1 	= (10 + (round (random 2)));
		_crate_items1 		= (40 + (round (random 10)));
		_crate_backpacks1 	= (10 + (round (random 2)));
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
							[
								[7061.15,15688.4,0.0294113],
								[7049.15,15691.5,4.50158],
								[7056.9,15698.8,4.50158],
								[7052.89,15722,0],
								[7053.45,15755.7,0],
								[7052.1,15790.5,0],
								[7060.78,15774.4,0],
								[7081.85,15764.7,0],
								[7102.5,15761.8,0],
								[7131.38,15762.8,0],
								[7084.99,15796.4,0],
								[7218.88,15767.4,0],
								[7218.94,15752.8,0],
								[7181.74,15779.8,0],
								[7168.35,15779.8,0],
								[7150.28,15798.3,4.21044],
								[7157.44,15790.1,3.98317],
								[7185.44,15738.4,0],
								[7187.86,15743.2,4.16763],
								[7187.34,15772.1,4.26975],
								[7190.82,15717.9,0],
								[7190.84,15690.6,0],
								[7177.29,15686.3,0],
								[7120.79,15699.5,0],
								[7100.18,15700.6,0],
								[7080.71,15703,0],
								[7079.81,15731,0],
								[7120.98,15734.8,0],
								[7109.03,15735.3,0],
								[7145.6,15735.5,0],
								[7160.64,15693.4,0],
								[7139.41,15692.5,0]
							];

_group =
			[
				_AISoldierSpawnLocations+[_pos,_pos,_pos],			// Pass the regular spawn locations as well as the center pos 3x
				_AICount,
				_difficulty,
				"random",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;

//Reduce Static guns if mission is easy
if (_difficultyM isEqualTo "easy") then {
_staticGuns =
				[
					[
						[7146.33,15746,0],
						[7183.31,15729.1,10.0807],
						[7183.17,15720.8,10.0625],
						[7145.74,15704.1,0],
						[7066.01,15723.3,10.0097],
						[7056.56,15694,4.45152],
						[7181.89,15711.2,24.3318],
						[7181.94,15704.8,24.3318],
						[7151.94,15790.9,4.25827]
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
						[7146.33,15746,0],
						[7183.31,15729.1,10.0807],
						[7183.17,15720.8,10.0625],
						[7167.24,15703.8,0],
						[7145.74,15704.1,0],
						[7066.01,15723.3,10.0097],
						[7083.87,15755.9,0],
						[7128.77,15778.5,0],
						[7109.59,15755.2,0],
						[7115.51,15734.3,0],
						[7056.56,15694,4.45152],
						[7181.89,15711.2,24.3318],
						[7181.94,15704.8,24.3318],
						[7151.94,15790.9,4.25827]
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
									[[7156.96,15697.6,-0.0548019],"I_CargoNet_01_ammo_F"],
									[[7135.64,15696.4,0],"I_CargoNet_01_ammo_F"],
									[[7114.54,15740.7,0],"I_CargoNet_01_ammo_F"],
									[[7068.9,15692.1,0],"I_CargoNet_01_ammo_F"],
									[[7071.96,15751.4,0],"I_CargoNet_01_ammo_F"],
									[[7134.71,15781.9,0],"I_CargoNet_01_ammo_F"]
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

// add cash to crate
_crate0 setVariable ["ExileMoney", _cash0,true];	
_crate1 setVariable ["ExileMoney", _cash1,true];						
						
_missionObjs =
				[
					_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
					[],
					[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
				];	
				
// Define Mission Start message
_msgStart = ['#FFFF00',format["%1 terrorists are trying to get a foothold in the area, stop them!",_difficultyM]];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the terrorists and stolen all the crates"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The terrorists have moved off to resupply..."];

// Define mission name (for map marker and logging)
_missionName = "Operation Foothold";

// Create Markers
_markers =
			[
				_pos,
				_missionName,
				_difficultyM
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