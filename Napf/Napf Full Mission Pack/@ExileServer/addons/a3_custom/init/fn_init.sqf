diag_log "***** Starting Custom Content PBO *****";

diag_log "***** Starting Custom Traders PBO *****";
//Traders

diag_log "***** Starting Custom DMS PBO *****";
//DMS Static Missions
call compile preprocessFileLineNumbers "a3_custom\mapcontent\DMS_Camp_Audacity.sqf";
call compile preprocessFileLineNumbers "a3_custom\mapcontent\DMS_Camp_Bravery.sqf";
call compile preprocessFileLineNumbers "a3_custom\mapcontent\DMS_Camp_Courage.sqf";
call compile preprocessFileLineNumbers "a3_custom\mapcontent\DMS_Camp_Fortitude.sqf";
call compile preprocessFileLineNumbers "a3_custom\mapcontent\DMS_Froburg_Castle.sqf";
call compile preprocessFileLineNumbers "a3_custom\mapcontent\DMS_Homburg_Castle.sqf";
call compile preprocessFileLineNumbers "a3_custom\mapcontent\DMS_Military_Base.sqf";
call compile preprocessFileLineNumbers "a3_custom\mapcontent\DMS_Napf_Castle.sqf";
call compile preprocessFileLineNumbers "a3_custom\mapcontent\DMS_Occupied_Island.sqf";
call compile preprocessFileLineNumbers "a3_custom\mapcontent\DMS_Oil_Field.sqf";
call compile preprocessFileLineNumbers "a3_custom\mapcontent\DMS_Stranded_Bandits.sqf";

diag_log "***** Starting Custom Mapping PBO *****";
//Custom Bridges
call compile preprocessFileLineNumbers "a3_custom\mapcontent\Napf_Bridges.sqf";

diag_log "***** Starting Custom Markers PBO *****";
// Custom Bridge Markers
call compile preprocessFileLineNumbers "a3_custom\mapcontent\DMS_Oil_Field_Markers.sqf";
call compile preprocessFileLineNumbers "a3_custom\mapcontent\Napf_Bridges_Markers.sqf";


diag_log "***** Finished Custom Content PBO *****";