/*
Last Check
Can be also be used to add a GUID based check to remove warning
*/

// Last Warning on Kill Limit. Currently Manual.
// If you wish to make it auto, grab DM scorelimit & divide by 50
lastWarning()
{
	self endon ("disconnect");
	for(;;)
	{
		if (self.pers["kills"] == 29 && self.retard == true) {
		wait 0.1;
		self iPrintlnBold("^: YOU ARE ON LAST. TRICKSHOT OR BE KICKED.");
		break;
		wait 0.1;
		}
		wait 0.01;
	}
}