/*
	"Camp Bravery" v2.1 static mission for Napf.
	Created by [CiC]red_ned using templates by eraser1 
	Credits to Pradatoru for mapping
	19 years of CiC http://cic-gaming.co.uk
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/
private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate_loot_values0", "_crate_weapons0", "_crate_items0", "_crate_backpacks0", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_cash", "_RocketChance", "_MineChance1", "_MineChance2", "_MineNumber1", "_MineRadius1", "_MineNumber2", "_MineRadius2", "_Minefield1", "_Minefield2", "_cleanMines1", "_cleanMines2", "_temp", "_temp2", "_temp3", "_logLauncher"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [11100.3,18419.3,0]; //insert the center here

// Possible Minefield Positions
_Minefield1 = [11100.3,18419.3,0];
_Minefield2 = [11100.3,18419.3,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

// Create temp Buildings
_baseObjs =	[
				"Camp_Bravery_Objects"
			] call DMS_fnc_ImportFromM3E_3DEN_Static;

//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[	
								"easy",
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
		_AIMaxReinforcements = (10 + (round (random 5)));		//AI reinforcement cap
		_AItrigger = (10 + (round (random 5)));					//If AI numbers fall below this number then reinforce if any left from AIMax
		_AIwave = (4 + (round (random 4)));						//Max amount of AI in reinforcement wave
		_AIdelay = (55 + (round (random 120)));					//The delay between reinforcements
		_cash = (250 + round (random (500)));					//this gives 250 to 750 cash
		_crate_weapons0 	= (5 + (round (random 20)));		//Crate 0 weapons number
		_crate_items0 		= (5 + (round (random 20)));		//Crate 0 items number
		_crate_backpacks0 	= (3 + (round (random 1)));			//Crate 0 back packs number
		_RocketChance = 25;
		_MineChance1 = -1;
		_MineChance2 = 25;
		_MineNumber1 = (0 + (round (random 10)));
		_MineNumber2 = (5 + (round (random 5)));
		_MineRadius1 = (50 + (round (random 15)));
		_MineRadius2 = (55 + (round (random 50)));
	};
	case "moderate":
	{
		_difficulty = "moderate";
		_AICount = (20 + (round (random 5)));
		_AIMaxReinforcements = (20 + (round (random 10)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (5 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (500 + round (random (750)));					//this gives 500 to 1250 cash	
		_crate_weapons0 	= (10 + (round (random 15)));
		_crate_items0 		= (10 + (round (random 15)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_RocketChance = 33;
		_MineChance1 = -1;
		_MineChance2 = 33;
		_MineNumber1 = (5 + (round (random 10)));
		_MineNumber2 = (5 + (round (random 15)));
		_MineRadius1 = (60 + (round (random 25)));
		_MineRadius2 = (65 + (round (random 50)));;
	};
	case "difficult":
	{
		_difficulty = "difficult";
		_AICount = (30 + (round (random 5)));
		_AIMaxReinforcements = (20 + (round (random 10)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (6 + (round (random 2)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (750 + round (random (1000)));					//this gives 750 to 1750 cash
		_crate_weapons0 	= (30 + (round (random 20)));
		_crate_items0 		= (15 + (round (random 10)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_RocketChance = -1;
		_MineChance1 = 66;
		_MineChance2 = 75;
		_MineNumber1 = (10 + (round (random 10)));
		_MineNumber2 = (15 + (round (random 15)));
		_MineRadius1 = (70 + (round (random 35)));
		_MineRadius2 = (75 + (round (random 60)));
	};
	//case "hardcore":
	default
	{
		_difficulty = "hardcore";
		_AICount = (30 + (round (random 10)));
		_AIMaxReinforcements = (30 + (round (random 10)));
		_AItrigger = (10 + (round (random 5)));
		_AIwave = (6 + (round (random 2)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (1000 + round (random (1500)));					//this gives 1000 to 2500 cash
		_crate_weapons0 	= (20 + (round (random 5)));
		_crate_items0 		= (20 + (round (random 5)));
		_crate_backpacks0 	= (2 + (round (random 1)));
		_RocketChance = 100;
		_MineChance1 = -1;
		_MineChance2 = 100;
		_MineNumber1 = (15 + (round (random 20)));
		_MineNumber2 = (15 + (round (random 25)));
		_MineRadius1 = (75 + (round (random 40)));
		_MineRadius2 = (75 + (round (random 65)));
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
								[11033.1,18473.3,0.00287998],
								[11042.5,18412.1,0.00443721],
								[11046.8,18342.6,0.00657749],
								[11075.2,18418.9,0.00390148],
								[11078.1,18409.1,0.00406075],
								[11081.8,18438.2,0.00396633],
								[11087.8,18397.1,0.00331974],
								[11090.8,18443.3,0.00319672],
								[11092.8,18396.5,0.00279665],
								[11097.4,18425,18.1007],
								[11100.1,18423.3,15.3903],
								[11100.9,18435.2,0.00300217],
								[11102.1,18422,12.6618],
								[11102.9,18527,0.0102074],
								[11103.4,18416.1,17.8462],
								[11104.1,18423.9,17.596],
								[11104.6,18418,17.6984],
								[11108.4,18444.1,0.00277567],
								[11109.7,18397.6,0.00263929],
								[11114.6,18439.6,0.00278425],
								[11115.5,18397.5,0.00295639],
								[11122.3,18414.9,0.00245333],
								[11124.8,18425.3,0.00385571],
								[11147.1,18452.6,0.00258064],
								[11154.8,18382.1,0.00171471]
							];
// Shuffle the list of possible patrol spawn locations
_AISoldierSpawnLocations = _AISoldierSpawnLocations call ExileClient_util_array_shuffle;			
							
_group = 	[
				_AISoldierSpawnLocations+[_pos,_pos,_pos],			// Pass the regular spawn locations as well as the center pos 3x
				_AICount,
				_difficulty,
				"random",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;
			
/*	Uncomment to stop Ai wandering off
{_x disableAI "PATH";} forEach (units _group);
*/

_staticGuns = 	[
					[
						[11072.1,18430.9,7.15256e-006],
						[11079.9,18399,-7.00951e-005],
						[11099.6,18449.8,4.24385e-005],
						[11102,18426,17.7162],
						[11106.2,18417.4,17.4982],
						[11121.3,18401.1,4.72069e-005],
						[11124.7,18433.6,-1.14441e-005]
					],
					_group,
					"assault",
					_difficulty,
					"bandit",
					"random"
				] call DMS_fnc_SpawnAIStaticMG;

// Define the class names and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions = 	[
									[[11083.4,18417.1,0.0344148],"I_CargoNet_01_ammo_F"],
									[[11099,18422.6,18.021],"I_CargoNet_01_ammo_F"],
									[[11100.8,18422.3,0.00525427],"I_CargoNet_01_ammo_F"],
									[[11102.2,18417.7,17.8968],"I_CargoNet_01_ammo_F"],
									[[11102.5,18422.7,17.7435],"I_CargoNet_01_ammo_F"],
									[[11118.4,18420.8,0.0279379],"I_CargoNet_01_ammo_F"]
								];

{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list
_crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;

// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;

// Enable smoke on the crates due to size of area
{
	_x setVariable ["DMS_AllowSmoke", true];
} forEach [_crate0];

// Define mission-spawned AI Units
_missionAIUnits = 	[
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
_crate_loot_values0 = 	[
							_crate_weapons0,		// Set in difficulty select - Weapons
							_crate_items0,			// Set in difficulty select - Items
							_crate_backpacks0 		// Set in difficulty select - Backpacks
						];

// add cash to crate
_crate0 setVariable ["ExileMoney", _cash,true];						
						
// Define mission-spawned objects and loot values
_missionObjs = 	[
					_staticGuns+_baseObjs,			// static gun(s). Add so they get cleaned up.
					[],
					[[_crate0,_crate_loot_values0]],
					_cleanMines1,
					_cleanMines2
				];

// Define Mission Start message
_msgStart = ['#FFFF00',format["%1 Terrorists are setting up camp",_difficultyM]];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the Terrorists and stolen all the loot"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Terrorists got bored and buggered off taking all the goodies..."];

// Define mission name (for map marker and logging)
_missionName = "Camp Bravery";

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