using sw.game.model;
using sw.ui.view;
using sw.util;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
[CanEditMultipleObjects]
[CustomEditor(typeof(MapEffectPointView))]
public class MapEffectPointViewInspector : Editor
{
    SerializedProperty effectId, propX, propY,propType,propWidth,propHeight,propEulerangles,propRes;
    void OnEnable()
    {

        effectId = serializedObject.FindProperty("data.id");
        propX = serializedObject.FindProperty("data.x");
        propY = serializedObject.FindProperty("data.y");
        propType = serializedObject.FindProperty("data.type");
        propWidth = serializedObject.FindProperty("data.width");
        propHeight = serializedObject.FindProperty("data.height");
        propEulerangles = serializedObject.FindProperty("data.eulerangles");
        propRes = serializedObject.FindProperty("data.res");

    }
    string[] typeStrs = new string[] { };
    public override void OnInspectorGUI()
    {


        serializedObject.Update();
        EditorGUILayout.PropertyField(effectId, new GUIContent("特效ID"));
        EditorGUILayout.PropertyField(propType, new GUIContent("特效类型"));
        EditorGUILayout.PropertyField(propRes, new GUIContent("资源名"));
        int origWidth = propWidth.intValue;
        int origHeight = propHeight.intValue;
        EditorGUILayout.PropertyField(propWidth, new GUIContent("宽")) ;
        EditorGUILayout.PropertyField(propHeight, new GUIContent("高"));
        if (origHeight != propWidth.intValue || origWidth != propHeight.intValue)
        {
            //Debug.Log("width or height changed:" + propWidth.intValue + ",height:" + propHeight.intValue);
            updateMesh(propWidth.intValue,propHeight.intValue);
        }

        MapEffectPointView view = (MapEffectPointView)target;
        Quaternion rotat = view.gameObject.transform.localRotation;
        if (view.gameObject.transform.hasChanged)
        {
            Vector3 pos = view.gameObject.transform.localPosition;
            IntPoint logic = PathUtilEdit.Real2Logic(pos);
            if (logic.x != propX.intValue || logic.y != propY.intValue)
            {
                pos = PathUtilEdit.LogicCenter2Real(logic);
                //Debug.Log("npc pos changed:" + logic.x + " != " + propX.intValue + "," + logic.y+" != "+propY.intValue);
                if (EditorData.terrainMan != null)
                {
                    pos.y = EditorData.terrainMan.GetHeight(pos.x, pos.z);
                    view.gameObject.transform.localPosition = pos;
                }
                

            }
            propX.intValue = logic.x;
            propY.intValue = logic.y;
            propEulerangles.stringValue = rotat.eulerAngles.x.ToString() + "," + rotat.eulerAngles.y.ToString() + "," + rotat.eulerAngles.z.ToString();

        }
        EditorGUILayout.LabelField("X:\t" + propX.intValue);
        EditorGUILayout.LabelField("Y:\t" + propY.intValue);

        serializedObject.ApplyModifiedProperties();
    }
    void updateMesh(int width,int height)
    {
        MapEffectPointView view = (MapEffectPointView)target;
       MeshFilter mf =  view.gameObject.GetComponent<MeshFilter>();
       Mesh mesh = mf.sharedMesh;

        float x = PathUtilEdit.Logic2RealLen(width / 2f);
        float z = PathUtilEdit.Logic2RealLen(height / 2f);
        List<Vector3> verts = new List<Vector3>();
        verts.Add(new Vector3(-x, 0, z));
        verts.Add(new Vector3(x, 0, z));
        verts.Add(new Vector3(x, 0, -z));
        verts.Add(new Vector3(-x, 0, -z));

        mesh.vertices = verts.ToArray();
    }
}
 