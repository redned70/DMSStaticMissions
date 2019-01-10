/*
	"Napf Castle" v2.1 static mission for Napf.
	Created by [CiC]red_ned using templates by eraser1 
	Credits to Pradatoru for mapping
	19 years of CiC http://cic-gaming.co.uk
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/
private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_cash", "_AISoldierSpawnLocations"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [11077.8,11801.7,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

// Create temp Buildings
_baseObjs =	[
				"Napf_Castle_Objects"
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
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
							[
								[11004.7,11790.3,0.0507965],
								[11004.8,11801.7,0.0518341],
								[11030.3,11809,0.00924683],
								[11034.4,11799.6,0.0085144],
								[11036.9,11783,0.0135651],
								[11042.2,11776.6,0.00935364],
								[11046.2,11797.3,0.866241],
								[11058.9,11784.2,4.38593],
								[11063.1,11826,0.00410461],
								[11065.2,11769.3,0.00350952],
								[11068.7,11792,0.000991821],
								[11071.4,11829.6,30.2139],
								[11074.3,11806.1,0.000457764],
								[11076.1,11766.2,0.0083313],
								[11079.2,11822.1,0.000244141],
								[11081.4,11786.9,0.407394],
								[11084.3,11815.8,6.86604],
								[11089.1,11822.8,2.94565],
								[11089.8,11777.1,0.00218201],
								[11096.8,11832.3,0.0243988],
								[11100.4,11843.2,0.0456543],
								[11106.6,11827,0.014801],
								[11108.6,11798.6,0.00392151],
								[11127.9,11831.9,0.0297546],
								[11131.4,11818.9,0.0249176]
							];
// Shuffle the list of possible patrol spawn locations
_AISoldierSpawnLocations = _AISoldierSpawnLocations call ExileClient_util_array_shuffle;							
							
_group =
			[
				_AISoldierSpawnLocations+[_pos,_pos,_pos],			// Pass the regular spawn locations as well as the center pos 3x
				_AICount,
				_difficulty,
				"random",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;

/*	// Uncomment to stop Ai wandering off
{_x disableAI "PATH";} forEach (units _group);
*/			
			
_staticGuns =
				[
					[
						[11014.4,11801.8,-1.52588e-005],
						[11026.7,11784,0.000396729],
						[11055,11785.9,4.82426],
						[11082.6,11768.8,-0.000274658],
						[11084.4,11806.5,7.53537],
						[11090.2,11811.8,7.01128]
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
									[[11050.3,11793.3,0.557617],"I_CargoNet_01_ammo_F"],
									[[11057.3,11787.8,0.910721],"I_CargoNet_01_ammo_F"],
									[[11063.9,11783.8,4.2645],"I_CargoNet_01_ammo_F"],
									[[11065.1,11790.2,0.257599],"I_CargoNet_01_ammo_F"],
									[[11082.7,11814.9,0.553116],"I_CargoNet_01_ammo_F"],
									[[11083.4,11792.8,0.398758],"I_CargoNet_01_ammo_F"],
									[[11083.9,11811.6,6.86894],"I_CargoNet_01_ammo_F"],
									[[11098,11824.6,3.14572],"I_CargoNet_01_ammo_F"]
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
_crate1 setVariable ["ExileMoney", _cash,true];						
						
// Define mission-spawned objects and loot values
_missionObjs =
				[
					_staticGuns+_baseObjs,			// static gun(s). Add so they get cleaned up.
					[],
					[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
				];

// Define Mission Start message
_msgStart = ['#FFFF00',format["%1 Terrorists are using the castle to repair their equipment",_difficultyM]];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the Terrorists and stolen all the loot"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Terrorists got bored and buggered off taking all the goodies..."];

// Define mission name (for map marker and logging)
_missionName = "Napf Castle Invasion";

// Create Markers
_markers =
			[
				_pos,
				_missionName,
				_difficultyM
			] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [200,200];

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