


using NetUtilityLib;
using System;
using System.Data;
using UnityEditor;
using UnityEngine;
public class OpenMapWindow:EditorWindow
{
    DataTable mapData;
    Rect windowRect = new Rect(100, 100, 200, 200);
    Vector3 scrollPos = Vector2.zero;
    public Action<DataRow> onOpenMap;
    void OnGUI()
    {
        if (mapData == null)
        {
 
            mapData = ExcelHelper.ExcelToDataTable(EditorConfig.ExcelDataDir + "002_地图配置表.xls", "Sheet1");
            
        }
        if(mapData != null)
        {
            scrollPos = GUILayout.BeginScrollView(
            scrollPos);
            EditorGUILayout.BeginVertical();
            foreach (DataRow r in mapData.Rows)
            {
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField(r["mapid"].ToString());
                EditorGUILayout.LabelField(r["name"].ToString());
                if (GUILayout.Button("打开"))  
                {
                    if(onOpenMap != null)
                        onOpenMap(r);
                    this.Close();
                }
                EditorGUILayout.EndHorizontal();
            }
            EditorGUILayout.EndVertical();
            GUILayout.EndScrollView();  //结束 ScrollView 窗口  
        }
    }
}
 
