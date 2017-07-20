using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using UnityEditor;
using Config;
using ICSharpCode.SharpZipLib.Zip.Compression.Streams;
using ICSharpCode.SharpZipLib.Zip.Compression;
using System.IO;
using sw.util;
using NPOI.XSSF.UserModel;
using NPOI.SS.UserModel;
using System.Data.OleDb;
using NetUtilityLib;
using System.Data;
using sw.scene.util;
using sw.manager;
using UnityEditor.AnimatedValues;
using sw.ui.model;
using System.Xml;


public class LoadMapWindow : EditorWindow
{
    [MenuItem("Build/场景编辑")]
    static void onLoadMap()
    {

        LoadMapWindow window = (LoadMapWindow)GetWindow<LoadMapWindow>( "场景编辑");
        window.Show();


    }
    string mapFileName;
    public LoadMapWindow()
    {
        mapFileName = EditorConfig.ExcelDataDir + "002_地图配置表.xls";

        tileData = ExcelHelper.ExcelToDataTable(mapFileName, "Sheet2");

    }
    int selected_size = 1;
    string[] names = { "Normal", "Doubule", "Trible" };
    int[] sizes = { 1, 2, 4 };
    List<string> nameLst = new List<string>();
    bool npcLoaded;
    DataRow curMapData;
    DataTable tileData;
    void onOpenMap(DataRow data)
    {
        string targetPath = "scene/" + data["mapResId"].ToString() ;
        string[] assets2 = AssetDatabase.GetAssetPathsFromAssetBundle(targetPath);
        //string[]  assets2 = new string[1];
        //assets2[0] = "E:/xlj-res/main/main/Assets/ART/Scenescene/"+ data["mapResId"].ToString() ;
        if (assets2.Length == 0)
        {

            Debug.LogError("地图资源不存在:" + data["mapResId"].ToString());
            showError("地图资源设置不正确:" + data["mapResId"].ToString()+",请联系前端处理");
        }
       // else
        {
            if (assets2.Length > 1)
                Debug.LogWarning("有重复的地图资源:" + data["mapResId"].ToString());
            string[] demos = AssetDatabase.FindAssets(data["mapResId"].ToString() + "_demo t:Scene");
            if (demos.Length == 0)
            {
                showError("地图demo资源不存在:" + data["mapResId"].ToString());
                return;
            }
            Debug.Log("begin to open scene:" + AssetDatabase.GUIDToAssetPath(demos[0]));
            bool ret = EditorApplication.OpenScene(AssetDatabase.GUIDToAssetPath(demos[0]));
            curMapData = data;
            EditorData.mapId = curMapData["mapid"].ToString();
            EditorData.mapResId = curMapData["mapResId"].ToString();
            EditorData.mapTileId = curMapData["mapTileId"].ToString();
            LoadTile(EditorData.mapTileId);
            Debug.Log("set map tile id:" + EditorData.mapTileId);
            safeConfig();
            curTool = 0;
            EditorData.start_edit_tile = false;
            showMesh = false;
            npcLoaded = false;
            npcHelper = new NpcEditHelper();
            Repaint();
        }

    }
    void safeConfig()
    {
        string fn = Application.streamingAssetsPath+"/tile.xml";
        XmlDocument doc = new XmlDocument();
        XmlElement root;
        if(File.Exists(fn))
        {
            string data = File.ReadAllText(fn);

            doc.LoadXml(data);
            root = doc.SelectSingleNode("root") as XmlElement; 
        }
        else
        {
           // doc.CreateXmlDeclaration("1.0", "utf-8", "yes");
            root  = doc.CreateElement("root");
            doc.AppendChild(root);
        }
        string resid = curMapData["mapResId"].ToString();
        XmlNodeList maps = doc.GetElementsByTagName("map");
        bool found = false;
        foreach(XmlNode node in maps)
        {
            if(node.Attributes["resid"] != null && node.Attributes["resid"].Value ==resid)
            {
                node.Attributes["tile"].Value = curMapData["mapTileId"].ToString();
                found = true;
                break;
            }
        }
        if (!found)
        {
            XmlElement el =  doc.CreateElement("map");
           XmlAttribute attrResid =    doc.CreateAttribute("resid");
           attrResid.Value = resid;
           el.Attributes.Append(attrResid);
           XmlAttribute attrTile = doc.CreateAttribute("tile");
           attrTile.Value = curMapData["mapTileId"].ToString();
           el.Attributes.Append(attrTile);
           root.AppendChild(el);
        }
        doc.Save(fn);

        //Debug.Log("write config:" + fn);
        //using (StreamWriter fs = new StreamWriter(fn))
        //{
        //    fs.WriteLine("mapid=" + curMapData["mapid"].ToString());
        //    fs.WriteLine("mapResId=" + curMapData["mapResId"].ToString());
        //    fs.WriteLine("mapTileId=" + curMapData["mapTileId"].ToString());

        //}
    }
    void showError(string msg)
    {
        errorInfo = msg;
         
        Debug.LogError("show error:" + msg);
    }
    bool selected, showMesh;
    int curTool = 0;
    int curMapTool = 0;
    string[] toolbars = new string[] { "通过", "不可通过" };
    string[] mapTool = new string[] { "通过性", "布怪" };
    TileHelper helper;
    int countShift;
    AnimBool m_ShowExtraFields;
    bool groupTile;
    int left_area_num = 0;
    void showTileTool()
    {
        string mapResId = curMapData["mapResId"].ToString();
        List<string> allTiles = new List<string>();
        string curTile = curMapData["mapTileId"].ToString();
        int selTile = -1;
        foreach (DataRow r in tileData.Rows)
        {
            if (r["resid"].ToString() == mapResId)
            {
                string tileid = r["mapTileId"].ToString();
                string memo = r["memo"].ToString();
                if (memo.Length > 5)
                    memo = memo.Substring(0, 5);
                allTiles.Add(tileid + "," + memo);
                if (tileid == curTile)
                {
                    selTile = allTiles.Count - 1;
                }
            }
        }
        EditorGUILayout.BeginHorizontal();

        int idx = EditorGUILayout.Popup("通过性:", selTile, allTiles.ToArray());
        if (selTile != idx)
        {

            EditorData.mapTileId = allTiles[idx].Split(',')[0];
            Debug.Log("new map tile id:" + EditorData.mapTileId);
            LoadTile(EditorData.mapTileId);
            curMapData["mapTileId"] = EditorData.mapTileId;
            safeConfig();
        }
        selTile = idx;

        if (GUILayout.Button("新建"))
        {
            createTile();
        }
        EditorGUILayout.EndHorizontal();
        if (GUILayout.Button("重新创建") && EditorUtility.DisplayDialog("重新创建", "确认重新创建通过性？之前修改的通过性将丢失！", "是", "否"))
        {

            recreateTile();
        }
        bool show = GUILayout.Toggle(showMesh, "显示通过性", "Button");
        if (show && show != showMesh)
        {
            Debug.Log("show:" + show + ",showmesh:" + showMesh);
            showTile();
        }
        showMesh = show;
        if (showMesh)
        {

            bool cursel = GUILayout.Toggle(selected, "编辑", "Button");

            selected = cursel;
            EditorData.start_edit_tile = selected;
            if (selected)
            {
                RenderSettings.fog = false;
                //if(EditorData.terrainMan != null)
                //{
                //    countShift++;
                //    EditorData.terrainMan.pathFinder.setColFlag(countShift % 3 + 1, 1);
                //}
                curTool = GUILayout.Toolbar(curTool, toolbars);

                countShift = EditorGUILayout.IntSlider(countShift, 1, 3);
                terrainMan.pathFinder.setColFlag(countShift, curTool);

            }
            else
                RenderSettings.fog = true;
        }
        else if (testMesh != null)
        {
            GameObject.DestroyImmediate(testMesh);
            testMesh = null;
        }
        if (GUILayout.Button("保存"))
        {
            try
            {
                ExcelHelper.UpdateExcel(mapFileName, "Sheet1", "mapid", curMapData);
                terrainMan.pathFinder.saveTile(curTile,EditorConfig.ExcelDataDir,EditorData.mapTileId);
                EditorGUILayout.HelpBox("保存成功 地图文件：" + mapFileName + ",通过性:" + curTile, MessageType.Info);
            }
           catch(Exception ex)
            {
                showError("保存失败");
            }
           
            
        }
        if(GUILayout.Button("检查可通过点的高度"))
        {
            //try
            //{
            //    Dictionary<Vector2,int> illegalCanWalkArea = terrainMan.pathFinder.checkCanWalkArea();
            //    string str = "";
            //    foreach (Vector2 pt in illegalCanWalkArea.Keys)
            //    {
                    
            //        str += "x:" + PathUtilEdit.Logic2RealX(pt.x) + "y:" + PathUtilEdit.Logic2RealZ(pt.y) + "   ";
            //    }
            //    EditorGUILayout.TextArea(str);
            //    Debug.Log(str);
            //}
            //catch
            //{
            //    showError("检查可通过点的碰撞过程中出错");
            //}
            Dictionary<int, Dictionary<Vector2, int>> connectivityDict = terrainMan.pathFinder.getConnectivityDict(); 
            
        }
        GUILayout.BeginHorizontal();
        left_area_num = EditorGUILayout.IntField("保留最大N个区域：", left_area_num);
        if(GUILayout.Button("清除其他连通区域"))
        {
            terrainMan.pathFinder.clearConnectivityToNum(left_area_num);
        }
        GUILayout.EndHorizontal();
    }
    DataRow[] allNpcData;
    Dictionary<int, DataRow> allNpcDict;
    int curNpcType;
    string[] npcLabels;
    int selNpc = 0;
    int input_id;
    

    void showNpcAdd(int tp)
    {
        if(allNpcDict == null)
        {
            allNpcDict = new Dictionary<int,DataRow>();
            DataTable dt =  EditorTool.getAllNpc();
            foreach(DataRow row in  dt.Select())
            {
                int id;
                if (int.TryParse(row["id"].ToString(),out id))
                    allNpcDict[id] = row;
            }

        }
        if (curNpcType != tp || npcLabels == null || allNpcData == null)
        {
            allNpcData = EditorTool.getNpcByType(tp);
            if (allNpcData != null)
            {
                npcLabels = new string[allNpcData.Length];

                for (int i = 0; i < allNpcData.Length; i++)
                {
                    npcLabels[i] = allNpcData[i]["id"].ToString() + "," + allNpcData[i]["name"].ToString();
                }
            }
        }
        if(npcLabels != null)
        {
            GUILayout.BeginHorizontal();
            selNpc = EditorGUILayout.Popup(selNpc, npcLabels);
            if (GUILayout.Button("添加"))
            {
                DataRow data = allNpcData[selNpc];
                int id;
                if(input_id > 0)
                {
                    if(!allNpcDict.TryGetValue(input_id,out data))
                    {
                        Debug.LogError("npc id:" + input_id + ",不存在!");
                        return;
                    }
                    id = input_id;
                }
                else
                {
                    id = int.Parse(data["id"].ToString());
                }
                MapNpc node = new MapNpc(id);
                
                //warp.warpX = EditorGUILayout.IntField("传送门 X：", warp.warpX);
                
                npcHelper.AddNpc(data,node);
            }
            GUILayout.EndHorizontal();
            input_id = EditorGUILayout.IntField("输入npcId：", input_id);
            


        }
    }
    void showZoneTool()
    {

    }
    bool showAdd,showAddZone,showAddWarp,showAddLine;
    int selAddNpc;
    int selReginType;
    int zone_id = 0;
    int line_starobjid = 0;
    string[] regionType = new string[] { "矩形区域","点列"};
    void showNpcTool()
    {
        if (!npcLoaded)
        {
            if (GUILayout.Button("加载"))
            {
                loadNpc();

            }
        }
        else
        {
            if (showAdd = EditorGUILayout.Foldout(showAdd, "添加npc"))
            {

                selAddNpc = GUILayout.Toolbar(selAddNpc, new string[] { "添加Npc", "添加怪物" });
                if (selAddNpc == 0)
                {
                    showNpcAdd(2);
                }
                else
                    showNpcAdd(1);
            }
            EditorGUILayout.Separator();
            if (showAddZone = EditorGUILayout.Foldout(showAddZone, "添加区域"))
            {
                EditorGUILayout.BeginVertical();
                zone_id = EditorGUILayout.IntField("输入区域ID：", zone_id);
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.PrefixLabel("区域类型:");
                selReginType = EditorGUILayout.Popup(selReginType, regionType);
                if(GUILayout.Button("添加"))
                {
                    MapZone node = new MapZone();
                    node.regiontype = selReginType;
                    node.width = 4;
                    node.height = 4;
                    node.id = zone_id;
                    npcHelper.AddZone( node);
                }
                EditorGUILayout.EndHorizontal();
                
                EditorGUILayout.EndVertical();
            }

            if (showAddWarp = EditorGUILayout.Foldout(showAddWarp, "添加传送门"))
            {

                if (GUILayout.Button("添加传送门"))
                {
                    MapWarp node = new MapWarp();
                
                    npcHelper.AddWarp(node);
                }
                

            }
            if (showAddWarp = EditorGUILayout.Foldout(showAddWarp, "添加阻挡门"))
            {

                if (GUILayout.Button("添加阻挡门"))
                {
                    MapDoor node = new MapDoor();

                    npcHelper.AddDoor(node);
                }


            }
            if (showAddWarp = EditorGUILayout.Foldout(showAddWarp, "添加触发器"))
            {

                if (GUILayout.Button("添加触发器"))
                {
                    MapTrigger node = new MapTrigger();

                    npcHelper.AddTrigger(node);
                }


            }
            if (showAddWarp = EditorGUILayout.Foldout(showAddWarp, "添加地图特效"))
            {

                if (GUILayout.Button("添加地图特效"))
                {
                    MapEffectPoint node = new MapEffectPoint();

                    npcHelper.AddEffectPoint(node);
                }


            }
            if (showAddLine = EditorGUILayout.Foldout(showAddLine, "添加挂机路线"))
            {
                EditorGUILayout.BeginVertical();
                zone_id = EditorGUILayout.IntField("添加挂机路线：", line_starobjid);
                if (GUILayout.Button("添加挂机路线"))
                {
                    MapLine node = new MapLine(line_starobjid);

                    npcHelper.addLine(node);
                }
                EditorGUILayout.EndVertical();

            }
            EditorGUILayout.Space();
            EditorGUILayout.Separator();
            if (GUILayout.Button("保存"))
            {
                try
                {
                    npcHelper.saveMapXML();
                    //  EditorGUILayout.HelpBox("保存成功 地图文件：" + mapFileName + ",通过性:" + curTile, MessageType.Info);
                }
                catch (Exception ex)
                {
                    showError("保存失败");
                }


            }
            GUILayout.Space(50);
            if (GUILayout.Button("重新加载npc表"))
            {
               
                    EditorTool.LoadNpcConfig();
                    showAdd = false;


            }
        }

       
    }
    NpcEditHelper npcHelper ;
    void loadNpc()
    {
        npcHelper.readMapXML(EditorData.mapId);
        npcLoaded = true;
    }
    string errorInfo,msgInfo;
    void OnGUI()
    {
        errorInfo = null;
        msgInfo = null;
        EditorGUIUtility.labelWidth = 80f;
        if (GUILayout.Button("打开地图"))
        {
            OpenMapWindow window = (OpenMapWindow)GetWindow(typeof(OpenMapWindow));
            window.onOpenMap = onOpenMap;
            window.Show();
        }
        if (curMapData != null)
        {

            EditorGUILayout.LabelField("地图名称:" + curMapData["name"]);
            EditorGUILayout.LabelField("地图ID:" + curMapData["mapid"]);
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.LabelField("地图资源ID:" + curMapData["mapResId"]);
            if (GUILayout.Button("更换为当前地图"))
            {
                Debug.Log("cur scene:" + EditorApplication.currentScene);
                AssetImporter importer = AssetImporter.GetAtPath(EditorApplication.currentScene);
                if (importer != null)
                {
                    Debug.Log("asset bundle name:" + importer.assetBundleName);
                    string resid = importer.assetBundleName;
                    resid = resid.Substring(resid.LastIndexOf("/") + 1);
                    resid = resid.Substring(0, resid.LastIndexOf("."));

                    curMapData["mapResId"] = resid;
                }
            }
            EditorGUILayout.EndHorizontal();
         
            curMapTool = GUILayout.Toolbar(curMapTool, mapTool);
           switch(curMapTool)
           {
               case 0:
                   EditorGUI.indentLevel++;
                   showTileTool();
                   EditorGUI.indentLevel--;
                   break;
               case 1:
                   EditorGUI.indentLevel++;
                   showNpcTool();
                   EditorGUI.indentLevel--;
                   break;
               
           }
		 
           
           
        }
        if (!string.IsNullOrEmpty(errorInfo))
            EditorGUILayout.HelpBox(errorInfo, MessageType.Error);
        else if (!string.IsNullOrEmpty(msgInfo))
            EditorGUILayout.HelpBox(msgInfo, MessageType.Info);
        //if (GUILayout.Button("加载数据表"))
       // {

            //Workbook workbook1 = new Workbook();
            //workbook1.Open(ExcelDataDir + "003_副本数据表.xlsx");
            //Worksheet sheet = workbook1.Worksheets["副本全局表"];
            //int cnt =  sheet.Cells.Rows.Count;
            //for (int i = 0; i < cnt;i++ )
            //{
            //    if(sheet.Cells[i, 0].Value.ToString() == "1001")
            //    {
            //        sheet.Cells[i, 2].PutValue(sheet.Cells[i, 2].Value.ToString()+ "test");
            //        break;
            //    }

            //}
            //workbook1.Save(ExcelDataDir + "003_副本数据表.xlsx");

            //ExcelHelper helper = new ExcelHelper(ExcelDataDir + "003_副本数据表.xlsx");
            //DataTable dt = helper.ExcelToDataTable("副本全局表");
            //Debug.Log("dt num:" + dt.Rows.Count + ",first data:" + dt.Rows[0]["func"]);
            // bool ret = EditorApplication.OpenScene("Assets/ART/Scene/z_zhucheng/z_zhucheng_demol.unity");
            //Debug.Log("ret:" + ret);
            //FileStream fs = new FileStream(ExcelDataDir + "003_副本数据表.xlsx", FileMode.Open, FileAccess.ReadWrite, FileShare.ReadWrite);
            //XSSFWorkbook workbook = new XSSFWorkbook(fs);
            //ISheet sheet = workbook.GetSheet("副本全局表");
            //for (int i = 0; i < 10000; i++)
            //{
            //    ICell cell = sheet.GetRow(i).GetCell(0);
            //    string cellVal = "";
            //    if (cell.CellType == CellType.Numeric)
            //        cellVal = cell.NumericCellValue.ToString();
            //    else if (cell.CellType == CellType.String)
            //        cellVal = cell.StringCellValue;
            //    Debug.Log("cell:" + cellVal);
            //    if (cellVal == "1001")
            //    {
            //        sheet.GetRow(i).GetCell(2).SetCellValue("sss");
            //        break;
            //    }
            //}
            //workbook.Write(fs);
            //fs.Close();




            //Debug.Log("open success");
            //if (ConfigAsset.Instance.loadComplete == true)
            //{
            //    nameLst.Clear();
            //    ConfigAsset.Instance.WalkmapCfgsCfgs((MapConfig cfg) =>
            //    {
            //        if ((cfg.mapid.ToString() != "") && (cfg.mapid.ToString() != "0"))
            //        {
            //            nameLst.Add(cfg.mapid.ToString());
            //        }
            //        else
            //        {

            //        }
            //        return false;
            //    });
            //    if (nameLst.Count > 0 && nameLst.Count != names.Length)
            //    {
            //        names = new string[nameLst.Count];
            //        sizes = new int[nameLst.Count];
            //        for (int i = 0; i < nameLst.Count; i++)
            //        {
            //            names[i] = nameLst[i];
            //            sizes[i] = int.Parse(nameLst[i]);
            //        }
            //    }
            //}
       // }


        //selected_size = EditorGUILayout.IntPopup("选择数据表:", selected_size, names, sizes);
        //MapConfig mapcfg;
        //mapcfg = ConfigAsset.Instance.getMapCfgs(selected_size);
        //if (mapcfg != null)
        //{
        //    GUILayout.Label("地图资源id为：" + mapcfg.mapResId);
        //    GUILayout.Label("地图通过性id为：" + mapcfg.mapResId);

        //    EditMapCameraManager.Instance.mapResId = mapcfg.mapResId;
        //    EditMapCameraManager.Instance.mapTileId = mapcfg.mapResId;
        //}
        //if (GUILayout.Button("加载地图" + selected_size))
        //{
        //     //EditorApplication.isPaused = false;
        //     //EditorApplication.isPlaying = false;


        //     //UnityEditor.FileUtil.DeleteFileOrDirectory(EditorApplication.currentScene);

        //     //UnityEditor.FileUtil.DeleteFileOrDirectory("Assets/ART/Scene/z_zhucheng/y_yunnanchonggu_04_demo.untiy");


        //    EditorApplication.OpenScene("Assets/ART/Scene/z_zhucheng/z_zhucheng_demol.untiy");

        //    EditMapCameraManager.Instance.readMapXML(selected_size);
        //}

    }
    void LoadTile(string name)
    {
        //if (terrainMan == null)
        {
            terrainMan = new TestTerrainManager();
            terrainMan.pathFinder.setRoleTransAndTerrain(null, terrainMan);
            EditorData.terrainMan = terrainMan;
        }
        string targetPath = Application.streamingAssetsPath.Substring(0, Application.streamingAssetsPath.Length - 15) + "map/" + name + ".bytes";
        if (!File.Exists(targetPath))
        {
            Debug.Log("通过性文件不存在:" + targetPath);
            return;
        }
        using (FileStream fs = new FileStream(targetPath, FileMode.Open))
        {
            byte[] data = new byte[fs.Length];
            fs.Read(data, 0, (int)fs.Length);
            ByteArray bt = new ByteArray(data);

            terrainMan.pathFinder.fillData(bt);
            PathUtilEdit.origin_x = terrainMan.pathFinder.origin_x;
            PathUtilEdit.origin_z = terrainMan.pathFinder.origin_z;
        }
    }
    ITerrainManager terrainMan;

    GameObject testMesh;
    void showTile()
    {
        RenderSettings.fog = false;
        if (terrainMan == null)
        {
            terrainMan = new TestTerrainManager();
            terrainMan.pathFinder.setRoleTransAndTerrain(null, terrainMan);
            EditorData.terrainMan = terrainMan;
        }
        GameObject obj = GameObject.Find("TileMesh");

        if (obj != null)
            GameObject.DestroyImmediate(obj);
        testMesh = terrainMan.pathFinder.GetTestMesh();
        testMesh.name = "TileMesh";
        for (int i = 0; i < testMesh.transform.childCount; i++)
        {
            testMesh.transform.GetChild(i).gameObject.AddComponent<TileHelper>();
            //testMesh.transform.GetChild(i).gameObject.hideFlags   = HideFlags.NotEditable;
        }

        testMesh.AddComponent<TileHelper>();
        testMesh.AddComponent<TileImg>();
        //testMesh.transform.localPosition = new Vector3(terrainMan.pathFinder.origin_x, 0, terrainMan.pathFinder.origin_z);

    }
    void recreateTile()
    {
        doCreateTile(EditorData.mapTileId);
        LoadTile(EditorData.mapTileId);
        showMesh = false;
        Repaint();
    }
    public void createTile()
    {
        if (curMapData == null || tileData == null)
            return;
        string tileName = curMapData["mapid"].ToString().Substring(0, 6);
        string mapresid = curMapData["mapResId"].ToString();
        Dictionary<string, int> curTiles = new Dictionary<string, int>();
        foreach (DataRow r in tileData.Rows)
        {
            if (r["resid"].ToString() == mapresid)
            {
                curTiles[r["mapTileId"].ToString()] = 1;
                Debug.Log("tileid:" + r["mapTileId"].ToString());
            }
        }
        int suffix = 1;
        string tmp = tileName;
        Debug.Log("check content:" + tmp);
        while (curTiles.ContainsKey(tmp))
        {
            tmp = tileName + suffix;
            suffix++;
        }
        tileName = tmp;

       doCreateTile(tileName);

        curMapData["mapTileId"] = tileName;
        DataRow row = tileData.NewRow();

        row["resid"] = mapresid;
        row["mapTileId"] = tileName;
        tileData.Rows.Add(row);
        Debug.Log("tiledata row:" + tileData.Rows.Count);
        EditorData.mapTileId = tileName;
        safeConfig();
        ExcelHelper.AddRow(mapFileName, "Sheet2", row);
        showMesh = false;
        Repaint();
        

    }
    void doCreateTile(string tileName)
    {
         float xMax = 0, xMin = 0, zMax = 0, zMin = 0, yMax = 0, yMin = 0, xMaxSize = 0, xMinSize = 0;
        MeshRenderer[] rendererObjs;
        rendererObjs = GameObject.FindObjectsOfType<MeshRenderer>();
        int count_items = 0, total_size = 0;
        Bounds bound = new Bounds();
        bool bFirst = true;
        foreach (MeshRenderer item in rendererObjs)
        {
            if (item.gameObject.layer != LayerConst.LAYER_GROUND)
                continue;
            if(bFirst)
                bound = new Bounds(item.bounds.center,item.bounds.size);
            else
                bound.Encapsulate(item.bounds);
            bFirst = false;
            //Debug.Log("item bounds:"+)
            if (xMax < item.bounds.max.x)
                xMax = item.bounds.max.x;
            if (xMin > item.bounds.min.x)
                xMin = item.bounds.min.x;
            if (zMax < item.bounds.max.z)
                zMax = item.bounds.max.z;
            if (zMin > item.bounds.min.z)
                zMin = item.bounds.min.z;
            if (yMax < item.bounds.max.y)
                yMax = item.bounds.max.y;
            if (yMin > item.bounds.min.y)
                yMin = item.bounds.min.y;

            if (xMaxSize < item.bounds.size.x)
                xMaxSize = item.bounds.size.x;
            if (xMinSize > item.bounds.size.x)
                xMinSize = item.bounds.size.x;
            count_items++;
        }
        Debug.Log("xMax xMin zMax zMin yMax yMin" + xMax + "  " + xMin + "  " + zMax + "  " + zMin + "  " + yMax + "  " + yMin+",bound:"+bound);
        Debug.Log("all meshrenderer is" + rendererObjs.Length + " layer ground" + LayerConst.LAYER_GROUND + "count_items is" + count_items + "size is " + total_size);

        int col_num = 0, row_num = 0;
        float origin_x = 0, origin_z = 0;
        xMin = bound.min.x;
        xMax = bound.max.x;
        zMin = bound.min.z;
        zMax = bound.max.z;

        origin_x = xMin;
        origin_z = zMax;

        col_num = (int)((xMax - xMin) / ConstantsRes.GRID_SIZE);
        row_num = (int)((zMax - zMin) / ConstantsRes.GRID_SIZE);

        Debug.Log("tileWidth tileHeight" + col_num + row_num);

        RaycastHit hitInfo;
        LayerMask groundLayer = LayerConst.MASK_GROUND;
        int count_can_walk = 0;
        int count_total_point = 0;
        DateTime dt = DateTime.Now;
        uint _version = (uint)dt.ToFileTimeUtc();
        string targetPath = Application.streamingAssetsPath.Substring(0, Application.streamingAssetsPath.Length - 15) + "map/";
        Directory.CreateDirectory(targetPath);
        FileStream fs;
        fs = new FileStream(targetPath + tileName + ".bytes", FileMode.Create);
        BinaryWriter bw = new BinaryWriter(fs);
        bw.Write(0x0821);
        bw.Write(_version);
        bw.Write(col_num);
        bw.Write(row_num);
        bw.Write((float)origin_x);
        bw.Write((float)origin_z);

        Debug.Log("map size:" + col_num + "*" + row_num + ",origin:" + origin_x + "," + origin_z);

        int i = 0;
        for (int j = 0; j < row_num; j++)
        {
            i = 0;
            for (; i < col_num; i++)
            {
                float x = origin_x + (float)(i + 0.5) * ConstantsRes.GRID_SIZE;
                float z = origin_z - (float)(j + 0.5) * ConstantsRes.GRID_SIZE;
                Vector3 origin = new Vector3(x, 1000, z);
                Vector3 direction = new Vector3(0.0f, -1.0f, 0.0f);
                Ray ray = new Ray(origin, direction);
                if (Physics.Raycast(ray, out hitInfo, 1500.0f, groundLayer))
                //if (Mathf.Abs((origin.x - 150) * Constants.GRID_SIZE) < 20 && Mathf.Abs((origin.z - 160) * Constants.GRID_SIZE) < 20)
                //if ((-origin.z) > 100)
                //if (Mathf.Abs(origin.x - 159) < 20 && Mathf.Abs(-origin.z- 171) < 20)
                {
                    count_can_walk++;
                    if (Mathf.Abs(origin.x - 149) < 0.7 && Mathf.Abs(-origin.z - 147) < 0.7)
                    {
                        Debug.Log("point " + origin.x + "  " + origin.x + "can pass");
                    }
                    bw.Write((byte)0);
                }
                else
                {
                    if (Mathf.Abs(origin.x - 149) < 0.7 && Mathf.Abs(-origin.z - 147) < 0.7)
                    {
                        Debug.Log("point " + origin.x + "  " + origin.x + "can not pass");
                    }
                    bw.Write((byte)1);
                }

                bw.Write((byte)0);
                count_total_point++;
            }
        }




        bw.Close();
        fs.Close();
        Debug.Log("count_can_walk count_total_point" + count_can_walk + "  " + count_total_point);
    }

}


