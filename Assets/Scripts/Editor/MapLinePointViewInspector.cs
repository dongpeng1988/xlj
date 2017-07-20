using sw.game.model;
using sw.ui.view;
using sw.util;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
[CanEditMultipleObjects]
[CustomEditor(typeof(MapLinePointView))]
public class MapLinePointViewInspector : Editor
{
    SerializedProperty  propX, propY;
    void OnEnable()
    {

        propX = serializedObject.FindProperty("data.x");
        propY = serializedObject.FindProperty("data.y");

    }
    string[] typeStrs = new string[] { };
    public override void OnInspectorGUI()
    {


        serializedObject.Update();


        MapLinePointView view = (MapLinePointView)target;

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


        }
        EditorGUILayout.LabelField("X:\t" + propX.intValue);
        EditorGUILayout.LabelField("Y:\t" + propY.intValue);
        serializedObject.ApplyModifiedProperties();
    }
    void updateMesh(int width, int height)
    {
        MapLinePointView view = (MapLinePointView)target;
        MeshFilter mf = view.gameObject.GetComponent<MeshFilter>();
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
