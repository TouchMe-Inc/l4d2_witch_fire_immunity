#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdkhooks>
#include <sdktools>


public Plugin myinfo =
{
    name        = "WitchFireImmunity",
    author      = "TouchMe",
    description = "Witch is immune to fire",
    version     = "build_0001",
    url         = "https://github.com/TouchMe-Inc/l4d2_witch_fire_immunity"
};


/**
 * @brief Checks if the entity is a witch.
 *
 * @param sClassName Class name of the entity.
 * @return True if the entity is a witch, false otherwise.
 */
bool IsWitch(const char[] sClassName) {
    return StrEqual(sClassName, "witch");
}

/**
 * @brief Called when an entity is created.
 *
 * @param iEntityIndex Index of the created entity.
 * @param sClassName Class name of the created entity.
 */
public void OnEntityCreated(int iEntityIndex, const char[] sClassName)
{
    if (iEntityIndex > MaxClients && IsValidEntity(iEntityIndex) && IsWitch(sClassName))
    {
        SDKHook(iEntityIndex, SDKHook_OnTakeDamage, OnWitchTakeDamage);
    }
}

/**
 * @brief Called when the witch takes damage.
 *
 * @param iVictimIndex Index of the victim entity.
 * @param iAttackerIndex Index of the attacker entity.
 * @param iInflictorIndex Index of the inflictor entity.
 * @param fDamageAmount Amount of damage.
 * @param iDamageType Type of damage.
 * @return Action to handle the damage.
 */
Action OnWitchTakeDamage(int iVictimIndex, int &iAttackerIndex, int &iInflictorIndex, float &fDamageAmount, int &iDamageType)
{
    if (iDamageType & DMG_BURN) {
        return Plugin_Handled;
    }

    return Plugin_Continue;
}
