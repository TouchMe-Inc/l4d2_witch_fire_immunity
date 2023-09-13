#pragma semicolon              1
#pragma newdecls               required

#include <sourcemod>
#include <sdkhooks>
#include <sdktools>

public Plugin myinfo =
{
	name = "WitchFireImmunity",
	author = "TouchMe",
	description = "Witch is immune to fire",
	version = "build_0000",
	url = "https://github.com/TouchMe-Inc/l4d2_witch_fire_immunity"
};

public void OnEntityCreated(int iEnt, const char[] sClassName)
{
	if (iEnt > MaxClients && IsValidEntity(iEnt) && StrEqual(sClassName, "witch")) {
		SDKHook(iEnt, SDKHook_OnTakeDamage, OnTakePropDamage);
	}
}

Action OnTakePropDamage(int iVictim, int &iAttacker, int &iInflictor, float &fDamage, int &iDamageType)
{
	if (iDamageType & DMG_BURN) {
		return Plugin_Handled;
	}

	return Plugin_Continue;
}
