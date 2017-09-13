Multiplayer Bot script for MoH:AA obj
=============================================
by jv_map
version 1.1
---------------------------------------------
Copyright (c) 2002-2003 Jeroen Vrijkorte
All rights reserved.
---------------------------------------------
Distribution is allowed provided all subsequent 
conditions are met:

1. Commercial use is prohibited.

2. The above copyright notice and this permission notice shall
be included in all copies or substantial portions of the file.

3. If you have made modifications to the original files you must
cause the modified files to carry prominent notices stating
that you changed the files.

COPYRIGHT HOLDERS WILL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, 
SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF ANY USE OF THE 
SOFTWARE OR DOCUMENTATION.
---------------------------------------------
jv_map@planetmedalofhonor.com
http://www.planetmedal.com/freebrief
---------------------------------------------
This file contains all scripts needed for jv_map's multiplayer 
bots and bot models. This pk3 doesn't overwrite any original files.
It can be used with or without jv_bot0.pk3

Bots for stock mohaa objmaps:

This mod adds bot support for all stock objective maps in MOHAA. The following maps are all supported:

obj_team1 - The Hunt
obj_team2 - V2 Rocket Facility
obj_team3 - Omaha Beach
obj_team4 - The Bridge

and as a bonus...

mohdm4 - The Crossroads



To Install : Just place the jv_bot01.pk3  and the zzz_cheechbots.pk3 into your main folder

To Uninstall: Just remove the jv_bot01.pk3  and the zzz_cheechbots.pk3 from your main folder


V2 Rocket Facility BOT addon by Cheech
--------------------------------------
--------------------------------------
Description
-----------
	This addon adds bot-support to the usual V2 objective map, based on jv_map bots version 1.1.

IMPORTANT !!!!!!!!!!!!!!!!
--------------------------
	After installing this addon, the usual V2 objective mapscript will be disabled.
	To enable it back to the usual V2 objective mapscript uninstall the addon.

What큦 the difference between the usual V2 objective map ?
----------------------------------------------------------
	- BOT Support
	- small fog added (30000WU)
	- 7 new Allies Player-Spawnpoints
	- 12 new Axis Player-Spawnpoints
	- gamemessage after completing every objective
	- gametypestring of the server set to "jv_bot01", during the addon is running (Serverlists)
	- the usual V2 objective mapscript will be disabled after installing the addon


What큦 needed for the Client (Player)?
--------------------------------------
	The player who큦 connecting to the server needs only the jv_bot01.pk3 file. ;-)
	Please remember all players, or setup the servertitle with this remark.

Start the addon
---------------
	Start your server with the map obj_team2 in objective gametype. 
	If one player join a team, the bots are starting.



Omaha Beach BOT addon by Cheech
-------------------------------
-------------------------------
Description
-----------
	This addon adds bot-support to the usual Omaha Beach objective map, based on jv_map bots version 1.1.


IMPORTANT !!!!!!!!!!!!!!!!
--------------------------
	After installing this addon, the usual Omaha Beach objective mapscript will be disabled.
	To enable it back to the usual Omaha Beach objective mapscript uninstall the addon.


What큦 the difference between the usual Omaha Beach objective map ?
-------------------------------------------------------------------
	- BOT Support
	- 2x BOT MG42 added
	- Mapstart after destroying the fence
	- gametypestring of the server set to "jv_bot01", during the addon is running (Serverlists)
	- the usual Omaha Beach objective mapscript will be disabled after installing the addon


What큦 needed for the Client (Player)?
--------------------------------------
	The player who큦 connecting to the server needs only the jv_bot01.pk3 file. ;-)
	Please remember all players, or setup the servertitle with this remark.

Start the addon
---------------
	Start your server with the map obj_team3 in objective gametype. 
	If one player join a team, the bots are starting.



The Hunt BOT addon by Cheech
----------------------------
----------------------------
Description
-----------
	This addon adds bot-support to the usual The Hunt objective map, based on jv_map bots version 1.1.


IMPORTANT !!!!!!!!!!!!!!!!
--------------------------
	After installing this addon, the usual The Hunt objective mapscript will be disabled.
	To enable it back to the usual The Hunt objective mapscript uninstall the addon.


What큦 the difference between the usual The Hunt objective map ?
----------------------------------------------------------------
	- BOT Support
	- 10 new Allies Player-Spawnpoints
	- 8 new Axis Player-Spawnpoints
	- gametypestring of the server set to "jv_bot01", during the addon is running (Serverlists)
	- the usual The Hunt objective mapscript will be disabled after installing the addon


What큦 needed for the Client (Player)?
--------------------------------------
	The player who큦 connecting to the server needs only the jv_bot01.pk3 file. ;-)
	Please remember all players, or setup the servertitle with this remark.

Start the addon
---------------
	Start your server with the map obj_team1 in objective gametype. 
	If one player join a team, the bots are starting.


The Bridge BOT addon by Cheech
------------------------------
------------------------------
Description
-----------
	This addon adds bot-support to the usual The Bridge objective map, based on jv_map bots version 1.1.


IMPORTANT !!!!!!!!!!!!!!!!
--------------------------
	After installing this addon, the usual The Bridge objective mapscript will be disabled.
	To enable it back to the usual The Bridge objective mapscript uninstall the addon.


What큦 the difference between the usual The Bridge objective map ?
------------------------------------------------------------------
	- BOT Support
	- 11 new Allies Player-Spawnpoints
	- 7 new Axis Player-Spawnpoints
	- gametypestring of the server set to "jv_bot01", during the addon is running (Serverlists)
	- the usual The Bridge objective mapscript will be disabled after installing the addon


What큦 needed for the Client (Player)?
--------------------------------------
	The player who큦 connecting to the server needs only the jv_bot01.pk3 file. ;-)
	Please remember all players, or setup the servertitle with this remark.

Start the addon
---------------
	Start your server with the map obj_team4 in objective gametype. 
	If one player join a team, the bots are starting.


The Crossroads BOT addon by Cheech
----------------------------------
----------------------------------
Description
-----------
	This addon adds bot-support to the usual The Crossroads tdm map, based on jv_map bots version 1.1.


IMPORTANT !!!!!!!!!!!!!!!!
--------------------------
	After installing this addon, the usual The Crossroads tdm mapscript will be disabled.
	To enable it back to the usual The Crossroads tdm mapscript uninstall the addon.


What큦 the difference between the usual The Crossroads tdm map ?
----------------------------------------------------------------
	- BOT Support
	- gametypestring of the server set to "jv_bot01", during the addon is running (Serverlists)
	- the usual The Crossroads tdm mapscript will be disabled after installing the addon


What큦 needed for the Client (Player)?
--------------------------------------
	The player who큦 connecting to the server needs only the jv_bot01.pk3 file. ;-)
	Please remember all players, or setup the servertitle with this remark.


Start the addon
---------------
	Start your server with the map mohdm4 in tdm gametype. 
	If one player join a team, the bots are starting.



(ServerSideFiles)
Copyright 2004 Cheech http://www.steinhuder-meer.ws
BOT-System by jv_map  http://www.planetmedalofhonor.com/freebrief

Tested on the [PoG] Arena Servers www.pog-clan.com



Multiplayer Bot script for MoH:AA obj
=============================================
by jv_map
version 1.1
---------------------------------------------
Copyright (c) 2002-2003 Jeroen Vrijkorte
All rights reserved.
---------------------------------------------
Distribution is allowed provided all subsequent 
conditions are met:

1. Commercial use is prohibited.

2. The above copyright notice and this permission notice shall
be included in all copies or substantial portions of the file.

3. If you have made modifications to the original files you must
cause the modified files to carry prominent notices stating
that you changed the files.

COPYRIGHT HOLDERS WILL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, 
SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF ANY USE OF THE 
SOFTWARE OR DOCUMENTATION.
---------------------------------------------
jv_map@planetmedalofhonor.com
http://www.planetmedal.com/freebrief
---------------------------------------------
This file contains all scripts needed for jv_map's multiplayer 
bots and bot models. This pk3 doesn't overwrite any original files.
It can be used with or without jv_bot0.pk3



