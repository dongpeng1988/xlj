using UnityEngine;
using UnityEditor;
using System.Collections;
using System;

//[CustomEditor(typeof(ModelLod))]

public class ModelLodEditor : Editor {

    //public ModelLod castedTarget; 
 
	public void Awake()
	{
        //castedTarget = (ModelLod) target;

	} 
	public override void OnInspectorGUI() {
		
		base.OnInspectorGUI();
        //string v = EditorGUILayout.TextField("lod level", castedTarget.mCurLod.ToString());
        //castedTarget.mCurLod = tcom.tools.TEngine.GetIntFromString(v);
	}
}
