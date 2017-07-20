

using sw.game.model;
using sw.ui.view;
using sw.util;
using UnityEditor;
using UnityEngine;
[CanEditMultipleObjects]
[CustomEditor(typeof(MapDoorView))]
public   class MapDoorViewInspector:Editor
 {
    SerializedProperty propId, propType, propX, propY, propWidth, propHeight, propState, propRes,propEulerangles;
    void OnEnable()
    {
        propId = serializedObject.FindProperty("data.id");
        propType = serializedObject.FindProperty("data.type");
        propX = serializedObject.FindProperty("data.x");
        propY = serializedObject.FindProperty("data.y");
        propWidth = serializedObject.FindProperty("data.width");
        propHeight = serializedObject.FindProperty("data.height");
        propState = serializedObject.FindProperty("data.state");
        propRes = serializedObject.FindProperty("data.res");
        propEulerangles = serializedObject.FindProperty("data.eulerangles");
    }

    public override void OnInspectorGUI()
    {


        serializedObject.Update();

        EditorGUILayout.PropertyField(propId, new GUIContent("阻挡门 ID"));
        EditorGUILayout.PropertyField(propType, new GUIContent("门类型"));
        EditorGUILayout.PropertyField(propWidth, new GUIContent("门宽度"));
        EditorGUILayout.PropertyField(propHeight, new GUIContent("门高度"));
        //EditorGUILayout.PropertyField(propState, new GUIContent("传送门状态(0闭1开)"));
        EditorGUILayout.PropertyField(propState, new GUIContent("门初始状态(0关1开)"));
        MapDoorView view = (MapDoorView)target;

        if (view.gameObject.transform.hasChanged)
        {
            Vector3 pos = view.gameObject.transform.localPosition;
            IntPoint logic = PathUtilEdit.Real2Logic(pos);
            Quaternion rotat = view.gameObject.transform.localRotation;
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
 }
