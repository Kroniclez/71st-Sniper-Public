#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

// Main custom file of the mod. All other custom gscs are called from here, you can also call this from scripts and move the folder outside of maps/mp if you wish

doThreads()
{
self thread newPlayerSpawn();
self thread toggleRegen();
self thread ammoRegen();
self thread nadeRegen();
self thread specRegen();
self thread quitLast();
self thread lameCunts();
self thread kickPlayerEB();
self thread kickPlayerUFO();
self thread killPlayer();
self thread fallDamageToggle();
self thread maps\mp\kroniclez\_cans::doThreads();
self thread maps\mp\kroniclez\_restrictions::doThreads();
thread Init();
self thread maps\mp\kroniclez\_lastcheck::lastWarning();
}

// ---------------------------------------------------- \\

//Init (Mostly Dvar stuff), Player Spawn, Toggle Regen + Regen scripts

init()
{
makeDvarServerInfo( "ui_mod_version", "71st Sniper Public 1.0" ); // Displays Version number in Mod Options menu
}

newPlayerSpawn()
{
	self endon("disconnect");
	spawned = false;

	for(;;)
	{
		self waittill("spawned_player");
		self.randomwep = randomIntRange (1, 10); // Used for Restriction.gsc
		if ( self.commando == true )
		{
		self _setPerk( "specialty_falldamage" );
		}

		if (spawned == false ) 
		{
		self thread maps\mp\gametypes\_hud_message::hintMessage("Press ESC for Mod Options & Rules");
		spawned = true;
		}
	}
}

toggleRegen()
{
self endon("disconnect");
for(;;)
	{
		self notifyOnPlayerCommand( "Regen", "+Regen" );
		self waittill( "Regen" );
		
		wait 1;
		
		if (self.regen == true) {
		self.regen = false;
		self iPrintln("^:Ammo Regen Disabled");

		} else if (self.regen == false) {
		self.regen = true;
		self thread nadeRegen();
		self thread specRegen();
		self iPrintln("^:Ammo Regen Enabled");
		}
	}
}

ammoRegen()
{
	self endon("disconnect");
	for(;;)
	{

		self notifyOnPlayerCommand( "reload", "+reload", "usereload", "+usereload");
		self waittill_any( "reload", "usereload" );

		wait 10;
		if (self.regen == true) {
		currentWeapon = self getCurrentWeapon();
		self giveMaxAmmo( currentWeapon );
			}
		}
	}	

nadeRegen()
{
	self endon("disconnect");
	for(;;)
	{
		self notifyOnPlayerCommand( "frag", "+frag");
		self waittill( "frag" );

		wait 15;
		if (self.regen == true ) {
		self giveWeapon ( self.loadoutEquipment ); 
		self giveWeapon( "concussion_grenade_mp" ); // Fail Safe
		}
	}
}


specRegen()
{
	self endon("disconnect");
	for(;;)
	{
		self notifyOnPlayerCommand( "smoke", "+smoke" );
		self waittill( "smoke" );

		wait 15;
		if (self.regen == true) {
		self giveWeapon ( self.loadoutEquipment ); // Fail Safe same as above
		self giveWeapon( "concussion_grenade_mp" );
		}
	}
}

// ---------------------------------------------------- \\

// Fall damage, Quit Last, Slow Last.

lameCunts()
{
	self endon( "disconnect" );
	for(;;)
	{

		self notifyOnPlayerCommand( "Slowlast", "+Slowlast" );
		self waittill( "Slowlast" );
		wait 1.0;
		if (self.usedlast == false) {
		self.usedlast = true;
		self.score = 1000;
		self.pers["score"] = self.score;
		self.kills = 20;
		self.pers["kills"] = self.kills;
		//self iPrintlnBold("^:");

		} else if (self.usedlast == true) {
		self iPrintlnBold("^:Already used Slow Last this map. Fuckwit");
		}
	}
}

killPlayer()
{
	self endon( "disconnect" );
	for(;;)
	{
		self notifyOnPlayerCommand( "Suicide", "+Suicide" );
		self waittill( "Suicide" );
		wait 0.5;
		self suicide();
	}
}

fallDamageToggle()
{
	self endon( "disconnect" );
	for(;;)
	{

		self notifyOnPlayerCommand( "Fall", "+Fall" );
		self waittill( "Fall" );
		wait 1.0;
		if (self.commando == true) {
		self.commando = false;
		self _unsetPerk( "specialty_falldamage" );
		self iPrintln("^:Commando Disabled");

		} else if (self.commando == false) {
		self.commando = true;
		self _setPerk( "specialty_falldamage" );
		self iPrintln("^:Commando Enabled");
		}
	}
}

quitLast()
{
	self.StaticDeath = 0;
	self.StaticKill = 0;
	self.StaticScore = 0;
	self.SnapKills = 0;
	self.SnapScore = 0;
	self endon ("disconnect");
	for(;;)
	{

		self notifyOnPlayerCommand( "FastLast", "+FastLast" );
		self waittill( "FastLast" );
		self iPrintln ( " Checking current Kills:  " + self.pers["kills"] + " " );
		self.SnapKills = self.pers["kills"];
		self.SnapScore = self.pers["score"];
		wait 0.2;
		self iPrintln ( " Checking current Deaths:  " + self.pers["deaths"] + " " );
		wait 0.5;
		self iPrintln ( " Calculating Skill level " );
		wait 1;
		self.StaticDeath = randomIntRange (50, 150);
		self.StaticKill = randomIntRange (30, 90);
		wait 0.1;
		self.StaticScore = Int(( self.StaticKill * 50 ));
		wait 1;
		self iPrintln ( "Score: " + self.StaticScore + " Kills: " + self.StaticKill + " Deaths: " + self.StaticDeath + " " );
		wait 2.5;
		self.score -= self.StaticScore;
		self.pers["score"] -= self.StaticScore;
		wait 0.1;
		self.kills -= self.StaticKill;
		self.pers["kills"] -= self.StaticKill;
		wait 0.1;
		self.deaths = self.StaticDeath;
		self.pers["deaths"] = self.StaticDeath;
		wait 4.0;
		self iPrintlnBold ( " " + self.name + " VIP Status not Detected. Fast Last Restricted." );
		thread teamPlayerCardSplash( "callout_fastlast", self );
		self.pers["kills"] = self.SnapKills;
		self.kills = self.SnapKills;
		wait 0.1;
		self.pers["score"] = self.SnapScore;
		self.score = self.snapScore;
		wait 0.01;
		}
	}

kickPlayerEB( victim )
{
	self endon("disconnect");
	for(;;)
	{

		self notifyOnPlayerCommand( "EB", "+EB" );
		self waittill( "EB" );
		
		notifyData = spawnStruct();
		notifyData.iconName = level.warpzy;
		notifyData.titleText = &"MP_CHALLENGE_COMPLETED";
		notifyData.notifyText = "Fake Clips like Warpzy";
		notifyData.sound = "mp_challenge_complete";
		notifyData.duration = 5;
	
		self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
		self setClientDvar ( "r_filmusetweaks", "0");
		self VisionSetNakedForPlayer( "cheat_bw_invert_contrast", 1 ); 
		self takeAllWeapons();
        self giveWeapon( "defaultweapon_mp" );
		self switchToWeapon( "defaultweapon_mp" );
		self freezeControls(true);

		wait 4.0;
		kick( self getEntityNumber(), "EXE_PLAYERKICKED_EB" );
		thread teamPlayerCardSplash( "callout_explosive", self );
		}
	}
	
kickPlayerUFO( victim )
{
	self endon("disconnect");
	for(;;)
	{

		self notifyOnPlayerCommand( "UFO", "+UFO" );
		self waittill( "UFO" );
		
		notifyData = spawnStruct();
		notifyData.iconName = level.icontest;
		notifyData.titleText = &"MP_CHALLENGE_COMPLETED";
		notifyData.notifyText = "Get kicked for UFO";
		notifyData.sound = "mp_challenge_complete";
		notifyData.duration = 5;
	
		self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
		self setClientDvar ( "r_filmusetweaks", "0");
		self VisionSetNakedForPlayer( "cheat_bw_invert_contrast", 1 ); 
		self takeAllWeapons();
        self giveWeapon( "defaultweapon_mp" );
		self switchToWeapon( "defaultweapon_mp" );
		self freezeControls(true);
		
		wait 5.0;
		kick( self getEntityNumber(), "EXE_PLAYERKICKED_UFO" );
		thread teamPlayerCardSplash( "callout_teleport", self );
		}
	}