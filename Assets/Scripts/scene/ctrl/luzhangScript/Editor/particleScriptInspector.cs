using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(particleScript))]
public class particleScriptInspector : Editor
{
    public override void OnInspectorGUI()
    {
        base.DrawDefaultInspector();

        particleScript particleScript = target as particleScript;

        particleScript.startwidth = EditorGUILayout.IntField("width", particleScript.startwidth);
        particleScript.width = particleScript.startwidth;
    }
}
