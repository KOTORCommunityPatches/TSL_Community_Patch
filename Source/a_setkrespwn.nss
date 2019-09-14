////////////////////////////////////////////////////////////////////////////////
/*	KOTOR2 Community Patch
	
	Fired by g_tresgencorp004.utp in 101PER (Peragus Administration Level).

	This is the OnClosed script for the corpse placeable that has the plasma
	torch in the Peragus morgue. It fires the cutscene showing Kreia waking up
	and walking towards the player. The scene starts with the initial "dead"
	Kreia placeable, then that is destroyed and a stunt Kreia creature is
	spawned showing the waking up animations, then that is destroyed and the
	party Kreia creature is spawned to begin the conversation. The initial
	swap between the placeable and stunt Kreias is done by this script. In
	the vanilla version, there is no delay on the destroy function, so if the
	camera is faced towards Kreia's body, it will be seen disappearing just
	before the fade to black. A delay has been added so that the swap is now
	properly covered by the fade to black.
	
	Issue #32: 
	https://github.com/KOTORCommunityPatches/TSL_Community_Patch/issues/32

	DP 2019-09-14                                                             */
////////////////////////////////////////////////////////////////////////////////

void KreiaSwap() {
	
	object oPC = GetFirstPC();
	object oKreiaCorpse = GetObjectByTag("kreia_corpse", 0);
	location lBed = GetLocation(GetObjectByTag("WP_KREIA_SPAWN1", 0));
	object oKreiaStunt = CreateObject(OBJECT_TYPE_CREATURE, "p_kreia002", lBed);
	
	DestroyObject(oKreiaCorpse, 0.0, TRUE);
	
	AssignCommand(oPC, ClearAllActions());
	AssignCommand(oKreiaStunt, ClearAllActions());
	
	AssignCommand(oKreiaStunt, ActionStartConversation(oPC, "101kreia"));
}

void main() {
	
	int nGlobal = GetGlobalNumber("101PER_Kreia_Spawn");
	
	if (nGlobal == 0)
		{
			object oPC = GetFirstPC();
			object oKreiaCorpse = GetObjectByTag("kreia_corpse", 0);
			
			SetGlobalFadeOut(0.0, 1.0);
			SetFadeUntilScript();
			
			SetGlobalNumber("101PER_Kreia_Spawn", 2);
			
			DelayCommand(1.0, KreiaSwap());
		}
}
