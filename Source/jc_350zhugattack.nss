void main() {

int iFaction = STANDARD_FACTION_HOSTILE_1;
string sTag = "Azanti";
object oAtton = GetObjectByTag("atton", 0);
object oCreature = GetNearestObjectByTag(sTag, oAtton, 1);

ChangeToStandardFaction(oCreature, iFaction);

int i = 1;

for(;;) {
    i++;
    object oCreature1 = GetNearestObjectByTag(sTag, OBJECT_SELF, i);
    if( GetIsObjectValid(oCreature1) ){
        ChangeToStandardFaction(oCreature1, iFaction);
         }
    else break;
    }

}