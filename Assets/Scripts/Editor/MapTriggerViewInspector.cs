

using sw.game.model;
using sw.ui.view;
using sw.util;
using UnityEditor;
using UnityEngine;
[CanEditMultipleObjects]
[CustomEditor(typeof(MapTriggerView))]
public   class MapTriggerViewInspector:Editor
 {
    SerializedProperty propTriggerId, propType, propX, propY, propWidth, propHeight, propTriggerType,propTriggerParam,propTargetType, propTargetParam,propEulerangles;
    void OnEnable()
    {
        propTriggerId = serializedObject.FindProperty("data.id");
        propType = serializedObject.FindProperty("data.type");
        propX = serializedObject.FindProperty("data.x");
        propY = serializedObject.FindProperty("data.y");
        propWidth = serializedObject.FindProperty("data.width");
        propHeight = serializedObject.FindProperty("data.height");
        propTriggerType = serializedObject.FindProperty("data.triggerType");
        propTriggerParam = serializedObject.FindProperty("data.triggerParam");
        propTargetType = serializedObject.FindProperty("data.targetType");
        propTargetParam = serializedObject.FindProperty("data.targetParam");
        propEulerangles = serializedObject.FindProperty("data.eulerangles");
    }

    public override void OnInspectorGUI()
    {


        serializedObject.Update();

        EditorGUILayout.PropertyField(propTriggerId, new GUIContent("触发器ID为"));
        EditorGUILayout.PropertyField(propType, new GUIContent("触发器类型"));
        EditorGUILayout.PropertyField(propWidth, new GUIContent("触发器宽度"));
        EditorGUILayout.PropertyField(propHeight, new GUIContent("触发器高度"));
        EditorGUILayout.PropertyField(propType, new GUIContent("传送门类型(0默认1副本下层2退副本)"));
        EditorGUILayout.PropertyField(propTriggerType, new GUIContent("触发类型(1通过碰撞触发2通过打完怪触发)"));
        EditorGUILayout.PropertyField(propTriggerParam, new GUIContent("触发参数"));
        EditorGUILayout.PropertyField(propTargetType, new GUIContent("目标类型(1阻挡门)"));
        //EditorGUILayout.PropertyField(propState, new GUIContent("传送门状态(0闭1开)"));
        EditorGUILayout.PropertyField(propTargetParam, new GUIContent("目标参数(1<阻挡门ID)"));
        
        MapTriggerView view = (MapTriggerView)target;

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
