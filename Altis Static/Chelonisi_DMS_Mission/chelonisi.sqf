/*
	"Chelonisi Power" v2.1 static mission for Altis.
	Created by [CiC]red_ned using templates by eraser1 
	18 years of CiC http://cic-gaming.co.uk
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_cash0", "_cash1", "_msgWIN"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [16696.7,13598,0]; //insert the centre here

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
								[16952.6,13403.9,0],
								[16939.6,13394.4,0],
								[16825.3,13557.9,0],
								[16804.1,13557.9,0],
								[16837.6,13622.8,0],
								[16838.3,13671.3,0],
								[16803.9,13700.3,0],
								[16774.7,13709.5,0],
								[16679,13707.3,0],
								[16667.2,13684.5,0],
								[16659.2,13696.7,4.42485],
								[16662.4,13689.5,4.42485],
								[16743.9,13651,0],
								[16772.5,13650.8,0],
								[16735.2,13638.5,0],
								[16723.4,13625,0],
								[16772.6,13595.5,0],
								[16776.7,13588.7,2.99077],
								[16783.2,13587.1,3.31053],
								[16729.7,13595.1,0],
								[16747.2,13551.1,0],
								[16732.6,13557.2,0],
								[16718.8,13533.1,0],
								[16694.6,13525.2,0],
								[16684.9,13519.3,0],
								[16740.3,13467.1,0],
								[16742.8,13467.9,0],
								[16706.7,13478.9,0],
								[16682,13427.9,0],
								[16668.1,13403.7,0],
								[16645.9,13454.4,0],
								[16674.2,13479.9,4.0421],
								[16668.3,13476.5,4.48973],
								[16583.3,13449.3,0],
								[16582.6,13449.3,0],
								[16603.5,13529,0],
								[16618.5,13524.4,0],
								[16589.9,13503,0],
								[16575.5,13509.5,0],
								[16538.6,13604.3,0],
								[16538.9,13610.2,0],
								[16583.6,13604.8,0],
								[16649.2,13581.5,0],
								[16663.7,13565.5,0],
								[16669.6,13581.1,0],
								[16593.2,13563,0],
								[16587.1,13574.6,3.98674],
								[16581.7,13569.8,4.189],
								[16642.1,13615.4,0],
								[16709.7,13549.9,0],
								[16713.2,13591.8,0]
							];

_group =
			[
				_AISoldierSpawnLocations,			// only do mapped AI spawns
				_AICount,
				_difficulty,
				"random",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;

_staticGuns =
				[
					[
						[16829.5,13569.5,0.0359752],	//only do mapped guns
						[16781.6,13583,3.46684],
						[16736.5,13628.1,0],
						[16754,13653,0],
						[16807.6,13677.9,0],
						[16666.4,13691.2,4.01622],
						[16584.1,13578.3,4.02518],
						[16661.9,13578.1,0],
						[16592.5,13488,0],
						[16671.9,13483.7,3.8167],
						[16716.1,13569.1,0],
						[16740.2,13548.7,0],
						[16812,13709.2,9.63884],
						[16688.9,13573.4,9.93271],
						[16652.8,13458.2,0],
						[16637.6,13532,0]
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
									[[16589.2,13493.4,0],"I_CargoNet_01_ammo_F"],
									[[16563.1,13509.6,0],"I_CargoNet_01_ammo_F"],
									[[16659.5,13583.5,0],"I_CargoNet_01_ammo_F"],
									[[16664.6,13410.5,9.54246],"I_CargoNet_01_ammo_F"],
									[[16710,13473,0.386646],"I_CargoNet_01_ammo_F"],
									[[16720.2,13546.7,0],"I_CargoNet_01_ammo_F"],
									[[16809.3,13708.9,9.66289],"I_CargoNet_01_ammo_F"],
									[[16754.4,13612.9,0],"I_CargoNet_01_ammo_F"]
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
_msgStart = ['#FFFF00',format["Thats an awful lot of power being used on Chelonisi, find out why. %1",_difficultyM]];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully cleared Chelonisi of terrorists"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Chelonisi has gone dark, but they will return!"];

// Define mission name (for map marker and logging)
_missionName = "Chelonisi Power";

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