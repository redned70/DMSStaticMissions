/*
	"Oil Island v2.1 static mission for Napf.
	Created by [CiC]red_ned using templates by eraser1 
	19 years of CiC http://cic-gaming.co.uk
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/
private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_cash", "_AISoldierSpawnLocations", "_crate_items1_list", "_RocketChance", "_MineChance1", "_MineChance2", "_MineNumber1", "_MineRadius1", "_MineNumber2", "_MineRadius2", "_Minefield1", "_Minefield2", "_cleanMines1", "_cleanMines2", "_temp", "_temp2", "_temp3", "_logLauncher"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [1358.22,5611.53,0]; //insert the center here

// Possible Minefield Positions
_Minefield1 = [1358.22,5611.53,0];	// not really using this one this time
_Minefield2 = [1358.22,5611.53,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

// Create temp Buildings
_baseObjs =	[
				"Oil_Island_Objects"
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
		_crate_weapons1 	= 0;								//Crate 1 weapons 0
		_crate_items1 		= (10 + (round (random 40)));		//Crate 1 items number
		_crate_backpacks1 	= 0;								//Crate 1 back packs 0
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
		_crate_weapons1 	= 0;								//Crate 1 weapons 0
		_crate_items1 		= (20 + (round (random 30)));
		_crate_backpacks1 	= 0;								//Crate 1 back packs 0
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
		_crate_weapons1 	= 0;								//Crate 1 weapons 0
		_crate_items1 		= (30 + (round (random 20)));
		_crate_backpacks1 	= 0;								//Crate 1 back packs 0
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
		_crate_weapons1 	= 0;								//Crate 1 weapons 0
		_crate_items1 		= (40 + (round (random 10)));
		_crate_backpacks1 	= 0;								//Crate 1 back packs 0
		_RocketChance = 100;
		_MineChance1 = -1;
		_MineChance2 = 100;
		_MineNumber1 = (15 + (round (random 20)));
		_MineNumber2 = (15 + (round (random 25)));
		_MineRadius1 = (75 + (round (random 40)));
		_MineRadius2 = (75 + (round (random 45)));
	};
};

// Crate1 will be fuel and tools only so create list to pick from
		_crate_items1_list	= ["Exile_Item_CamoTentKit", "Exile_Item_CanOpener", "Exile_Item_Can_Empty", "Exile_Item_CarWheel", "Exile_Item_Cement", "Exile_Item_CordlessScrewdriver", "Exile_Item_DuctTape", "Exile_Item_ExtensionCord", "Exile_Item_FireExtinguisher", "Exile_Item_Foolbox", "Exile_Item_FuelCanisterEmpty", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_FuelCanisterFull", "Exile_Item_Grinder", "Exile_Item_Hammer", "Exile_Item_Handsaw", "Exile_Item_JunkMetal", "Exile_Item_LightBulb", "Exile_Item_MetalBoard", "Exile_Item_MetalHedgehogKit", "Exile_Item_MetalPole", "Exile_Item_MetalScrews", "Exile_Item_MetalWire", "Exile_Item_OilCanister", "Exile_Item_Pliers", "Exile_Item_Rope", "Exile_Item_Sand", "Exile_Item_Screwdriver", "Exile_Item_Shovel", "Exile_Item_SleepingMat", "Exile_Item_SprayCan_Black", "Exile_Item_SprayCan_Black", "Exile_Item_SprayCan_Blue", "Exile_Item_SprayCan_Blue", "Exile_Item_SprayCan_Green", "Exile_Item_SprayCan_Green", "Exile_Item_SprayCan_Red", "Exile_Item_SprayCan_Red", "Exile_Item_SprayCan_White", "Exile_Item_SprayCan_White", "Exile_Item_ToiletPaper", "Exile_Item_WeaponParts", "Exile_Item_WeaponParts", "Exile_Item_WeaponParts", "Exile_Item_WeaponParts", "Exile_Item_Wrench"];
		
// Shuffle the list of possible items
_crate_items1_list = _crate_items1_list call ExileClient_util_array_shuffle;			

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
// The centre spawn location is added 3 times so at least 3 AI will spawn initially at the centre location, and so that future reinforcements are more likely to spawn at the centre.
_AISoldierSpawnLocations = 	[
								[1299.85,5622.78,0.00114059],
								[1305.94,5758.93,0.290824],
								[1310.06,5607.3,0.00114369],
								[1316.58,5641.15,0.00157332],
								[1320.66,5601.12,0.00122094],
								[1335.38,5640.78,0.00213802],
								[1337.12,5619.9,0.00159407],
								[1431.3,5591.09,0.0014168],
								[1444.09,5545.89,0.00143975],
								[1448.9,5577.62,0.00128317],
								[1449.88,5675.75,0.00154573],
								[1450.23,5648.81,0.00144613],
								[1453.47,5606.49,0.00117874],
								[1460.2,5625.73,0.00122213],
								[1462.02,5664.78,0.00129694]
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

// Uncomment to stop Ai wandering off as its an island
{_x disableAI "PATH";} forEach (units _group);

//adjust trigger for AI unfreeze
_group setVariable ["DMS_ai_freezingDistance",2500];
_group setVariable ["DMS_ai_unfreezingDistance",2500];
		
_staticGuns = 	[
					[
						[1312.23,5642.3,0.185642],
						[1318.57,5590.66,6.40453],
						[1333.94,5606.68,5.75607],
						[1429,5612.5,7.04522],
						[1433.57,5537.21,6.8783],
						[1436.74,5563.43,6.5019],
						[1441.13,5587.86,6.30753],
						[1445.71,5536.07,6.67795],
						[1449.21,5595.28,6.24266]
					],
					_group,
					"assault",
					_difficulty,
					"bandit",
					"random"
				] call DMS_fnc_SpawnAIStaticMG;

// Define the class names and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions = 	[
									[[1303.12,5619.18,0.0656724],"I_CargoNet_01_ammo_F"],
									[[1314.34,5600.66,0.00949907],"I_CargoNet_01_ammo_F"],
									[[1336.41,5626.38,-0.0276122],"I_CargoNet_01_ammo_F"],
									[[1344.15,5614.01,0.000987768],"I_CargoNet_01_ammo_F"],
									[[1444.76,5574.83,0.0046767],"I_CargoNet_01_ammo_F"],
									[[1446.98,5612.3,-0.0157484],"I_CargoNet_01_ammo_F"],
									[[1456.95,5677.94,-0.00876367],"I_CargoNet_01_ammo_F"]
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
							_crate_weapons1,							// Set in difficulty select - Weapons
							[_crate_items1,_crate_items1_list],			// Set in difficulty select - Items/Items list
							_crate_backpacks1 							// Set in difficulty select - Backpacks
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
_msgStart = ['#FFFF00',format["%1 Bandits are invading oil island, go kill them.",_difficultyM]];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the Bandits and stole all the loot"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Bandits got off the island taking all the tools and fuel"];

// Define mission name (for map marker and logging)
_missionName = "Oil Island Invasion";

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