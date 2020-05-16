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

cansList() // No Longer serves much of a purpose but I'm lazy.
{

    level.cansList = [];
    
    level.cansList[1] = "barrett_fmj_mp";
    level.cansList[2] = "cheytac_fmj_mp";

}

dropWeapon()
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

doBarrettCan()
{
    self endon ("disconnect");

    for(;;)
    {
        self notifyOnPlayerCommand( "barrett", "+barrett" );
        self waittill( "barrett" );
        wait .1;
		self takeAllWeapons();
	    self giveweapon ( self.primaryweapon, self.loadoutPrimaryCamo );
        self giveWeapon ( level.cansList[1], self.loadoutPrimaryCamo ); 
		self giveweapon ( "concussion_grenade_mp" );
		self giveweapon ( self.loadoutEquipment );
        wait 1;
    }
}

doInterCan()
{
    self endon ("disconnect");

    for(;;)
    {
        self notifyOnPlayerCommand( "inter", "+inter" );
        self waittill( "inter" );
        wait .1;
		self takeAllWeapons();
	    self giveweapon ( self.primaryweapon, self.loadoutPrimaryCamo );
        self giveWeapon ( level.cansList[2], self.loadoutPrimaryCamo ); 
		self giveweapon ( "concussion_grenade_mp" );
		self giveweapon ( self.loadoutEquipment );
        wait 1;
    }
}
