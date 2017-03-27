/*
	"Kill the Mayor" v2.1 static mission for Altis.
	Credits to Pradatoru for mapping
	Created by [CiC]red_ned using templates by eraser1 
	18 years of CiC http://cic-gaming.co.uk
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_cash0", "_cash1", "_msgWIN"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [22755.4,7766.04,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
							[
								[22669.2,7832.95,0.53994],
								[22796.6,7678.43,12.7222],	
								[22769.8,7717.13,0],
								[22665.2,7763.93,0],
								[22818.5,7787.05,19.1644],
								[22713.6,7731.41,0.347401],
								[22738.4,7875.33,19.3918],
								[22745.1,7703.83,0],
								[22737.7,7747.74,0.381065],
								[22673.8,7769.35,0.874329],
								[22681.7,7941.17,18.2074],
								[22712,7778.47,0.0947495],
								[22827.1,7646.43,0],
								[22796.7,7830.28,0],
								[22710.7,7919.42,0],
								[22837.9,7722.11,0],
								[22849.9,7695.96,18.6276],
								[22773.4,7654.58,0]
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
						_pos vectorAdd [-5,0,0],		// 5 meters West of center pos
						_pos vectorAdd [0,-5,0],		// 5 meters South of center pos
						[22842.4,7695.57,17.8621],	
						[22813.9,7780.85,18.2571],
						[22738.4,7867.2,17.6482],
						[22716.8,7733.74,0.381149],
						[22694.9,7793.23,0.257057],
						[22681.8,7933.78,18.1068],
						[22811.7,7672.22,0.245289],
						[22656.9,7794.08,0]
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
									[[22753.7,7663.57,0.481731],"I_CargoNet_01_ammo_F"],
									[[22698.5,7758.17,0],"I_CargoNet_01_ammo_F"],
									[[22785.9,7709.83,0.799274],"I_CargoNet_01_ammo_F"],
									[[22673.5,7763.94,3.58486],"I_CargoNet_01_ammo_F"],
									[[22681.8,7823.54,0],"I_CargoNet_01_ammo_F"],
									[[22750.5,7761.01,0.97084],"I_CargoNet_01_ammo_F"]
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
_msgStart = ['#FFFF00', "The old Mayors %1 troups are trying to set up his old home",_difficultyM]];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the Mayors troups and prevented his return"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The Mayors troups have left his house to continue planning the Mayors return..."];

// Define mission name (for map marker and logging)
_missionName = "Stop the Mayor";

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