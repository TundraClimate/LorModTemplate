/* using System;
using HarmonyLib; */

public class __MODNAME__ : ModInitializer
{
    public static string packageId
    {
        get
        {
            return "__MODNAME__";
        }
    }

    public override void OnInitializeMod()
    {
    }

    /* public static void ApplyHarmonyPatch()
    {
        Harmony harmony = new Harmony(__MODNAME__.packageId);
        foreach (Type type in typeof(PatchClass).GetNestedTypes(AccessTools.all))
        {
            harmony.CreateClassProcessor(type).Patch();
        }
    } */
}
