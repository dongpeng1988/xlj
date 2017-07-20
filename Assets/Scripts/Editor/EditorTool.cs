#if UNITY_EDITOR
using NetUtilityLib;
using sw.scene.util;
using System.Data;
using UnityEditor;
using UnityEngine;
namespace sw.util
{

    public static class EditorTool
    {
        public static Object LoadAssetBundle(string name)
        {
            string[] assets2 = AssetDatabase.GetAssetPathsFromAssetBundle(name);
            if (assets2.Length == 0)
            {
                 
                return null;
            }
            else if (assets2.Length > 1)
            {
                Debug.LogWarning(" 资源不唯一:" + name);
            }
            return AssetDatabase.LoadAssetAtPath(assets2[0], typeof(GameObject));
            
        }
        static DataTable npcData;
        public static void LoadNpcConfig()
        {
            Debug.Log("开始读取npc表，需要较长时间，请耐心等候....");
            npcData = ExcelHelper.ExcelToDataTable(EditorConfig.ExcelDataDir + "/120_npc.xlsm", "NPC");
            Debug.Log("npc表读取完毕！");
        }
        public static DataRow getNpc(int id)
        {
            if (npcData == null)
                LoadNpcConfig();
            DataRow[] rows = npcData.Select("id='" + id + "'");
            if (rows.Length > 0)
                return rows[0];
            return null;
        }
        public static DataTable getAllNpc()
        {
            if (npcData == null)
                LoadNpcConfig();
            return npcData;
        }
        public static DataRow[] getNpcByType(int type)
        {
            if (npcData == null)
                LoadNpcConfig();
            DataRow[] rows = npcData.Select("type='" + type + "'");
            return rows;
        }
        public static void CenterObj(GameObject obj)
        {
            if(SceneView.sceneViews.Count>0)
            {
                SceneView view = SceneView.sceneViews[0] as SceneView;
                view.MoveToView(obj.transform);
                Ray ray = view.camera.ViewportPointToRay(new Vector3(0.5f, 0.5f, 1.0f));
                 
                RaycastHit hit;
                LayerMask nl = LayerConst.MASK_GROUND;

                if (Physics.Raycast(ray, out hit, 1500.0f, nl))
                {
                    obj.transform.position = hit.point;
                    Debug.Log("has hit:" + hit.point);
                }
            }
        }
        public static void LookObj(GameObject obj)
        {
             if(SceneView.sceneViews.Count>0)
            {
                SceneView view = SceneView.sceneViews[0] as SceneView;

                view.LookAt(obj.transform.position);
                Selection.activeGameObject = obj;
            }
            
        }
    }

}
#endif