

using NetUtilityLib;
using sw.game.model;
using sw.ui.model;
using sw.util;
using System.Data;
using UnityEditor;
using UnityEngine;
[CanEditMultipleObjects]
[CustomEditor(typeof(MapNpcView))]
public class MapNpcViewInspector : Editor
{
    SerializedProperty propModelId ;

    SerializedProperty npcId;
    SerializedProperty npcName;
    SerializedProperty propX, propY, propLevel, propAi;
    SerializedProperty propScope, propChase, propNum, propInterval, propWidth, propHeight,propDirection;
    Object curPrefab=null;
    static DataRow[] aiRows;
   static  string[] aiLabels;
    void OnEnable()
    {
        propModelId = serializedObject.FindProperty("data.modelId");
        npcId = serializedObject.FindProperty("data.id");
        npcName = serializedObject.FindProperty("data.npcName");
        propX = serializedObject.FindProperty("data.x");
        propY = serializedObject.FindProperty("data.y");
        propLevel = serializedObject.FindProperty("data.level");
        propAi = serializedObject.FindProperty("data.ai");
        propScope = serializedObject.FindProperty("data.scope");
        propChase = serializedObject.FindProperty("data.chase");
        propNum = serializedObject.FindProperty("data.num");
        propInterval = serializedObject.FindProperty("data.interval");
        propWidth = serializedObject.FindProperty("data.width");
        propHeight = serializedObject.FindProperty("data.height");
        propDirection = serializedObject.FindProperty("data.direction");
        //propModelId.displayName = "模型ID";
       
    }
 
    int curSelAi;
    void readAiData()
    {
        DataTable dt =   ExcelHelper.ExcelToDataTable(EditorConfig.ExcelDataDir+"119_npc策略表.xlsx", "策略表");

        if (dt != null)
        {
            aiRows = dt.Select();
            aiLabels = new string[aiRows.Length];
            for (int i = 0; i < aiRows.Length; i++)
            {
                aiLabels[i] = aiRows[i]["id"].ToString() + "," + aiRows[i]["name"].ToString();
                if(propAi.intValue.ToString() == aiRows[i]["id"].ToString())
                {
                    curSelAi = i;
                }
            }

        }
    }
    public override void OnInspectorGUI()
    {
         

        serializedObject.Update();
        int origid = npcId.intValue;
        EditorGUILayout.PropertyField(npcId, new GUIContent("Npc ID"));
        if(origid != npcId.intValue)
        {

            if (!changeNpc(npcId.intValue))
                npcId.intValue = origid;
        }
        EditorGUILayout.PropertyField(propLevel, new GUIContent("等级"));
        if(aiLabels == null)
        {
            readAiData();
        }
        if(aiLabels != null)
        {
           curSelAi =  EditorGUILayout.Popup("AI类型:",curSelAi, aiLabels);
           propAi.intValue = int.Parse(aiRows[curSelAi]["id"].ToString());
        }
        
      //  EditorGUILayout.PrefixLabel("模型ID:");
        MapNpcView view = (MapNpcView)target;
        //string info = "";
        //info += "模型ID:" + propModelId.stringValue + "\n";
        //info += "名字:" + view.data.npcName + "\n";
        

        //info +="x:"+logic.x+",y:"+logic.y+"\n";
        EditorGUILayout.LabelField("模型ID:\t"+propModelId.stringValue);
        EditorGUILayout.LabelField("名字:\t" + view.data.npcName);
      
        if(view.gameObject.transform.hasChanged)
        {
            Vector3 pos = view.gameObject.transform.localPosition;
            IntPoint logic = PathUtilEdit.Real2Logic(pos);
            Quaternion rotat = view.gameObject.transform.localRotation;
            if(logic.x != propX.intValue || logic.y != propY.intValue)
            {
                //Debug.Log("npc pos changed:" + logic.x + " != " + propX.intValue + "," + logic.y+" != "+propY.intValue);
                if (EditorData.terrainMan != null)
                {
                    pos.y = EditorData.terrainMan.GetHeight(pos.x, pos.z);
                    view.gameObject.transform.localPosition = pos;
                }
            }
            propX.intValue = logic.x;
            propY.intValue = logic.y;
            propDirection.intValue = (int)(rotat.eulerAngles.y / 360 * 2 * Mathf.PI * 1000);
        }
        EditorGUILayout.PropertyField(propHeight, new GUIContent("出生范围 宽度"));

        EditorGUILayout.LabelField("X:\t" + propX.intValue);
        EditorGUILayout.LabelField("Y:\t" + propY.intValue);
        EditorGUILayout.LabelField("朝向direction:\t" + propDirection.intValue);
        EditorGUILayout.PropertyField(propScope, new GUIContent("活动范围"));
        EditorGUILayout.PropertyField(propChase, new GUIContent("追击范围"));
        EditorGUILayout.PropertyField(propNum, new GUIContent("数目"));
        EditorGUILayout.PropertyField(propInterval, new GUIContent("重生间隔"));
        EditorGUILayout.PropertyField(propWidth, new GUIContent("出生范围 长度"));
        EditorGUILayout.PropertyField(propHeight, new GUIContent("出生范围 宽度"));
        

        //EditorGUILayout.HelpBox("test", MessageType.Info);
        //Debug.Log("npc name:" + view.data.npcName+",hash:"+view.data.GetHashCode());
        //string curModelId = propModelId.stringValue;
       // EditorGUILayout.PropertyField(propModelId, new GUIContent("模型ID"));
       // if (curModelId != propModelId.stringValue)
       // {
       //     Debug.Log("prop changed:" + propModelId.stringValue);
       //     changeModel(propModelId.stringValue,curModelId);
       // }
       // EditorGUILayout.PrefixLabel("模型:");
       //Object prefab =  EditorGUILayout.ObjectField(curPrefab, typeof(GameObject));
       //if (curPrefab != prefab)
       //{
       //    Debug.Log("add new prefab:" + curPrefab);
       //    curPrefab = prefab;
       //    changePrefab(curPrefab);
       //}
       

        serializedObject.ApplyModifiedProperties();
    }
    bool changeNpc(int id)
    {
        DataRow npc = EditorTool.getNpc(id);
        if(npc == null)
        {
            Debug.LogError("npc 未找到:" + id);
            return false;
        }
        string resid = npc["modelId"].ToString();
        if(changeModel(resid))
        {
            MapNpcView m = (MapNpcView)target;
            npcName.stringValue   = npc["name"].ToString();
            propModelId.stringValue = resid;
            //Debug.Log("change model:" + resid + ",hash:" + m.data.GetHashCode());
            Repaint();
            return true;
        }
        return false;
    }
    void changePrefab(Object prefab)
    {
        MapNpcView m = (MapNpcView)target;
        GameObject go = m.gameObject;
        if(go.transform.childCount>0)
        {
            GameObject child = go.transform.GetChild(0).gameObject;
            GameObject.DestroyImmediate(child);
        }

        GameObject newchild = (GameObject)GameObject.Instantiate(prefab);
        newchild.transform.SetParent(go.transform);
        newchild.transform.localPosition = Vector3.zero;
        string path =  AssetDatabase.GetAssetPath(prefab);
        Debug.Log("path:" + path);
        AssetImporter im = AssetImporter.GetAtPath(path);
        string ab = im.assetBundleName;
        ab = ab.Substring(ab.LastIndexOf("/") + 1);
        ab = ab.Substring(0, ab.LastIndexOf("."));
        propModelId.stringValue = ab;
        Debug.Log("new ab name:" + ab);
        Repaint();

    }
    bool changeModel(string modelId)
    {
        MapNpcView m = (MapNpcView)target;
        GameObject go = m.gameObject;
        Debug.Log("target name:" + target.name);
        GameObject child = go.transform.GetChild(0).gameObject;
        
        string abName ="model/"+modelId+".unity3d";
        Debug.Log("new asset name:" + abName);
        Object newprefab =  EditorTool.LoadAssetBundle(abName);
        if (newprefab == null)
        {
            Debug.LogError("资源不存在:" + modelId);
            return false;
        }
        else
        {
            GameObject.DestroyImmediate(child);
            GameObject newchild = (GameObject)GameObject.Instantiate(newprefab);
            newchild.transform.SetParent(go.transform);
            newchild.transform.localPosition = Vector3.zero;
            m.data.modelId = modelId;
            return true;
        }
    }
}
