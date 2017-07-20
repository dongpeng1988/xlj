using sw.game.model;
using sw.ui.view;
using sw.util;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
[CanEditMultipleObjects]
[CustomEditor(typeof(MapZoneView))]
public class MapZoneViewInspector : Editor
{
    SerializedProperty zoneId, propX, propY,propType,propCountryflag,propWidth,propHeight,propZoneIndex,propEulerangles;
    void OnEnable()
    {

        zoneId = serializedObject.FindProperty("data.id");
        propX = serializedObject.FindProperty("data.x");
        propY = serializedObject.FindProperty("data.y");
        propType = serializedObject.FindProperty("data.type");
        propCountryflag = serializedObject.FindProperty("data.countryflag");
        propWidth = serializedObject.FindProperty("data.width");
        propHeight = serializedObject.FindProperty("data.height");
        propZoneIndex = serializedObject.FindProperty("data.zoneindex");
        propEulerangles = serializedObject.FindProperty("data.eulerangles");

    }
    string[] typeStrs = new string[] { };
    public override void OnInspectorGUI()
    {


        serializedObject.Update();
        EditorGUILayout.PropertyField(zoneId, new GUIContent("区域ID"));
        EditorGUILayout.PropertyField(propType, new GUIContent("区域类型"));
        EditorGUILayout.PropertyField(propCountryflag, new GUIContent("阵营标识"));
        int origWidth = propWidth.intValue;
        int origHeight = propHeight.intValue;
        EditorGUILayout.PropertyField(propWidth, new GUIContent("宽")) ;
        EditorGUILayout.PropertyField(propHeight, new GUIContent("高"));
        if (origHeight != propHeight.intValue || origWidth != propWidth.intValue)
        {
            //Debug.Log("width or height changed:" + propWidth.intValue + ",height:" + propHeight.intValue);
            updateMesh(propWidth.intValue,propHeight.intValue);
        }

        MapZoneView view = (MapZoneView)target;
        Quaternion rotat = view.gameObject.transform.localRotation;
        if (view.gameObject.transform.hasChanged)
        {
            Vector3 pos = view.gameObject.transform.localPosition;
            IntPoint logic = PathUtilEdit.Real2Logic(pos);
            if (logic.x != propX.intValue || logic.y != propY.intValue)
            {
                //pos = PathUtilEdit.LogicCenter2Real(logic);
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
        if (propType.intValue == 32)
            EditorGUILayout.PropertyField(propZoneIndex, new GUIContent("区域刷怪次序"));
        serializedObject.ApplyModifiedProperties();
    }
    void updateMesh(int width,int height)
    {
        MapZoneView view = (MapZoneView)target;
       MeshFilter mf =  view.gameObject.GetComponent<MeshFilter>();
       Mesh mesh = mf.sharedMesh;

        float x = PathUtilEdit.Logic2RealLen(width / 2f);
        float z = PathUtilEdit.Logic2RealLen(height / 2f);
        List<Vector3> verts = new List<Vector3>();
        //verts.Add(new Vector3(-x, 0, z));
        //verts.Add(new Vector3(x, 0, z));
        //verts.Add(new Vector3(x, 0, -z));
        //verts.Add(new Vector3(-x, 0, -z));

        verts.Add(new Vector3(0, 0, 0));
        verts.Add(new Vector3(2f * x, 0, 0));
        verts.Add(new Vector3(2f * x, 0, -2f * z));
        verts.Add(new Vector3(0, 0, -2f * z));

        mesh.vertices = verts.ToArray();
    }
}
 