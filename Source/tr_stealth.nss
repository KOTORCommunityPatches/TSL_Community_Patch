////////////////////////////////////////////////////////////////////////////////
/*	KOTOR2 Community Patch
	
	Fired by newgeneric002.utp in 410DXN (Jungle Tomb).
	
	Modified to ignore party puppets such as Bao-Dur's remote, which are unable
	to use stealth. Without this modification, they would always trigger the
	failure state.

	JC 2022-12-10                                                             */
////////////////////////////////////////////////////////////////////////////////
void main() {
	object oEntering = GetEnteringObject();
	
	if( IsStealthed(oEntering) || GetStandardFaction(oEntering) == STANDARD_FACTION_PARTYPUPPET )
		return;
	
	if( !GetLocalBoolean(OBJECT_SELF, 55) ) {
		SetLocalBoolean(OBJECT_SELF, 55, TRUE);
		
		object oSithTrooper;
		
		object oWP = GetWaypointByTag("wp_patrol1");
		oSithTrooper = CreateObject(OBJECT_TYPE_CREATURE, "g_sithtroop004", GetLocation(oWP));
		oWP = GetWaypointByTag("wp_patrol_walk1");
		AssignCommand(oSithTrooper, ActionMoveToObject(oEntering, TRUE, 15.0));
		
		oWP = GetWaypointByTag("wp_patrol2");
		oSithTrooper = CreateObject(OBJECT_TYPE_CREATURE, "g_sithtroop004", GetLocation(oWP));
		oWP = GetWaypointByTag("wp_patrol_walk2");
		AssignCommand(oSithTrooper, ActionMoveToObject(oEntering, TRUE, 15.0));
		
		oWP = GetWaypointByTag("wp_patrol3");
		oSithTrooper = CreateObject(OBJECT_TYPE_CREATURE, "g_sithtroop004", GetLocation(oWP));
		oWP = GetWaypointByTag("wp_patrol_walk3");
		AssignCommand(oSithTrooper, ActionMoveToObject(oEntering, TRUE, 15.0));
		
		AurPostString("Alarm Set Off - stealth is over", 5, 5, 5.0);
		
		SetLocalBoolean(GetObjectByTag("power_gen_backup"), 45, TRUE);
		SetLocalBoolean(GetObjectByTag("power_gen"), 45, TRUE);
		
		SoundObjectPlay(GetObjectByTag("Alarm"));
	}
}