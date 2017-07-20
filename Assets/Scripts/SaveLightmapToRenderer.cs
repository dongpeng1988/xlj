using UnityEngine;
using System.Collections.Generic;
using System;

#if UNITY_EDITOR
using UnityEditor;
#endif

//In Unity5, lightmap info is not saved to prefab per renderer.
//When instantiating from a prefab, renderers lost lightmap infos.
//This script saves lightmap info to prefab, and applies to renderer at runtime.
//By liuyao.

public class SaveLightmapToRenderer : MonoBehaviour
{
    [Serializable]
    public struct LightmapInfo
    {
        public Renderer renderer;
        public Terrain terrain;
        public int lightmapIndex;
        public Vector4 offsetScale;
    }

    public List<LightmapInfo> lmList = new List<LightmapInfo>();

    void Awake()
    {
        Debug.Break();
        ApplyLightMapToRenderers();
    }

    private void ApplyLightMapToRenderers()
    {
        for (int i = 0; i < lmList.Count; i++)
        {
            if (lmList[i].renderer != null)
            {
                lmList[i].renderer.lightmapIndex = lmList[i].lightmapIndex;
                lmList[i].renderer.lightmapScaleOffset = lmList[i].offsetScale;
            }
            else
            {
                lmList[i].terrain.lightmapIndex = lmList[i].lightmapIndex;
            }
        }
    }
}

#if UNITY_EDITOR
[ExecuteInEditMode]
[CustomEditor(typeof(SaveLightmapToRenderer))]
public class StarInspector : Editor
{
    private SaveLightmapToRenderer Target
    {
        get { return target as SaveLightmapToRenderer; }
    }

    public override void OnInspectorGUI()
    {
        for (int i = 0; i < Target.lmList.Count; i++)
        {
            EditorGUILayout.BeginHorizontal();

            if (Target.lmList[i].renderer != null)
            {

                EditorGUILayout.TextField("Renderer: " + Target.lmList[i].renderer.name);
            }
            else if (Target.lmList[i].terrain != null)
            {
                EditorGUILayout.TextField("Terrain: " + Target.lmList[i].terrain.name);
            }

            EditorGUILayout.TextField("LightMapIdx: " + Target.lmList[i].lightmapIndex.ToString());
            EditorGUILayout.Vector4Field("Scale: ", Target.lmList[i].offsetScale);
            EditorGUILayout.EndHorizontal();
        }
        DrawButton();
    }

    private void DrawButton()
    {
        GUILayout.BeginHorizontal();
        bool isSave = GUILayout.Button("Save light map", GUILayout.Width(100f));
        if (isSave)
        {
            SaveLmInfo();
        }
    }


    public void SaveLmInfo()
    {
        Target.lmList.Clear();
        Renderer[] renders = Target.gameObject.GetComponentsInChildren<Renderer>();
        for (int i = 0; i < renders.Length; i++)
        {
            SaveLightmapToRenderer.LightmapInfo info = new SaveLightmapToRenderer.LightmapInfo();
            info.renderer = renders[i];
            info.lightmapIndex = renders[i].lightmapIndex;
            info.offsetScale = renders[i].lightmapScaleOffset;
            Target.lmList.Add(info);
        }

        Terrain[] terrains = Target.gameObject.GetComponentsInChildren<Terrain>();

        for (int i = 0; i < terrains.Length; i++)
        {
            SaveLightmapToRenderer.LightmapInfo info = new SaveLightmapToRenderer.LightmapInfo();
            info.terrain = terrains[i];
            info.lightmapIndex = terrains[i].lightmapIndex;
            Target.lmList.Add(info);
        }
    }
}
#endif
