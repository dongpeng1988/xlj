using sw.game.model;
using sw.manager;
using sw.res;
using sw.role;
using sw.scene.ctrl;
using sw.scene.util;
using sw.util;
using sw.scene.model;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using sw.ctrl;
using Config;
using System.IO;
using ICSharpCode.SharpZipLib.Zip.Compression.Streams;
using ICSharpCode.SharpZipLib.Zip.Compression;
#if UNITY_EDITOR
using UnityEditor;
using sw.view;
#endif
public class TestMain:MonoBehaviour
{
    public GameObject mainRole;
    RoleCtrlDemo mainRoleCtrl;
    public UIButton[] skillButton;
    public UIButton zuoqi;
    public UIButton huanjue;
    ITerrainManager terrainMan;
    IFxManager fxMan;
    IjueseManager jueseMan;
    public string curRole;
    public UILabel mousePos;
    public UILabel lb_zoneId;
    

    private bool start_edit_tile = false;
    private bool use_tile_101002 = false;
    void Start()
    {
        Timer2Runner timer2 = base.gameObject.GetComponent<Timer2Runner>();
        if (timer2 == null)
        {
            GameObject.Destroy(timer2);
            timer2 = null;
        }
        base.gameObject.AddComponent<Timer2Runner>();
        mainRoleCtrl = mainRole.AddComponent<RoleCtrlDemo>();
#if UNITY_EDITOR
        AssetLoader2.m_SimulateAssetBundleInEditor = true;
#endif
        //base.gameObject.AddComponent<AssetLoader>();
        base.gameObject.AddComponent<AssetLoader2>();

        terrainMan = new TestTerrainManager();
        fxMan = new TestFxManager();
#if UNITY_EDITOR
        getMapId();
#endif
        EditMapCameraManager.Instance.mapResId = mapResId;
        //EditMapCameraManager.Instance.use_tile_101002 = true;
        //AssetLoader.Instance.LoadBytes("/data/config_" + ConfigAsset.Instance.VERSION + ".dat", onLoadConfig, null);
        //AssetLoader2.Instance.LoadAsset("map/" + mapId , mapId, typeof(TextAsset), onLoadMap);
        onloadTitle();
        Vector3 pos = mainRole.transform.position;
        pos.y = terrainMan.GetHeight(pos.x, pos.z);
        mainRole.transform.position = pos;
        mainRoleCtrl.terrainMan = terrainMan;
        mainRoleCtrl.fxMan = fxMan;

        jueseMan = new jueseFxManager();
        mainRoleCtrl.jueseMan = jueseMan;
        curRole = "z_women1";

        EventDelegate.Add(skillButton[0].GetComponent<UIEventTrigger>().onClick, onClickSkillBtn0);
        EventDelegate.Add(skillButton[1].GetComponent<UIEventTrigger>().onClick, onClickSkillBtn1);
        EventDelegate.Add(skillButton[2].GetComponent<UIEventTrigger>().onClick, onClickSkillBtn2);
        EventDelegate.Add(skillButton[3].GetComponent<UIEventTrigger>().onClick, onClickSkillBtn3);
        EventDelegate.Add(skillButton[4].GetComponent<UIEventTrigger>().onClick, onClickSkillBtn4);
        EventDelegate.Add(skillButton[5].GetComponent<UIEventTrigger>().onClick, onClickSkillBtn5);
        EventDelegate.Add(zuoqi.GetComponent<UIEventTrigger>().onClick, onZuoqi);
        EventDelegate.Add(huanjue.GetComponent<UIEventTrigger>().onClick, onHuanjue);

        //AssetLoader2.Instance.LoadAsset("data/config_" + ConfigAsset.Instance.VERSION + ".dat", "data/config_" + ConfigAsset.Instance.VERSION + ".dat", typeof(TextAsset), onLoadConfig);
        StartCoroutine(InitModel());
    }
    IEnumerator InitModel()
    {
        yield return null;
        jueseMan.preloadPrepare("z_women1_0");
        yield return null;
        jueseMan.preloadPrepare("wuqi_nu1_a_skin");
        yield return null;
        jueseMan.preloadPrepare("y_5");
        yield return null;
        jueseMan.preloadPrepare("z_women2_5");
        yield return null;
        jueseMan.preloadPrepare("wuqi_fazhang5_skin");
        yield return null;
        jueseMan.preloadPrepare("y_3");
        yield return null;
        jueseMan.preloadPrepare("z_men1_5");
        yield return null;
        jueseMan.preloadPrepare("wuqi_jian5_skin");
        yield return null;
        jueseMan.preloadPrepare("y_10");
    }
    private void onClickSkillBtn0()
    {
        mainRoleCtrl.PlaySkill(1);
        //LoggerHelper.Debug("here press the UI Button 1");
    }
    private void onClickSkillBtn1()
    {
        mainRoleCtrl.PlaySkill(11);
        //LoggerHelper.Debug("here press the UI Button 2");
    }
    private void onClickSkillBtn2()
    {
        mainRoleCtrl.PlaySkill(12);
        //LoggerHelper.Debug("here press the UI Button 3");
    }
    private void onClickSkillBtn3()
    {
        mainRoleCtrl.PlaySkill(13);
        //LoggerHelper.Debug("here press the UI Button 4");
    }
    private void onClickSkillBtn4()
    {
        mainRoleCtrl.PlaySkill(14);
        //LoggerHelper.Debug("here press the UI Button 5");
    }
    private void onClickSkillBtn5()
    {
        mainRoleCtrl.PlaySkill(15);
        //LoggerHelper.Debug("here press the UI Button 6");
    }
    private bool zuoqiState = false;
    private void onZuoqi()
    {
        zuoqiState = !zuoqiState;
        mainRoleCtrl.zuoqi(zuoqiState);
    }
    private int jueseIndex = 0;
    private void onHuanjue()
    {
        jueseIndex++;
        if (jueseIndex%3==0)
            curRole = "z_men1_5";
        else if (jueseIndex % 3 == 1)
            curRole = "z_women1_0";
        else
            curRole = "z_women2_5";
        mainRoleCtrl.onHuanjue(curRole);
    }
    GameObject testMesh;
    Transform testGridTransform;
    //edit tile
    //DebugGrid grid;
    //DebugGrid mouseGrid;
    void onLoadMap(object obj,object[] param)
    {
        TextAsset tex = obj as TextAsset;
        if(tex==null)
            LoggerHelper.Debug("here the program come here find tex==null");
        else
            LoggerHelper.Debug("tex:" + tex.bytes.Length);

        //如果加载不到地图通过性文件，新创建一份，需要重新进入游戏。
        //if(obj == null)
        //{
        //    edittile.createTile();
        //    return;
        //}
        Debug.Log("tex:"+ tex.bytes.Length);
        ByteArray bt = new ByteArray(tex.bytes);

        terrainMan.pathFinder.fillData(bt);
        //grid = base.gameObject.AddComponent<DebugGrid>();
        //grid.target = mainRole.transform;
        //grid.terrainMan = terrainMan;

        //mouseGrid = base.gameObject.AddComponent<DebugGrid>();
        //mouseGrid.target = mainRole.transform;
        //mouseGrid.terrainMan = terrainMan;
        //mouseGrid.isMouseGrid = true;

        terrainMan.pathFinder.setRoleTransAndTerrain(mainRole.transform, terrainMan);
        EditMapManager.Instance.terrainMan = terrainMan;
        
        EditMapManager.Instance.createBossLayer();
        PathUtilEdit.origin_x = terrainMan.pathFinder.origin_x;
        PathUtilEdit.origin_z = terrainMan.pathFinder.origin_z;
        
        /*
        testMesh = terrainMan.pathFinder.GetTestMesh();
        testMesh.transform.localPosition = new Vector3(terrainMan.pathFinder.origin_x, 0, terrainMan.pathFinder.origin_z);
        PathUtilEdit.origin_x = terrainMan.pathFinder.origin_x;
        PathUtilEdit.origin_z = terrainMan.pathFinder.origin_z;
         * */
    }
    int countCtrl = -1;
    int countShift = -1;
    bool isDragging = false;
    bool show_test_mesh = false;
    bool is_dragging_map = false;
    Vector3 last_mousePos;
    void Update()
    {
        if (UICamera.hoveredObject != null)
        {
            return;
        }
        if(UICamera.currentTouch!=null)
        {
            mainRoleCtrl.PlaySkill(1);
        }
        if(Input.anyKeyDown)
        {
            if (Input.GetKeyDown(KeyCode.Alpha1))
            {
                mainRoleCtrl.PlaySkill(1);
            }
            else if(Input.GetKeyDown(KeyCode.Alpha2))
            {
                mainRoleCtrl.PlaySkill(2);
            }
            else if (Input.GetKeyDown(KeyCode.Alpha3))
            {
                mainRoleCtrl.PlaySkill(3);
            }
            if (Input.GetKeyDown(KeyCode.Alpha4))
            {
                mainRoleCtrl.PlaySkill(4);
            }
            else if (Input.GetKeyDown(KeyCode.Alpha5))
            {
                mainRoleCtrl.PlaySkill(5);
            }
            else if (Input.GetKeyDown(KeyCode.Alpha6))
            {
                mainRoleCtrl.PlaySkill(6);
            }
            else if(Input.GetKeyDown(KeyCode.F1))
            {
                show_test_mesh = !show_test_mesh;
                if (show_test_mesh)
                {
                    testMesh = terrainMan.pathFinder.GetTestMesh();
                    testMesh.transform.localPosition = new Vector3(terrainMan.pathFinder.origin_x, 0, terrainMan.pathFinder.origin_z);
                    
                }
                else
                {
                    if(testMesh != null)
                        Object.Destroy(testMesh);
                }
               
            }
            else if (Input.GetKeyDown(KeyCode.F2))
            {
                start_edit_tile = !start_edit_tile;

            }
            else if (Input.GetKeyDown(KeyCode.T))
            {
                terrainMan.pathFinder.testRay();
            }
        }
        
        if (start_edit_tile)
        {
            if (Input.GetKeyDown(KeyCode.LeftShift))//shift可通过 flag = 0
            {
                countShift++;
                terrainMan.pathFinder.setColFlag(countShift % 3 + 1, 0);
            }
            else if (Input.GetKeyDown(KeyCode.LeftControl))//ctrl 不可通过，flag = 1
            {
                countCtrl++;
                terrainMan.pathFinder.setColFlag(countCtrl % 3 + 1, 1);
            }
            else if (Input.GetKeyDown(KeyCode.U))
            {
                terrainMan.pathFinder.useThisTile();
            }
            else if (Input.GetKeyDown(KeyCode.S))
            {
                terrainMan.pathFinder.saveTile(tileId);
            }
            else if (Input.GetMouseButtonDown(0))
            {
                Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
                RaycastHit hit;
                LayerMask nl = LayerConst.MASK_GROUND;
                if (Physics.Raycast(ray, out hit, 1500.0f, nl))
                {
                    int endX = PathUtilEdit.Real2LogicX(hit.point.x) ;
                    int endZ = PathUtilEdit.Real2LogicZ(hit.point.z);

                    if (EditMapManager.Instance.EDIT_ZONE)
                        terrainMan.pathFinder.editZone(endX, endZ,1);
                    else
                        terrainMan.pathFinder.editTile(endX, endZ);
                }

                isDragging = true;
            }
            else if(Input.GetMouseButtonUp(0))
            {
                isDragging = false;
            }

            if(isDragging)
            {
                Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
                RaycastHit hit;
                LayerMask nl = LayerConst.MASK_GROUND;
                if (Physics.Raycast(ray, out hit, 1500.0f, nl))
                {
                    int endX = PathUtilEdit.Real2LogicX(hit.point.x);
                    int endZ = PathUtilEdit.Real2LogicZ(hit.point.z);

                    if(EditMapManager.Instance.EDIT_ZONE)
                        terrainMan.pathFinder.editZone(endX, endZ,1);
                    else
                        terrainMan.pathFinder.editTile(endX, endZ);
                }
            }
        }
        else  if(!EditMapCameraManager.Instance.showMainCamera)
        {
            if (Input.GetMouseButtonDown(0))
            {
                is_dragging_map = true;
                last_mousePos = Input.mousePosition;
            }
            if(Input.GetMouseButtonUp(0))
            {
                is_dragging_map = false;
            }
            if(is_dragging_map)
            {
                Vector3 temp_mouse_pos = Input.mousePosition;
                if (!temp_mouse_pos.Equals(last_mousePos))
                {
                    float move_x = ((temp_mouse_pos.x - last_mousePos.x)/6);
                    float move_z = ((temp_mouse_pos.y - last_mousePos.y)/6);
                    Vector3 temp_pos = new Vector3(EditMapCameraManager.Instance.mainCamera.gameObject.transform.position.x + move_x,
                        EditMapCameraManager.Instance.mainCamera.gameObject.transform.position.y,
                        EditMapCameraManager.Instance.mainCamera.gameObject.transform.position.z + move_z);
                    EditMapCameraManager.Instance.mainCamera.gameObject.transform.position = temp_pos;
                    last_mousePos = temp_mouse_pos;
                }
                
            }

            //Zoom out
            if (Input.GetAxis("Mouse ScrollWheel") < 0)
            {
                if (Camera.main.fieldOfView <= 100)
                    Camera.main.fieldOfView += 2;
                if (Camera.main.orthographicSize <= 20)
                    Camera.main.orthographicSize += 0.5F;
            }
            //Zoom in
            else if (Input.GetAxis("Mouse ScrollWheel") > 0)
            {
                if (Camera.main.fieldOfView > 2)
                    Camera.main.fieldOfView -= 2;
                if (Camera.main.orthographicSize >= 1)
                    Camera.main.orthographicSize -= 0.5F;
            }
            
        }
        else
        {
            if (Input.GetMouseButtonDown(0))
            {
                GoTo();
            }
        }

        //取鼠标坐标
        Ray ray1 = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit1;
        LayerMask nl1 = LayerConst.MASK_GROUND;
        if (Physics.Raycast(ray1, out hit1, 1500.0f, nl1))
        {
            int endX = PathUtilEdit.Real2LogicX(hit1.point.x);
            int endZ = PathUtilEdit.Real2LogicZ(hit1.point.z);
            if(mousePos!=null)
                mousePos.text = (int)hit1.point.x + "," + (int)hit1.point.z + "(" + endX + ","+ endZ + ")" + "\n Y:" + hit1.point.y;
        } 
        else if(Physics.Raycast(ray1, out hit1, 1500.0f))
        {
            int endX = PathUtilEdit.Real2LogicX(hit1.point.x);
            int endZ = PathUtilEdit.Real2LogicZ(hit1.point.z);

            mousePos.text = hit1.point.x + "," + hit1.point.z + "(" + endX + "," + endZ + ")" + "\n Y:" + hit1.point.y;
        }

        //使用101002的通过性
        if (EditMapCameraManager.Instance.use_tile_101002 == true && use_tile_101002 == false)
        {
#if UNITY_EDITOR
            AssetLoader2.Instance.LoadAsset("map/common", "common", typeof(TextAsset), onLoadMap);
#endif
            use_tile_101002 = true;

        }
        else if(EditMapCameraManager.Instance.use_tile_101002 == false && use_tile_101002 == true)
        {
#if UNITY_EDITOR
            AssetLoader2.Instance.LoadAsset("map/" + EditMapCameraManager.Instance.mapTileId, "common", typeof(TextAsset), onLoadMap);
#endif
            use_tile_101002 = true;
        }




    }
    public string mapResId, mapId, tileId;
    private ByteArray assetBytes;
    // private void onLoadConfig(byte[] bytes, object[] param)
    private void onLoadConfig(object bytes1,object[] param )
    {
#if UNITY_EDITOR
        //byte[] bytes = bytes1 as byte[];
        //    if(bytes == null)
        //    {
        //        LoggerHelper.Error("load config failed");
                //Messenger.Broadcast<string>(UILayerEvent.SHOW_LOADING_INFO, "加载配置文件失败!");
                //return;
            //}
            //using (InflaterInputStream input = new InflaterInputStream(new MemoryStream(bytes), new Inflater()))
            //{
            //    using (MemoryStream output = new MemoryStream())
            //    {
            //        sw.util.FileUtil.CopyStream(input, output);

            //        byte[] data = output.ToArray();
            //        //using (FileStream fs = new FileStream(Application.persistentDataPath + "/config.dat", FileMode.Create))
            //        //{
            //        //    fs.Write(data, 0, data.Length);
            //        //}
            //        assetBytes = new ByteArray(data);
            //    }

            //}
            //LoggerHelper.Debug("begin load config.....");
            //System.GC.Collect();

            //LoggerHelper.Debug("ConfigAsset.Instance:" + ConfigAsset.Instance.error);
 
            //LoggerHelper.Debug("begin run thread1");
            
            //ConfigAsset.Instance.readData(assetBytes);
#endif
            //Messenger.Broadcast(UILayerEvent.HIDE_LOADING);
            //LoggerHelper.Debug ("Begin Listen SDKLogin");
			//Messenger.AddListener<string>(SDKEventType.LOGIN_SUCCESS, onSdkLogin);
            //if (SDKFactory.getInterface != null)
            //    SDKFactory.getInterface.Login();
            //else
          
                //Messenger.Broadcast(UILayerEvent.SHOW_LOGIN);
            //GameObject.Destroy(versionCheck);
           // versionCheck = null;
//#if ENABLE_PROFILER
//            LoggerHelper.Debug(" onload config heap delta :" + (Profiler.GetMonoUsedSize()-prevHeap));
          
//#endif
            //在加载完config之后加载地图
#if UNITY_EDITOR
            getMapId();
            if (tileId != null && tileId != "")
                loadMapTile();
            else
                AssetLoader2.Instance.LoadAsset("map/common", "common", typeof(TextAsset), onLoadMap);
#else
        AssetLoader2.Instance.LoadAsset("map/common", "common", typeof(TextAsset), onLoadMap);
#endif
        }
    void onloadTitle()
    {
#if UNITY_EDITOR
        getMapId();
        if (tileId != null && tileId != "")
            loadMapTile();
        else
            AssetLoader2.Instance.LoadAsset("map/common", "common", typeof(TextAsset), onLoadMap);
#else
        AssetLoader2.Instance.LoadAsset("map/common", "common", typeof(TextAsset), onLoadMap);
#endif
    }
    void loadMapTile()
    {


        string targetPath = Application.streamingAssetsPath.Substring(0, Application.streamingAssetsPath.Length - 15) + "map/" + tileId + ".bytes";
        using (FileStream fs = new FileStream(targetPath, FileMode.Open))
        {
            byte[] data = new byte[fs.Length];
            fs.Read(data, 0, (int)fs.Length);
            ByteArray bt = new ByteArray(data);

            terrainMan.pathFinder.fillData(bt);

            
        }

    }
    void getMapId()
    {
#if UNITY_EDITOR
        string[] mapId_str_lst = EditorApplication.currentScene.Split('/');
        string curresid = mapId_str_lst[mapId_str_lst.Length - 1].Replace("_demol", "");
        curresid = curresid.Replace("_demo", "");
        curresid = curresid.Replace(".unity", "");
        string editFn = Application.dataPath + "/mapedit.info";
        if (File.Exists(editFn))
        {
            string mid = null, resid = null, tileid = null;
            using (StreamReader reader = new StreamReader(editFn))
            {
                while (!reader.EndOfStream)
                {
                    string line = reader.ReadLine();
                    string[] lines = line.Trim().Split('=');
                    if (lines.Length != 2)
                        continue;
                    if (lines[0] == "mapid")
                        mid = lines[1];
                    else if (lines[0] == "mapTileId")
                    {
                        tileid = lines[1];
                    }
                    else if (lines[0] == "mapResId")
                    {
                        resid = lines[1];
                    }
                }

            }
            if (resid == curresid)
            {
                mapId = mid;
                tileId = tileid;
                mapResId = resid;
            }

        }
#endif
    }
    void GoTo()
    {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;
        LayerMask nl = LayerConst.MASK_GROUND;
        if (Physics.Raycast(ray, out hit, 1500.0f, nl))
        {
            Debug.Log("hit point:" + hit.point);
            /*
            int startX = (int)(mainRole.transform.position.x / Constants.GRID_SIZE);
            int startZ = (int)(-mainRole.transform.position.z / Constants.GRID_SIZE);
            int endX = (int)(hit.point.x / Constants.GRID_SIZE);
            int endZ = (int)(-hit.point.z / Constants.GRID_SIZE);
             * */
            int startX = PathUtilEdit.Real2LogicX(mainRole.transform.position.x);
            int startZ = PathUtilEdit.Real2LogicZ(mainRole.transform.position.z);
            int endX = PathUtilEdit.Real2LogicX(hit.point.x);
            int endZ = PathUtilEdit.Real2LogicZ(hit.point.z);
            if (terrainMan == null)
                return;
           List<WalkStep> steps =  terrainMan.pathFinder.find(startX, startZ, endX, endZ, 1,true);
           if (steps == null)
           {
               //LoggerHelper.Debug("here the program come here find step==null  startX="+startX+",startZ="+startZ+",endX="+endX+",endZ="+endZ);
               Debug.Log("path not found");
               return;
           }
           mainRoleCtrl.DoWalk(steps);
           //LoggerHelper.Debug("here the player start walk,stepCount:"+steps.Count);
        }
    }
}
 
