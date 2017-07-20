//----------------------------------------------
//            NGUI: Next-Gen UI kit
// Copyright © 2011-2014 Tasharen Entertainment
//----------------------------------------------
using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using System.IO;
/// <summary>
/// Inspector class used to edit the BindBody.
/// </summary>
[CustomEditor(typeof(BindBody))]
public class UIBindBodyBtn : Editor
{
	BindBody mBindBodyBtn;
    private static GUIContent playContent = new GUIContent("play", "play the effect");
    private static GUIContent stopContent = new GUIContent("stop", "stop the effect");
	/// <summary>
	/// Draw the inspector widget.
	/// </summary>
	public override void OnInspectorGUI ()
	{
        serializedObject.Update();
        EditorGUILayout.PropertyField(serializedObject.FindProperty("body"),false);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("strBindAniName"),false);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("bSetPlayAwake"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("bPlyAwake"));
        mBindBodyBtn = target as BindBody;
		if (GUILayout.Button(playContent))
        {
			Debug.Log("effect start play now");
            mBindBodyBtn.Play();
        }
        if (GUILayout.Button(stopContent))
        {
            Debug.Log("effect stop play now");
            mBindBodyBtn.Stop();
        }
        serializedObject.ApplyModifiedProperties();
	}
}
