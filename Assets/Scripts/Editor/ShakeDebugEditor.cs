using UnityEngine;
using UnityEditor;
using System.Collections;

[CustomEditor(typeof(ShakeDebug))]
public class ShakeDebugEditor : Editor{

    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();
        if(GUILayout.Button(new GUIContent("插入数据")))
        {
            EditorWindow.GetWindow(typeof(InputAnim));
        }

    }
}
