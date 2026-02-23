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
        /*
        ApplyHarmonyPatch();
        */
    }

    /* 
    public static void ApplyHarmonyPatch()
    {
        Harmony harmony = new Harmony(__MODNAME__.packageId);
        foreach (Type type in typeof(PatchClass).GetNestedTypes(AccessTools.all))
        {
            harmony.CreateClassProcessor(type).Patch();
        }
    }

    private static void MutePatch()
    {
        Harmony harmony = new Harmony(__MODNAME__.packageId + ".MutePatch");

        MethodInfo postfix = typeof(__MODNAME__).GetMethod("MuteSameAssembly", BindingFlags.Static | BindingFlags.NonPublic);

        harmony.Patch(typeof(Mod.ModContentManager).GetMethod("GetErrorLogs"), postfix: new HarmonyMethod(postfix));
    }

    private static void MuteSameAssembly(ref List<string> __result)
    {
        List<string> bin = new List<string>();

        foreach (string err in __result)
        {
            if (err.Contains("The same assembly name already exists."))
            {
                bin.Add(err);
            }
        }

        foreach (string trash in bin)
        {
            __result.Remove(trash);
        }
    }
    */
}
