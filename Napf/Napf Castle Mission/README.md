# DMSStaticMissions
Exile DMS Napf Castle Mission


*******************************************************
	Static mission for Napf.
	Credits to Pradatoru for some mapping
	Created by [CiC]red_ned using templates by eraser1 
	18 years of CiC http://cic-gaming.co.uk
*******************************************************
	This is map specific to Napf only
	Running on DMS System
*******************************************************
You must have DMS installed<br><br>


<b>Install Instructions</b><br>
1. 2 Choices depending on your current set up <br>
If you currently dont run a custom mapping load PBO then: Get @ExileServer\addons\a3_custom.pbo and add into your server @ExileServer\addons folder <br>
If you do currently run a custom mapping load PBO then: add [] execVM "a3_custom\mapcontent\DMS_Napf_Castle.sqf"; to your fn_init.sqf and add the DMS_Napf_Castle.sqf file to your /mapcontent/ folder.<br><br>
2. Extract your DMS PBO file and add the following 2 files into the correct places:<br>
@ExileServer\addons\a3_dms\missions\static\Napf_Castle_Mission.sqf<br>
@ExileServer\addons\a3_dms\objects\static\Napf_Castle_Objects.sqf<br><br>
3. Add the line ["Napf_Castle_Mission",8] from @ExileServer\addons\a3_dms\config.sqf into your DMS config.sqf<br>
4. Repack DMS PBO file (checking it packed with all 3 prefix files) and upload to @ExileServer\addons\ on your server<br><br><br>

<b>This mission uses 2 sets of mapping, 1 in a3_custom.pbo to load on server start and also Napf_Castle_Objects to load in a few extra objects on mission spawn to make the area change a little when a mission is on</b><br>