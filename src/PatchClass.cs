using System.Collections.Generic;
using HarmonyLib;

public static class PatchClass
{
    [HarmonyPatch(typeof(Mod.ModContentManager), "GetErrorLogs")]
    static class MutePatch
    {
        static void Postfix(ref List<string> __result)
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
    }
}
