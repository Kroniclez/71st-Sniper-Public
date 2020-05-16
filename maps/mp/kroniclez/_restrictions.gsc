#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

/*
File version: 3.1
Cleaned layout
Support for IW4X Weapons
Silencers Added
Fixed Bomb Planting
Fal Added
*/

doThreads()
{
	self thread doWeapons();
	self thread falCheck();
	self thread weaponsList();

}
// Stores weapon list for spawn weapon if using a restricted weapon
// Can be removed if you wish for a simple static weapon.
weaponsList()
{

    level.weaponsList = [];
    
    level.weaponsList[1] = "cheytac_mp";
    level.weaponsList[2] = "cheytac_fmj_mp";
    level.weaponsList[3] = "cheytac_xmags_mp";
    level.weaponsList[4] = "cheytac_acog_mp";
    level.weaponsList[5] = "m40a3_mp";
    level.weaponsList[6] = "dragunov_mp";
    level.weaponsList[7] = "cheytac_fmj_xmags_mp";
    level.weaponsList[8] = "barrett_fmj_mp";
    level.weaponsList[9] = "cheytac_heartbeat_mp";
    level.weaponsList[10] = "barrett_mp";

}


falCheck() // Quick Example of allowing certain snipers/weapons to be used at last for trickshotting. (Again can be replaced with a DM score - 50 if you use a lower limit)
{
	self endon ("disconnect");
	for (;;)
	{
	currentweapon2 = self getCurrentWeapon();
	if (isSubStr(currentweapon2, "m21_") || isSubStr(currentweapon2, "fal_") || isSubStr(currentweapon2, "WA2000_") && self.pers["kills"] < 29 ) {
	self takeWeapon( currentWeapon2 );
	self giveWeapon( level.weaponsList[self.randomwep], self.loadoutPrimaryCamo );
	self switchToWeapon( level.weaponsList[self.randomwep] );
	} 
	else 
	{
		}
	wait 1;
	}
}

/*
The following covers allowing access to certain weapons, and removing access to the rest. Can be used in two different ways, using a isSubStr to grab all varations of a gun
or used as a simple current weapon check allowing control over certain attachements
Credits to Boots for this age old gsc
*/
doWeapons()
{
	for(;;)
	{
		currentWeapon = self getCurrentWeapon();
		
		//Snipers
		
		if ( isSubStr( currentWeapon, "m40a3_" ) 
		|| isSubStr( currentWeapon, "cheytac_" )
		|| isSubStr( currentWeapon, "m21_" )
		|| isSubStr( currentWeapon, "barrett_" )
		|| isSubStr( currentWeapon, "WA2000_" )
		|| isSubStr( currentWeapon, "dragunov_" )
 
		// Pistols
		
		 || isSubStr( currentWeapon, "baretta_" )
		 || isSubStr( currentWeapon, "coldanaconda_" )
		 || isSubStr( currentWeapon, "usp_" )
		 || isSubStr( currentWeapon, "deserteagle_" )
		 || isSubStr( currentWeapon, "deserteaglegold_" )
		 
		// Machine Pistols
		
		 || isSubStr( currentWeapon, "glock_" ) 
		 || isSubStr( currentWeapon, "baretta393_" )
		 || isSubStr( currentWeapon, "tmp_" )
		 || isSubStr( currentWeapon, "pp2000_" )
		 
		// Shotguns
		
		 || isSubStr( currentWeapon, "ranger_" )
		 || isSubStr( currentWeapon, "model1887_" )
		 || isSubStr( currentWeapon, "striker_" )
		 || isSubStr( currentWeapon, "aa12_" )
		 || isSubStr( currentWeapon, "m1014_" )
		 || isSubStr( currentWeapon, "spas12_" ) 
		 
		// Launchers
		
		 || isSubStr( currentWeapon, "m79_mp" )
		 || isSubStr( currentWeapon, "rpg_mp" )
		 || isSubStr( currentWeapon, "at4_mp" )
		 || isSubStr( currentWeapon, "stinger_mp" )
		 || isSubStr( currentWeapon, "javelin_mp" )
		 
		// Killstreaks

		 || isSubStr( currentWeapon, "killstreak_" )
		 || isSubStr( currentWeapon, "airdrop_" )
		 || isSubStr( currentWeapon, "ac130_" )
		 || isSubStr( currentWeapon, "helicopter_" )
		 || isSubStr( currentWeapon, "heli_" )
		 
		// Perks

		 || isSubStr( currentWeapon, "onemanarmy_mp" )
		 
		// Bomb Planting

		 || isSubStr( currentWeapon, "mp_bomb_plant" )
		 || isSubStr( currentWeapon, "mp_bomb_defuse" )
		 || isSubStr( currentWeapon, "briefcase_bomb_mp" )
		 || isSubStr( currentWeapon, "briefcase_bomb_defuse_mp" )
		 
		// Assault Rifles

		 || isSubStr( currentWeapon, "tavor_" )
		 || isSubStr( currentWeapon, "ak47_" )
		 || isSubStr( currentWeapon, "kriss_" )
		 || isSubStr( currentWeapon, "masada_" )
		 || isSubStr( currentWeapon, "scar_" )
		 || isSubStr( currentWeapon, "m4_" )
		 || isSubStr( currentWeapon, "m16_" )
		 || isSubStr( currentWeapon, "fal_" )
		 || isSubStr( currentWeapon, "defaultweapon_mp" )
		
		// Other shit

		 || isSubStr( currentWeapon, "none" ) ) {

		} else {
			self takeWeapon( currentWeapon );
			self giveWeapon( level.weaponsList[self.randomwep], self.loadoutPrimaryCamo ); // If you wish to use a static weapon. self giveWeapon ( "cheytac_fmj_mp", self.loadoutPrimaryCamo );
			self switchToWeapon( level.weaponsList[self.randomwep] ); // self switchToWeapon ( "cheytac_fmj_mp", self.loadoutPrimaryCamo );
			wait 1;
		}
		wait 1;
	}
}