#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

/*
File Version: 1.0
Stores the weapon list for Can Binds
Allows for easy creation of new Binds.
*/

doThreads()
{
self thread cansList();
self thread dropWeapon();
self thread doBarrettCan();
self thread doInterCan();
}

cansList() // No Longer serves a purpose. Can be used  for various things just leaving here from old code
{

    level.cansList = [];
    
    level.cansList[1] = "barrett_fmj_mp";
    level.cansList[2] = "cheytac_fmj_mp";

}

dropWeapon() // Drops weapon... Not much else to say
{
    self endon("disconnect");
    self endon("death");
        for(;;)
    {
        self notifyOnPlayerCommand( "dropweap", "+dropweap" );
        self waittill( "dropweap" );
     {
    weapList = self GetWeaponsListAll();
    weapListPrim = self GetWeaponsListPrimaries();

    curr = self getCurrentWeapon();
    self dropItem( curr );
    while(self getCurrentWeapon() == "none") 
    {
        if(weapListPrim.size) 
            self switchToWeapon(weapListPrim[RandomInt(weapListPrim.size)]);
        else 
            self switchToWeapon(weapList[RandomInt(weapList.size)]);
        wait 0.05; 
    }
}
}
}
// Custom Can Binds example
doInterCan()
{
    self endon ("disconnect");

    for(;;)
    {
        self notifyOnPlayerCommand( "inter", "+inter" );
        self waittill( "inter" );
        wait .1;
		self takeAllWeapons();
	    self giveweapon ( self.primaryweapon, self.loadoutPrimaryCamo ); // Grab Current equipped camo + Primary Weapon
        self giveWeapon ( "cheytac_fmj_mp", self.loadoutPrimaryCamo ); // Give secondary Can option. (Do not use 2 Interventions)
		self giveweapon ( "concussion_grenade_mp" ); // Give Stuns
		self giveweapon ( self.loadoutEquipment ); // Replace existing Equipment
        wait 1;
    }
}
