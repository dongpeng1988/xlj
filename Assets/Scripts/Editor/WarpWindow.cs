using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using UnityEditor;
using Config;
using sw.ui.model;

class WarpWindow:EditorWindow
{
    public MapWarp warp = new MapWarp();
    //public int warpId;
    //public string warpName;
    //public int warpX;
    //public int warpY;
    //public int destMapId = -1;

    public string[] destMap_names = {"a","b"};
    public int[] destMap_Ids = {1,2};
    public List<int> mapIdList;
    //public int destMapX;
    //public int destMapY;
    //public int type= -1;
    public string[] type_name = { "自定义", "进入下一层", "退出副本" };
    public int[] type_value = { 0,1,2 };

    //public int state = -1;
    public string[] state_names = { "默认开启","默认不开启" };
    public int[] state_values = { 0, 1 };

    [MenuItem("Build/WarpWindow")]
    static void openWarpWindow()
    {
        WarpWindow window = (WarpWindow)GetWindow<WarpWindow>();
        
        window.Show();
    }

    void OnGUI()
    {
        prepareData();

        GUILayout.BeginVertical();
            warp.warpName = EditorGUILayout.TextField("传送门名称", warp.warpName);
            warp.warpX = EditorGUILayout.IntField("传送门 X：", warp.warpX);
            warp.warpY = EditorGUILayout.IntField("传送门 Y：", warp.warpY);
            GUILayout.Space(2);
            if (warp.type < 0)
                warp.type = type_value[0];
            warp.type = EditorGUILayout.IntPopup("传送门类型", warp.type, type_name, type_value);

            GUILayout.BeginHorizontal();
                if (warp.destMapId < 0)
                    warp.destMapId = destMap_Ids[0];
                warp.destMapId = EditorGUILayout.IntPopup("前往地图：", warp.destMapId, destMap_names, destMap_Ids);
            GUILayout.EndHorizontal();
            warp.destMapX = EditorGUILayout.IntField("坐标 X:", warp.destMapX);
            warp.destMapY = EditorGUILayout.IntField("坐标 Y：", warp.destMapY);

            if (warp.state < 0)
                warp.state = state_values[0];
            warp.state = EditorGUILayout.IntPopup("是否默认开启", warp.state, state_names, state_values);

            if(GUILayout.Button("确定"))
            {
                EditMapCameraManager.Instance.addWarp(warp);
            }
        GUILayout.EndVertical();


        //GUILayout.Label("传送门位置：");
        
    }

    private void prepareData()
    {
        if (mapIdList == null )
        {
            mapIdList = new List<int>();
        }
        if (ConfigAsset.Instance.loadComplete == true)
        {
            mapIdList.Clear();
            ConfigAsset.Instance.WalkmapCfgsCfgs((MapConfig cfg) =>
            {
                if ((cfg.mapid.ToString() != "") && (cfg.mapid.ToString() != "0"))
                {
                    mapIdList.Add(cfg.mapid);
                }
                else
                {

                }
                return false;
            });
            if (mapIdList.Count > 0 && mapIdList.Count != destMap_Ids.Length)
            {
                destMap_names = new string[mapIdList.Count];
                destMap_Ids = new int[mapIdList.Count];
                for (int i = 0; i < mapIdList.Count; i++)
                {
                    destMap_Ids[i] = mapIdList[i];
                    destMap_names[i] = mapIdList[i].ToString();
                }
            }
        }
        
        
    }
}

