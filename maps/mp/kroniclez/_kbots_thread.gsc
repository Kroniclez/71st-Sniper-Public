#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

// Handles Threads for Bots

botStats()
{
self setPlayerData( "prestige", randomIntRange(2, 11) );
self setplayerData( "experience", randomInt(2561000) );
self setPlayerData( "cardIcon", self maps\mp\kroniclez\_kbots_icons::Emblem() );
self setPlayerData( "cardTitle", self maps\mp\kroniclez\_kbots_icons::Title() );
}

botSpawn(team)
{
	self endon( "disconnect" );

	while(!isdefined(self.pers["team"]))
		wait .05;

	self notify("menuresponse", game["menu_team"], team);
	wait 0.5;
	
	while( 1 )
	{
		class = "class" + randomInt( 5 );
		
		self notify("menuresponse", "changeclass", class);
			
		self waittill( "spawned_player" );
		wait ( 0.10 );
	}
}

botKills()
{
    // Generates the Values of Deaths & Kills + Correct Score (kills * 50)
	wait 0.1;
	self.kills = randomIntRange (0, 20);
	self.pers["kills"] = self.kills;
	wait 0.1;
	self.deaths = randomIntRange (4, 18);
	self.pers["deaths"] = self.deaths;
    wait 0.1;
    self.score = Int(( self.kills * 50 ));
	self.pers["score"] = self.score;
}

botReload()
{
	self endon("disconnect");
	for(;;)
	{

		self notifyOnPlayerCommand( "reload", "+reload" );
		self waittill ( "reload" );

		wait 45;
		currentWeapon = self getCurrentWeapon();
		self giveMaxAmmo( currentWeapon );
	}
}

// Removes a bots weapon when reaching 29 Kills.
botRemove()
{
	self endon("disconnect");
	for(;;)
	{
	wait 0.5;
	if (self.pers["score"] == 1450) {
	self takeAllWeapons();
	} 
	else
	{
		}
	wait 1;
	}
}