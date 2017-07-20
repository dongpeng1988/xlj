

using sw.game.model;
using sw.ui.view;
using sw.util;
using UnityEditor;
using UnityEngine;
[CanEditMultipleObjects]
[CustomEditor(typeof(MapWarpView))]
public   class MapWarpViewInspector:Editor
 {
    SerializedProperty propX, propY, propWarpName, propDestMapId,propDestX,propDestY,propType,propState,warpType,propOpenCondition;
    void OnEnable()
    {
        propX = serializedObject.FindProperty("data.warpX");
        propY = serializedObject.FindProperty("data.warpY");
        propWarpName = serializedObject.FindProperty("data.warpName");
        propDestMapId = serializedObject.FindProperty("data.destMapId");
        propWarpName = serializedObject.FindProperty("data.warpName");
        propDestX = serializedObject.FindProperty("data.destMapX");
        propDestY = serializedObject.FindProperty("data.destMapY");
        propType = serializedObject.FindProperty("data.type");
        propState = serializedObject.FindProperty("data.state");
        warpType = serializedObject.FindProperty("data.warpType");
        propOpenCondition = serializedObject.FindProperty("data.openCondition");
    }

    public override void OnInspectorGUI()
    {


        serializedObject.Update();

        EditorGUILayout.PropertyField(propWarpName, new GUIContent("传送点名称"));
        EditorGUILayout.PropertyField(propDestMapId, new GUIContent("目标地图id"));
        EditorGUILayout.PropertyField(propDestX, new GUIContent("目标地图X"));
        EditorGUILayout.PropertyField(propDestY, new GUIContent("目标地图Y"));
        EditorGUILayout.PropertyField(propType, new GUIContent("传送门类型(0默认1副本下层2退副本)"));
        EditorGUILayout.PropertyField(propState, new GUIContent("传送门状态(0闭1开)"));
        //EditorGUILayout.PropertyField(propState, new GUIContent("传送门状态(0闭1开)"));
        EditorGUILayout.PropertyField(warpType, new GUIContent("传送方式(0默认1跳跃)"));
        EditorGUILayout.PropertyField(propOpenCondition, new GUIContent("开启条件(原先是1的别改成0)"));
        MapWarpView view = (MapWarpView)target;

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
 }
