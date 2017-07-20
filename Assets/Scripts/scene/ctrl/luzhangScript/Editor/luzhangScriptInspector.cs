using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(luzhangScript))]
public class luzhangScriptInspector : Editor
{
    public override void OnInspectorGUI()
    {
        base.DrawDefaultInspector();

        luzhangScript luzhangScript = target as luzhangScript;

        GUILayout.BeginVertical();

        luzhangScript.startwidth = EditorGUILayout.IntField("width", luzhangScript.startwidth);
        luzhangScript.width = luzhangScript.startwidth;

        if (GUILayout.Button("GetAllParticleScript"))
        {
            luzhangScript.GetAllParticleScript();
        }
        GUILayout.EndVertical();
    }
}
