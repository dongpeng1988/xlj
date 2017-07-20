
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEditor.Animations;
using System.Xml;
using sw.scene.ctrl;

public class BuildTool:ScriptableObject
    {
    [MenuItem("Assets/Update RoleController")]
    ///用来给角色的controller指定动画
    ///选中Z文件夹操作
    private static void UpdateRoleController()
    {
        string path = AssetDatabase.GetAssetPath(Selection.activeObject);
        foreach (string subPath in Directory.GetDirectories(path))
        {
            Debug.Log("adfadfadfadfa");
            string keyWord = subPath.Substring(path.Length + 1);
            string baseConPath = "Assets/ART/Role";
            switch (keyWord)
            {
                case "z_men1":
                    baseConPath += "/" + "menController.controller";
                    break;
                case "Z_woman1":
                    baseConPath += "/" + "women1Controller.controller";
                    break;
                case "z_women2":
                    baseConPath += "/" + "women2Controller.controller";
                    break;
            }
            AnimatorController baseController= AssetDatabase.LoadAssetAtPath(baseConPath, typeof(AnimatorController)) as AnimatorController;
            if (baseController == null)
                continue;
            string clipPath = subPath + "/Animation";
            AnimatorControllerLayer layer = baseController.layers[0];
            foreach (string fn in Directory.GetFiles(clipPath))
            {
                if (fn.IndexOf(".meta") > 0)
                    continue;
                AnimatorStateMachine sm = layer.stateMachine;
                AnimationClip curFbx = AssetDatabase.LoadAssetAtPath(fn, typeof(AnimationClip)) as AnimationClip;
                if (curFbx == null)
                    continue;
                string clipName = fn.Substring(fn.LastIndexOf("_") + 1, fn.LastIndexOf(".") - fn.LastIndexOf("_") - 1);
                if (clipName == "jineng2")
                    Debug.Log("afadfad");
                int stateLen = sm.states.Length;
                for (int xx = 0; xx < stateLen;xx++ )
                {
                    AnimatorState tempState = sm.states[xx].state;
                    if (clipName == tempState.name)
                    {
                        tempState.motion = curFbx;
                        break;
                    }
                }
            }
        }
    }
    static List<string> mRoleModelTypes = new List<string>()
    {
        "W"
    };
    static Dictionary<string, List<string>> mCreateControllerList = new Dictionary<string, List<string>>()
    {
        {"W",new List<string>(){
            "w_baierbingdaobing",
            "w_baiguyao",
            "W_bainianshimo",
            "w_canggurenyong",
            "w_daodouguaike",
            "w_daomushanzei",
            "w_duxiezi",
            "w_guiloumanzu",
            "w_huli",
            "w_jiangshi",
            "w_jushoushiguai",
            "w_libiegou",
            "w_mishuwushi",
            "w_moxiang",
            "w_muxueyouling",
            "w_muyao",
            "w_muyao_1",
            "w_qingwa",
            "W_quanzhenpanni",
            "w_queying",
            "w_shadao",
            "w_shahu",
            "w_shalang",
            "w_shamoxingjunyi",
            "w_shashu",
            "w_shixiangmoyv",
            "w_shuizuzhanshi",
            "w_xielingdaozei",
            "w_xieqian",
            "w_xinmayi",
            "w_youlingpuren"
            }
        }
    };
    [MenuItem("Assets/Create Controller")]
    ///用于自动创建继承controller
    ///主要都集中在Role文件夹下面
    ///根据文件名称自动创建对应的controller
    ///在Role文件夹上操作
    private static void createController()
    {
        string path = AssetDatabase.GetAssetPath(Selection.activeObject);
        foreach (string subPath in Directory.GetDirectories(path))
        {
            string keyWord = subPath.Substring(subPath.Length-1);
            //if (keyWord.Equals("B") || keyWord.Equals("N") || keyWord.Equals("W") || keyWord.Equals("C") || keyWord.Equals("Q") || keyWord.Equals("Y") || keyWord.Equals("F"))
            if (keyWord.Equals("W"))
            {
                string baseConPath = "";
                switch(keyWord)
                {
                    case "B"://Boss
                        baseConPath = path + "/" + "bossController.controller";
                        break;
                    case "N"://NPC
                        baseConPath = path + "/" + "npcController.controller";
                        break;
                    case "W"://怪物
                        baseConPath = path + "/" + "monsterController.controller";
                        break;
                    case "C"://宠物
                        baseConPath = path + "/" + "petController.controller";
                        break;
                    case "Q"://坐骑
                        baseConPath = path + "/" + "zuoqiController.controller";
                        break;
                    case "Y"://翅膀
                        baseConPath = path + "/" + "wingController.controller";
                        break;
                    case "F"://法宝
                        baseConPath = path + "/" + "fabaoController.controller";
                        break;
                    default:
                        continue;
                }
                List<string> targetModels;
                mCreateControllerList.TryGetValue(keyWord, out targetModels);

                AnimatorController baseController = null;
                if (false == string.IsNullOrEmpty(baseConPath))
                {
                    baseController = AssetDatabase.LoadAssetAtPath(baseConPath, typeof(AnimatorController)) as AnimatorController;
                }
                
                string[] resPath = Directory.GetDirectories(subPath);
                foreach (string resNamePath in resPath)
                {
                    string resName = resNamePath.Substring(subPath.Length + 1);

                    if (targetModels != null && false == targetModels.Contains(resName))
                    {
                        continue;
                    }

                    //Debug.Log(resName);
                    //continue;

                    string clipPath = resNamePath + "/Animation";

                    if (keyWord == "W")
                    {
                        bool hasFukong = false;
                        foreach (string fn in Directory.GetFiles(clipPath))
                        {
                            if (fn.IndexOf(".meta") > 0)
                                continue;
                            AnimationClip curFbx = AssetDatabase.LoadAssetAtPath(fn, typeof(AnimationClip)) as AnimationClip;
                            if (curFbx == null)
                                continue;

                            string clipName = fn.Substring(fn.LastIndexOf("_") + 1, fn.LastIndexOf(".") - fn.LastIndexOf("_") - 1);
                            if (clipName.IndexOf("fukong") != -1)
                            {
                                hasFukong = true;
                                break;
                            }
                        }

                        if (hasFukong)
                        {
                            baseConPath = path + "/" + "monsterNewFukongController.controller";
                        }
                        else
                        {
                            baseConPath = path + "/" + "monsterNewController.controller";
                        }
                        baseController = AssetDatabase.LoadAssetAtPath(baseConPath, typeof(AnimatorController)) as AnimatorController;
                    }

                    AnimatorOverrideController resNameController = new AnimatorOverrideController();
                    resNameController.runtimeAnimatorController = baseController;
                    
                    foreach (string fn in Directory.GetFiles(clipPath))
                    {
                        if (fn.IndexOf(".meta") > 0)
                            continue;
                        AnimationClip curFbx = AssetDatabase.LoadAssetAtPath(fn, typeof(AnimationClip)) as AnimationClip;
                        if (curFbx == null)
                            continue;
                        string clipName = fn.Substring(fn.LastIndexOf("_")+1,fn.LastIndexOf(".")-fn.LastIndexOf("_")-1);
                        if (keyWord.Equals("W") && clipName.IndexOf("fukong2")!=-1)
                        {
                            resNameController[clipName + "1"] = curFbx;
                            resNameController[clipName + "2"] = curFbx;
                        }
                        resNameController[clipName] = curFbx;
                    }
                    AssetDatabase.CreateAsset(resNameController, path + "/" + resName + ".overrideController");
                }
            }
        }
        AssetDatabase.SaveAssets();
    }
    [MenuItem("Assets/Create All Prefab (abandon)")]
    ///用于自动创建预设
    ///模型都在Role文件夹下面  主要针对npc、怪物、boss
    ///根据预设名称自动挂上相应的controller
    ///在Role文件夹上操作
    ///Y和F的要单独处理一下
    private static void createAllPrefab()
    {
        Debug.Log("can not use this, because this will be drop script");
        return;

        string path = AssetDatabase.GetAssetPath(Selection.activeObject);
        foreach (string subPath in Directory.GetDirectories(path))
        {
            string keyWord = subPath.Substring(subPath.Length - 1);
            if (keyWord.Equals("B") || keyWord.Equals("N") || keyWord.Equals("W") || keyWord.Equals("C") || keyWord.Equals("Q") || keyWord.Equals("Z") || keyWord.Equals("F") || keyWord.Equals("Y"))
            {
                string[] resPath = Directory.GetDirectories(subPath);
                foreach (string resNamePath in resPath)
                {
                    string resName = resNamePath.Substring(subPath.Length + 1);
                    string modelPath = resNamePath + "/Model";
                    string matPath = modelPath + "/Materials";
                    foreach (string matfn in Directory.GetFiles(matPath))
                    {
                        if (matfn.IndexOf(".meta") > 0)
                            continue;
                        Material mat = AssetDatabase.LoadAssetAtPath(matfn, typeof(Material)) as Material;
                        if (mat == null)
                            continue;
                        mat.shader=Shader.Find("Unlit/Texture");
                    }
                    foreach (string fn in Directory.GetFiles(modelPath))
                    {
                        if (fn.IndexOf(".meta") > 0)
                            continue;
                        GameObject go = AssetDatabase.LoadAssetAtPath(fn, typeof(GameObject)) as GameObject;
                        if (go == null)
                            continue;
                        string prefabName = fn.Substring(modelPath.Length + 1, fn.LastIndexOf("_") - modelPath.Length - 1);
                        go.name = prefabName;
                        string prefabPath = "Assets/prefab/model/" + prefabName.ToLower() + ".prefab";
                        Animator animator = go.GetComponent<Animator>();
                        if (animator == null)
                        {
                            Debug.Log("error:" + prefabName);
                        }
                        animator.applyRootMotion = false;
                        AnimatorOverrideController animatorController = AssetDatabase.LoadAssetAtPath(path + "/" + resName + ".overrideController", typeof(AnimatorOverrideController)) as AnimatorOverrideController;
                        if (animatorController != null)
                        {
                            animator.runtimeAnimatorController = animatorController;
                            GameObject tempPrefab=AssetDatabase.LoadAssetAtPath(prefabPath,typeof(GameObject)) as GameObject;
                            if (tempPrefab == null)
                                PrefabUtility.CreatePrefab(prefabPath, go);
                        }
                        else
                        {
                            //string resName2 = "";
                            //if(resName.IndexOf("z_men1")!=-1)
                            //    resName2 += "menController";
                            //else if(resName.IndexOf("woman1")!=-1)
                            //   resName2 += "women1Controller";
                            //else if(resName.IndexOf("women2")!=-1)
                            //    resName2 += "women2Controller";
                            //AnimatorController zhujiao = AssetDatabase.LoadAssetAtPath(path + "/" + resName2 + ".Controller", typeof(AnimatorController)) as AnimatorController;
                            //animator.runtimeAnimatorController = zhujiao;
                            //这个慎用  人物的RoleData会被清空
                        }
                    }
                }
            }
        }
        AssetDatabase.SaveAssets();
    }
    static readonly string MODEL_BASE_ROOT_PATH = "Assets/ART/Role/";
    static readonly string[] MODEL_ROOT_PATHS = new string[9]
        {
            MODEL_BASE_ROOT_PATH + "B/",
            MODEL_BASE_ROOT_PATH + "C/",
            MODEL_BASE_ROOT_PATH + "F/",
            MODEL_BASE_ROOT_PATH + "N/",
            MODEL_BASE_ROOT_PATH + "Q/",
            MODEL_BASE_ROOT_PATH + "W/",
            MODEL_BASE_ROOT_PATH + "wuqi/",
            MODEL_BASE_ROOT_PATH + "Y/",
            MODEL_BASE_ROOT_PATH + "Z/"
        };
    static string GetModelPath(string path)
    {
        foreach (string rootpath in MODEL_ROOT_PATHS)
        {
            if (path.StartsWith(rootpath))
            {
                string nextpath = path.Remove(0, rootpath.Length);
                int index = nextpath.IndexOf("/");
                nextpath = index > 0 ? nextpath.Substring(0, index) : nextpath;

                string respath = rootpath + nextpath;
                return respath;
            }
        }
        return null;
    }
    [MenuItem("Assets/Create Prefab")]
    private static void createPrefab()
    {
        string path = AssetDatabase.GetAssetPath(Selection.activeObject);
        Debug.Log(path);
        string modelpath = GetModelPath(path);
        Debug.Log(modelpath);
        if (string.IsNullOrEmpty(modelpath))
        {
            Debug.Log("please select model path!");
            return;
        }

        return;
        //string resName = resPath.Substring(resPath.Length + 1);
        //string modelPath = resNamePath + "/Model";
        //string matPath = modelPath + "/Materials";
        //Debug.Log("resNamePath: " + resNamePath);
        //Debug.Log("resName: " + resName);
        //Debug.Log("modelPath: " + modelPath);
        //Debug.Log("matPath: " + matPath);
        //Debug.Log("=============");

        //foreach (string matfn in Directory.GetFiles(matPath))
        //{
        //    if (matfn.IndexOf(".meta") > 0)
        //        continue;
        //    Material mat = AssetDatabase.LoadAssetAtPath(matfn, typeof(Material)) as Material;
        //    if (mat == null)
        //        continue;
        //    mat.shader = Shader.Find("Unlit/Texture");
        //}
        //foreach (string fn in Directory.GetFiles(modelPath))
        //{
        //    if (fn.IndexOf(".meta") > 0)
        //        continue;
        //    GameObject go = AssetDatabase.LoadAssetAtPath(fn, typeof(GameObject)) as GameObject;
        //    if (go == null)
        //        continue;
        //    string prefabName = fn.Substring(modelPath.Length + 1, fn.LastIndexOf("_") - modelPath.Length - 1);
        //    go.name = prefabName;
        //    string prefabPath = "Assets/prefab/model/" + prefabName.ToLower() + ".prefab";
        //    Animator animator = go.GetComponent<Animator>();
        //    if (animator == null)
        //    {
        //        Debug.Log("error:" + prefabName);
        //    }
        //    animator.applyRootMotion = false;
        //    AnimatorOverrideController animatorController = AssetDatabase.LoadAssetAtPath(path + "/" + resName + ".overrideController", typeof(AnimatorOverrideController)) as AnimatorOverrideController;
        //    if (animatorController != null)
        //    {
        //        animator.runtimeAnimatorController = animatorController;
        //        GameObject tempPrefab = AssetDatabase.LoadAssetAtPath(prefabPath, typeof(GameObject)) as GameObject;
        //        if (tempPrefab == null)
        //            PrefabUtility.CreatePrefab(prefabPath, go);
        //    }
        //    else
        //    {
        //        //string resName2 = "";
        //        //if(resName.IndexOf("z_men1")!=-1)
        //        //    resName2 += "menController";
        //        //else if(resName.IndexOf("woman1")!=-1)
        //        //   resName2 += "women1Controller";
        //        //else if(resName.IndexOf("women2")!=-1)
        //        //    resName2 += "women2Controller";
        //        //AnimatorController zhujiao = AssetDatabase.LoadAssetAtPath(path + "/" + resName2 + ".Controller", typeof(AnimatorController)) as AnimatorController;
        //        //animator.runtimeAnimatorController = zhujiao;
        //        //这个慎用  人物的RoleData会被清空
        //    }
        //}
    }
    /// <summary>
    /// 设置模型预设的Render
    /// </summary>
     [MenuItem("Assets/TempSetting")]
    private static void TempSetting()
    {
        string path = AssetDatabase.GetAssetPath(Selection.activeObject);
        foreach (string subPath in Directory.GetDirectories(path))
        {
            string keyWord = subPath.Substring(subPath.Length - 1);
            if (keyWord.Equals("B") || keyWord.Equals("N") || keyWord.Equals("W") || keyWord.Equals("C"))
            {
                string[] resPath = Directory.GetDirectories(subPath);
                foreach (string resNamePath in resPath)
                {
                    string resName = resNamePath.Substring(subPath.Length + 1);
                    string prefabPath = "Assets/prefab/model/" + resName.ToLower() + ".prefab";
                    GameObject tempPrefab = AssetDatabase.LoadAssetAtPath(prefabPath, typeof(GameObject)) as GameObject;
                    if(tempPrefab!=null)
                    {
                        Transform tempTrans = tempPrefab.transform.Find(resName);
                        if(tempTrans!=null)
                        {
                            //Renderer tempRen = tempTrans.GetComponent<Renderer>();
                            //RenderTexture tempRT = tempTrans.GetComponent<RenderTexture>();
                            SkinnedMeshRenderer tempMR = tempTrans.GetComponent<SkinnedMeshRenderer>();
                            tempMR.receiveShadows = false;
                            //if(keyWord.Equals("N") || keyWord.Equals("W"))
                            //{
                            //    tempMR.shadowCastingMode = 
                            //}
                        }
                    }
                }
            }
        }
    }
    [MenuItem("Assets/Update AssetBundle")]
    private static void UpdateAssetBundle()
    {
        string path = AssetDatabase.GetAssetPath(Selection.activeObject);
        Debug.Log("path:" + path);
        foreach (string fn in Directory.GetFiles(path))
        {
            if (fn.IndexOf(".meta") > 0)
                continue;

            string fn2 = fn.Replace('\\', '/');
            string aname = fn.Substring(path.Length + 1);
            aname = aname.Substring(0, aname.IndexOf("."));
            Debug.Log(fn2);
            AssetImporter importer = AssetImporter.GetAtPath(fn2);
            Debug.Log("importer:" + importer);
            if (path.IndexOf("map") != -1)
                importer.assetBundleName = "map/" + aname;
            else if(path.IndexOf("Scene")!=-1)
                importer.assetBundleName = "scene/" + aname;
            else
                importer.assetBundleName = aname;
        }
        //AssetImporter importer =   AssetImporter.GetAtPath(path);
        //importer.assetBundleName = "test";
    }
    [MenuItem("Build/更新角色阴影设置")]
    private static void UpdatePlayerShadow()
    {
        string path = Application.dataPath + "/prefab/model";
        int prefixlen = Application.dataPath.Length - "Assets".Length;
        foreach (string fn in Directory.GetFiles(path, "*.prefab"))
        {
            string scenename = fn.Substring(prefixlen);
            Debug.Log("fn:" + scenename);
           GameObject obj =   AssetDatabase.LoadAssetAtPath(scenename,typeof(GameObject)) as GameObject;
           foreach(MeshRenderer mr in  obj.GetComponentsInChildren<MeshRenderer>())
           {
               Debug.Log("mr:" + mr);
               mr.receiveShadows = false;
               mr.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.On;
           }
            
           break;
        }
        AssetDatabase.SaveAssets();
    }
    [MenuItem("Build/更新场景阴影设置")]
    private static void UpdateSceneShadow()
    {
        string path = Application.dataPath + "/ART/Scene";
        int prefixlen = Application.dataPath.Length - "Assets".Length;
        foreach(string fn in Directory.GetFiles(path,"*.unity"))
        {
            
            string scenename = fn.Substring(prefixlen);
            Debug.Log("fn:" + scenename);
            bool ret = EditorApplication.OpenScene(scenename);
            foreach(MeshRenderer mr in GameObject.FindObjectsOfType<MeshRenderer>())
            {
                if(mr.gameObject.layer == 13 || mr.gameObject.layer == 19)
                {
                    mr.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                    mr.receiveShadows = true;
                }
                else
                {
                    mr.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                    mr.receiveShadows = false;
                }
            }
            EditorApplication.SaveScene();
           
        }
    }
    static string getBundleName(string path)
    {
        string aname = path.Substring(path.LastIndexOf("/") + 1);
        aname = aname.Substring(0, aname.IndexOf("."));
        return aname;
    }
    static Bounds GetBounds(GameObject go)
    {
        Bounds rect = new Bounds();
        if (go.GetComponent<MeshRenderer>() != null)
            rect = go.GetComponent<MeshRenderer>().bounds;

       foreach(MeshRenderer r in  go.GetComponentsInChildren<MeshRenderer>())
       {
           rect.Encapsulate(r.bounds);
       }
       return rect;
    }
    [MenuItem("Build/ClearLOD")]
    static void ClearLOD()
    {
        LODLoader[] rs = SceneView.FindObjectsOfType<LODLoader>();
        foreach(LODLoader l in rs)
        {
            int cnt = l.transform.childCount;
            for (int i = 0; i < cnt; i++)
                GameObject.DestroyImmediate(l.transform.GetChild(0).gameObject);
        }
    }
    class psoData
    {
        public Vector3 localPosition;
        public Quaternion localRotation;
        public Vector3 localScale;
        public Transform tran;
        public Transform parent;
    }
    static void UpdateLODObj(GameObject o, psoData p = null)
    {
 
        if (!o.activeSelf)
        {
            Debug.LogError("invalid o:" + o.name);
            return;
        }
        Object prefab = PrefabUtility.GetPrefabParent(o);
        if (prefab == null)
        {
            Transform tran = o.transform;
            if (tran.childCount == 0 || tran.gameObject.GetComponent<LODLoader>()!=null)
            {
                tran.parent = tran.parent == null ? p.parent : tran.parent;
                return;
            }
            psoData[] subs = new psoData[tran.childCount];
            int index=0;
            int maxinde = 0;
            while (tran.childCount != maxinde)
            {
                psoData subtran=new psoData();
                subtran.tran = tran.GetChild(maxinde);
                if (subtran.tran.childCount!=0)
                {
                    UpdateLODObj(subtran.tran.gameObject, subtran);
                    maxinde++;
                    continue;
                }
                subtran.localPosition = subtran.tran.localPosition;
                subtran.localRotation = subtran.tran.localRotation;
                subtran.localScale = subtran.tran.localScale;
                subtran.parent = subtran.tran.parent;
                subs[index] = subtran;
                subtran.tran.parent = null;
                index++;
            }
            if (tran.parent == null && p != null)
            {
                tran.parent = tran.parent == null ? p.parent : tran.parent;
                tran.localPosition = p.localPosition;
                tran.rotation = p.localRotation;
                tran.localScale = p.localScale;
            }
            foreach (psoData sub in subs)
            {
                if(sub!=null)
                    UpdateLODObj(sub.tran.gameObject, sub);
            }
            return;
        }
        GameObject root = PrefabUtility.FindPrefabRoot(o);
        if (root != o)
            return;
        Debug.Log("asset path:" + prefab + "," + AssetDatabase.GetAssetPath(prefab) + ",root:" + root);
        string assetPath = AssetDatabase.GetAssetPath(prefab);
        if (assetPath == "")
            return;
        AssetImporter im = AssetImporter.GetAtPath(assetPath);

        Debug.Log("im name:" + im.assetBundleName);
        //if (im.assetBundleName == "")
        //{
            string[] paths = assetPath.Split('/');
            string savePath = "";
            for (int i = 2; i < paths.Length;i++ )
            {
                savePath = savePath+(i + 1 != paths.Length ? (paths[i] + "/") : paths[i]);
            }
            im.assetBundleName = savePath;

            Debug.Log("ADD  assetBundleName:" + assetPath);
            //Debug.LogWarning("has no assetbundle name:" + assetPath);
            //return;
        //}
        if (o.transform.parent != null)
        {
            LODLoader loader = o.transform.parent.GetComponent<LODLoader>();
            if (loader != null)
            {
                loader.setPath(im.assetBundleName); 
                //loader.assetName = prefab.name;
                loader.bounds = GetBounds(o);
                return;
            }

        }
        //带碰撞
        if (o.GetComponent<BoxCollider>() != null || o.GetComponent<MeshCollider>() != null)
        {
            o.transform.parent = p.parent == null ? p.parent : p.parent;
            o.transform.localPosition = p.localPosition;
            o.transform.rotation = p.localRotation;
            o.transform.localScale = p.localScale;
            return;
        }
        GameObject go = new GameObject(o.name + "-lod");

        Transform tparent = p.parent==null?o.transform.parent:p.parent;
        Vector3 pos = p.localPosition;
        Quaternion rot =p.localRotation;
        Vector3 scale = p.localScale;

        o.transform.SetParent(go.transform);
        o.transform.localScale = Vector3.one;
        o.transform.localPosition = Vector3.zero;
        o.transform.rotation = Quaternion.identity;
        //o.AddComponent<PrefabLightmapData>();

        go.transform.SetParent(tparent);
        go.transform.localScale = scale;
        go.transform.localPosition = pos;
        go.transform.rotation = rot;

        LODLoader loader2 = go.AddComponent<LODLoader>();
        loader2.setPath(im.assetBundleName);
        //loader2.assetName = prefab.name;
        loader2.bounds = GetBounds(o);
        loader2.saveLitMap(o);
        lm.addAcTion(loader2);
        GameObject.DestroyImmediate(o);
    }
    static LodManager lm;
    [MenuItem("Build/UpdateLOD")]
    static void UpdateLOD()
    {
        GameObject root = Selection.activeGameObject;
        Debug.Log("root:" + root);
        lm = root.GetComponent<LodManager>();
        UpdateLODObj(root);
        //GameObject[] rs = SceneView.FindObjectsOfType<GameObject>();
        //Debug.Log("activeobject:" + rs.Length);
        //foreach (GameObject o in rs)
        //{
            
        //}
        AssetDatabase.Refresh();
        //GameObject go = new GameObject("test");
        //Selection.activeGameObject.transform.SetParent(go.transform);

    }
     
   // static string[] AssetDirs = { "prefab/model", "prefab/fx", "map", "Scene", "Scene/Model", "Scene/Texture", "Scene/prefab" };
    /// <summary>
    /// 对应的model、fx在prefab上操作
    /// map在map上操作
    /// Scenen开头的在Art上操作(场景)
    /// </summary>
    //static string[] AssetDirs = { "model", "fx", "map", "Scene", "Scene/Model", "Scene/Texture", "Scene/prefab" };
    [MenuItem("Build/Stat All Model")]
    static void StatAllAssetModel()
    {
        //string scenePath = "Assets/ART/Scene\\";
        string prefabFxPath = "Assets/prefab/fx/";
        string prefabModelPath = "Assets/prefab/model/";
        //string mapPath = "Assets/map\\";
        string info = "";
        //info +=doStat(scenePath);
        info += doStat(prefabFxPath);
        info += doStat(prefabModelPath);
        //info += doStat(mapPath);
        using(FileStream fs = new FileStream(Application.dataPath+"/allModel.txt",FileMode.OpenOrCreate,FileAccess.Write))
        {
            byte[] data = Encoding.UTF8.GetBytes(info);
            fs.Write(data,0,data.Length);
        }
    }
    private static string doStat(string path)
    {
        string info = "";
        foreach (string fn in Directory.GetFiles(path))
        {
            if (fn.IndexOf(".meta") > 0)
                continue;

            string fn2 = fn.Replace('\\', '/');
            string aname = fn.Substring(path.Length);
            int endIndex = path.LastIndexOf("/");
            int startIndex = path.LastIndexOf("/", endIndex - 1);
            string fatherName = path.Substring(startIndex + 1, endIndex - startIndex - 1);
            aname = aname.Substring(0, aname.IndexOf("."));
            AssetImporter importer = AssetImporter.GetAtPath(fn2);
            if (!string.IsNullOrEmpty(importer.assetBundleName))
                info += aname + "," + importer.assetBundleName + "\n";

           
        }
        return info;
    }
    static string[] AssetDirs = { "model", "fx", "map", "Scene"};
    [MenuItem("Build/Update All AssetBundle")]
    static void UpdateAllAssetBundle()
    {
        string scenePath = "Assets/ART/Scene/";
        string sceneModel = "Assets/ART/Scene/Model/";
        string scenePrefab = "Assets/ART/Scene/prefab/";

        string prefabFxPath = "Assets/prefab/fx/";
        string prefabModelPath = "Assets/prefab/model/";
        string mapPath = "Assets/map/";
        doUpdate(scenePath);
        doUpdate(sceneModel);
        doUpdate(scenePrefab);

        doUpdate(prefabFxPath);
        doUpdate(prefabModelPath);
        doUpdate(mapPath);
        string controllerPath = "Assets/ART/Role/";
        doUpdate(controllerPath);
    }
    private static void doUpdate(string path,bool clear=false)
    {
        foreach (string fn in Directory.GetFiles(path))
        {
            if (fn.IndexOf(".meta") > 0)
                continue;
            if (fn.IndexOf("overrideController") != -1)
                continue;
            if (fn.IndexOf("controller") != -1 && fn.IndexOf("men") == -1)
                continue;
            string fn2 = fn.Replace('\\', '/');
            string aname = fn.Substring(path.Length);
            int endIndex = path.LastIndexOf("/");
            int startIndex = path.LastIndexOf("/", endIndex-1);
            
            string fatherName = path.Substring(startIndex + 1, endIndex - startIndex - 1);
            aname = aname.Substring(0, aname.IndexOf("."));
            AssetImporter importer = AssetImporter.GetAtPath(fn2);
            Debug.Log("importer:" + fatherName + "/" + aname );
            if (clear)
                importer.assetBundleName = null;
            else
            {
                if (path.IndexOf("Scene/Model") != -1)
                {
                    fatherName = "Scene/Model";
                    importer.assetBundleName = null;
                    continue;
                }
                if (path.IndexOf("Scene/prefab") != -1)
                {
                    fatherName = "Scene/prefab";
                   
                }
                importer.assetBundleName = fatherName + "/" + aname ;
            }
        }
    }
    /// <summary>
    /// Scenen开头的在Art上操作(场景)
    /// </summary>
    static string[] clearAssetDirs = {"Scene/Model", "Scene/Texture", "Scene/prefab" };
    [MenuItem("Assets/Clear AssetBundle")]
    static void ClearAssetBundle()
    {
        string path = AssetDatabase.GetAssetPath(Selection.activeObject);
        string dirpre = Application.dataPath;
        int dirprelen = dirpre.Length - 6;
        dirpre = dirpre.Substring(0, dirprelen);
        Debug.Log("search path:" + dirpre + path);
        foreach (string subd in clearAssetDirs)
        {
            string subpath = Path.Combine(path, subd);
            if (!Directory.Exists(subpath))
            {
                Debug.Log("path not exists:" + subpath);
                continue;
            }
            foreach (string fn in Directory.GetFiles(subpath))
            {
                if (fn.IndexOf(".meta") > 0)
                    continue;

                string fn2 = fn.Replace('\\', '/');
                string aname = fn.Substring(path.Length + 1);
                aname = aname.Substring(0, aname.IndexOf("."));
                Debug.Log(fn2);
                AssetImporter importer = AssetImporter.GetAtPath(fn2);
                importer.assetBundleName = null;
            }
        }
    }
    [MenuItem("Build/Clear All AssetBundle")]
    static void ClearAllAssetBundle()
    {
        string rootPath = "Assets/";
        doClearAB(rootPath);
    }
    private static void doClearAB(string path)
    {
        if (path.IndexOf("Scripts") != -1)
            return;
        foreach (string fn in Directory.GetFiles(path))
        {
            if (fn.IndexOf(".meta") > 0||fn.IndexOf(".cs")>0)
                continue;
            AssetImporter importer = AssetImporter.GetAtPath(fn);
            if(importer != null)
                importer.assetBundleName = null;
        }
        foreach (string subPath in Directory.GetDirectories(path))
        {
            doClearAB(subPath+"/");
        }
    }
    [MenuItem("Assets/Clear AssetBundle SceneFBX")]
    static void ClearAssetBundle_SceneFBX()
    {
        doClearAB("Assets/ART/Scene/Model", ".FBX");
    }
    private static void doClearAB(string path, string exname)
    {
        if (path.IndexOf("Scripts") != -1)
            return;
        foreach (string fn in Directory.GetFiles(path))
        {
            if (fn.IndexOf(".meta") > 0 || fn.IndexOf(".cs") > 0)
                continue;
            if (false == string.IsNullOrEmpty(exname))
            {
                if (false == fn.EndsWith(exname))
                    continue;
            }
            //Debug.Log(fn);
            //continue;
            AssetImporter importer = AssetImporter.GetAtPath(fn);
            if (importer != null)
                importer.assetBundleName = null;
        }
        foreach (string subPath in Directory.GetDirectories(path))
        {
            doClearAB(subPath + "/");
        }
    }
#if UNITY_EDITOR
    public static string GetPlatformFolderForAssetBundles(BuildTarget target)
    {
        switch (target)
        {
            case BuildTarget.Android:
                return "Android";
            case BuildTarget.iOS:
                return "iOS";
            case BuildTarget.WebPlayer:
                return "WebPlayer";
            case BuildTarget.StandaloneWindows:
            case BuildTarget.StandaloneWindows64:
                return "Windows";
            case BuildTarget.StandaloneOSXIntel:
            case BuildTarget.StandaloneOSXIntel64:
            case BuildTarget.StandaloneOSXUniversal:
                return "OSX";
            // Add more build targets for your own.
            // If you add more targets, don't forget to add the same platforms to GetPlatformFolderForAssetBundles(RuntimePlatform) function.
            default:
                return null;
        }
    }
#endif

    const string kAssetBundlesOutputPath = "AssetBundles";
     [MenuItem("Build/AssetBundles")]
    public static void BuildAssetBundles()
    {
        // Choose the output path according to the build target.
        string outputPath = Path.Combine(Path.Combine(kAssetBundlesOutputPath, GetPlatformFolderForAssetBundles(EditorUserBuildSettings.activeBuildTarget)), "res");
        if (!Directory.Exists(outputPath))
            Directory.CreateDirectory(outputPath);
        Debug.Log("11111111"+outputPath);
        BuildPipeline.BuildAssetBundles(outputPath, BuildAssetBundleOptions.DeterministicAssetBundle | BuildAssetBundleOptions.IgnoreTypeTreeChanges, EditorUserBuildSettings.activeBuildTarget);
    }
     [MenuItem("Build/RebuildAssetBundles")]
    public static void ReBuildAssetBundles()
    {
        // Choose the output path according to the build target.
        string outputPath =Path.Combine( Path.Combine(kAssetBundlesOutputPath, GetPlatformFolderForAssetBundles(EditorUserBuildSettings.activeBuildTarget)),"res");
        if (!Directory.Exists(outputPath))
            Directory.CreateDirectory(outputPath);

        BuildPipeline.BuildAssetBundles(outputPath, BuildAssetBundleOptions.ForceRebuildAssetBundle, EditorUserBuildSettings.activeBuildTarget);
    }
    /// <summary>
    /// 这个方法是用来提取场景里面的公共资源
    /// 所有是在Scene文件夹上面操作的
    /// </summary>
     [MenuItem("Assets/TestAssetBundles")]
     public static void TestAssetBundles()
     {
         string path = AssetDatabase.GetAssetPath(Selection.activeObject);
         string[] levels = new string[]{};
         ArrayUtility tempArr = new ArrayUtility();
         Dictionary<string, string> shareObject = new Dictionary<string, string>();//共用的资源
         Dictionary<int, string> pathDic = new Dictionary<int, string>();//存所有资源的路径
         int xx = 0;
         foreach (string fn in Directory.GetFiles(path))//遍历所有的场景文件
         {
             if (fn.IndexOf(".unity") == -1||fn.IndexOf(".meta")>0)
                 continue;
             Debug.Log(fn);
             ArrayUtility.Add<string>(ref levels,fn);


             EditorApplication.OpenScene(fn);
             GameObject[] gos = (GameObject[])FindObjectsOfType(typeof(GameObject));
             foreach (GameObject go in gos)
             {
                 UnityEngine.Object parentObject = PrefabUtility.GetPrefabParent(go);//找到场景中引用的资源
                 string parentPath = AssetDatabase.GetAssetPath(parentObject);//找到引用资源的路径、如果没有路径说明不是引用的
                 if (parentObject == null)
                 {
                     Debug.Log("dddd");//不是引用类型
                     continue;
                 }
                 else
                 {
                     //主要是公共模型
                     //if (pathDic.ContainsValue(parentPath))//说明这个资源是公用的,更新sharedObject
                     //{
                     //    if(shareObject.ContainsKey(parentPath))//公共资源中已经存在了该key，更新value
                     //    {
                     //        string scenesName = shareObject[parentPath];
                     //        if (scenesName.IndexOf(fn) == -1)
                     //            scenesName = scenesName + "," + fn;//场景名称不在里面加入进去
                     //        shareObject[parentPath] = scenesName;
                     //    }
                     //    else
                     //    {
                     //        shareObject[parentPath] = fn;
                     //    }
                     //}
                     //else
                     //{
                     //    pathDic[xx] = parentPath;
                     //    xx++;
                     //}
                     //提取公共贴图
                     MeshRenderer mat = go.GetComponent<MeshRenderer>();
                     if (mat == null)
                         continue;
                     Material[] mates = mat.sharedMaterials;
                     foreach(Material tempM in mates)
                     {
                         if (tempM == null)
                             continue;
                         Shader tempShader = tempM.shader;
                         for(int i=0;i<ShaderUtil.GetPropertyCount(tempShader);i++)
                         {
                             if (ShaderUtil.GetPropertyType(tempShader, i) == ShaderUtil.ShaderPropertyType.TexEnv)
                             {
                                 string propertyName = ShaderUtil.GetPropertyName(tempShader, i);
                                 Texture tex = tempM.GetTexture(propertyName);
                                 if (tex == null)
                                     continue;
                                 string texPath = AssetDatabase.GetAssetPath(tex.GetInstanceID());
                                 if (pathDic.ContainsValue(texPath))//说明这个贴图是公用的,更新sharedObject
                                 {
                                     if (shareObject.ContainsKey(texPath))//公共贴图中已经存在了该key，更新value
                                     {
                                         string scenesName = shareObject[texPath];
                                         if (scenesName.IndexOf(fn) == -1)
                                             scenesName = scenesName + "," + fn;//场景名称不在里面加入进去
                                         shareObject[texPath] = scenesName;
                                     }
                                     else
                                     {
                                         shareObject[texPath] = fn;
                                     }
                                 }
                                 else
                                 {
                                     pathDic[xx] = texPath;
                                     xx++;
                                 }
                             }
                         }
                     }
                 }
             }
         }
         //打包这些公共资源
             //static string[] AssetDirs = { "model", "fx", "map", "Scene", "Scene/Model", "Scene/Texture", "Scene/prefab" };
         //输出这些公共资源
         XmlDocument doc = new XmlDocument();
         XmlDeclaration dec = doc.CreateXmlDeclaration("1.0", "GB2312", null);
         doc.AppendChild(dec);
         XmlElement root = doc.CreateElement("sharedObject");
         doc.AppendChild(root);
         int totalShared = 0;
         foreach (var user in shareObject)
         {
             if (user.Value.Split(',').Length < 2)
                 continue;
             updateShareAssetBundle(user.Key);
             totalShared++;
             XmlNode node = doc.CreateElement("sharedObject");
             //创建用户名节点
             XmlElement element1 = doc.CreateElement("resPath");
             element1.InnerText = user.Key;
             node.AppendChild(element1);
             //创建密码节点
             XmlElement element2 = doc.CreateElement("sceneName");
             element2.InnerText = user.Value;
             node.AppendChild(element2);
             root.AppendChild(node);
         }
         doc.Save(@"d:\aaaaa.xml");
         Debug.Log("totalNum:"+totalShared);
         //BuildPipeline.BuildStreamedSceneAssetBundle(levels, "streamed.unity3d", EditorUserBuildSettings.activeBuildTarget);
     }
    private static void updateShareAssetBundle(string path)
     {
         int indexSplit = path.IndexOf("Scene");
         if (indexSplit == -1)
             return;
         string aname = path.Substring(indexSplit);
         aname = aname.Substring(0, aname.IndexOf("."));
         AssetImporter importer = AssetImporter.GetAtPath(path);
         Debug.Log("importer:" + importer);
         importer.assetBundleName = aname ;
         //importer.assetBundleName = null;
     }
    static void checkTexture(GameObject owner,Texture t)
     {
         if (t == null)
             return;
        if(t.width>256 || t.height >256)
        {
            Debug.LogWarning("large texture size:" + AssetDatabase.GetAssetPath(t)+",width:"+t.width+",height:"+t.height+",owner:"+AssetDatabase.GetAssetPath(owner));
        }
     }
      [MenuItem("Assets/CheckRes")]
    static void CheckRes()
     {
         if (Selection.activeGameObject == null)
             return;
         Debug.Log("obj:"+ Selection.activeGameObject);
         GameObject go = Selection.activeGameObject;
         Renderer[] renderers = go.GetComponentsInChildren<Renderer>(true);
         //Debug.Log("render cnt:" + renderers.Length+","+go.GetComponent<Renderer>());
        foreach(Renderer r in renderers)
        {
           // Debug.Log("share:" + r.sharedMaterial);
            if(r.sharedMaterial != null)
            {
                string tpath = AssetDatabase.GetAssetPath(r.sharedMaterial.mainTexture);
                checkTexture(go,r.sharedMaterial.mainTexture);
                Debug.Log("texture path:" + tpath);
            }
        }
     }
      const string FxPath = "Assets/Resources/fx";

     [MenuItem("Build/CheckAllFx")]
    static void CheckAllFx()
      {
          Dictionary<string, HashSet<string>> textureCnt = new Dictionary<string, HashSet<string>>();
          HashSet<string> shaders = new HashSet<string>();
         foreach(string d in Directory.GetFiles(FxPath))
         {
             if (d.IndexOf(".meta") > 0)
                 continue;
             GameObject go = AssetDatabase.LoadAssetAtPath(d, typeof(GameObject)) as GameObject;
             if (go  != null)
             {
                 List<Renderer> renderers = new List<Renderer>();
                 go.GetComponentsInChildren<Renderer>(true, renderers);
                 Renderer selfr = go.GetComponent<Renderer>();
                 if (selfr != null)
                     renderers.Add(selfr);
                // Debug.Log("render cnt:" + renderers.Count);
                 foreach (Renderer r in renderers)
                 {
                     // Debug.Log("share:" + r.sharedMaterial);
                     if (r.sharedMaterial != null)
                     {
                         shaders.Add(r.sharedMaterial.shader.name);
                          if (r.sharedMaterial.mainTexture == null)
                          {
                              if (!(r is TrailRenderer))
                                  Debug.LogWarning("null texture prefab:"+d+",obj:"+r.gameObject.name);
                              continue;
                          }
                         string tpath = AssetDatabase.GetAssetPath(r.sharedMaterial.mainTexture);
                        
                         if (!textureCnt.ContainsKey(tpath))
                         {
                             textureCnt[tpath]  = new HashSet<string>();
                             
                         }
                         textureCnt[tpath].Add(d);
                      
                         checkTexture(go, r.sharedMaterial.mainTexture);
                        // Debug.Log("texture path:" + tpath);
                     }
                 }
             }
         }
         StringBuilder sb = new StringBuilder();
         sb.Append("duplicate texture:\n ");
         foreach(KeyValuePair<string,HashSet<string>> pair in textureCnt)
         {
             if(pair.Value.Count>1)
             {
                 
                 sb.Append("\t").Append(pair.Key).Append("=").Append(pair.Value.Count).Append("\n");
                 foreach(string k in pair.Value)
                 {
                     sb.Append("\t\t").Append(k).Append("\n");
                 }
                 AssetImporter importer = AssetImporter.GetAtPath(pair.Key);
                 string aname = pair.Key;
                 aname = aname.Replace('\\','/');

                 aname = aname.Substring(aname.LastIndexOf("/")+1);
                 aname = aname.Substring(0, aname.IndexOf("."));
                 importer.assetBundleName ="fx/texture/"+ aname ;
             }
             else
             {
                 AssetImporter importer = AssetImporter.GetAtPath(pair.Key);
      
                 importer.assetBundleName = null;
             }
         }
         sb.Append("used shaders:\n");
         if(shaders.Count>0)
         {
             string[] strs = new string[shaders.Count];
             shaders.CopyTo(strs);
             sb.Append(string.Join("\n",strs));

         }
         AssetDatabase.SaveAssets();
         if (!Directory.Exists("tmp"))
             Directory.CreateDirectory("tmp");
         using(FileStream fs =new FileStream("tmp/checkres.txt",FileMode.Create))
         {
             byte[] data = Encoding.UTF8.GetBytes(sb.ToString());
             fs.Write(data,0,data.Length);
         }
         Debug.Log("check end,read result from file:tmp/checkres.txt");
         //Debug.Log(sb.ToString());
      }

    [MenuItem("Build/CreateHLM")]
     static void CreateHLM()
     {
         Debug.Log("start to create HLM");

         edittile.createTile();

         Debug.Log("finish creating HLM");
     }
    /// <summary>
    /// 设置特效贴图的压缩格式
    /// </summary>
    [MenuItem("Build/setCompress")]
    static void setCompress()
    {
        string scenePath = "Assets/ART/Effect/Role/Textures/";
        foreach (string subPath in Directory.GetDirectories(scenePath))
        {
            foreach (string fn in Directory.GetFiles(subPath))
            {
                if (fn.IndexOf(".meta") > 0 || fn.IndexOf(".cs") > 0)
                    continue;
                Texture2D picPng = AssetDatabase.LoadAssetAtPath(fn, typeof(Texture2D)) as Texture2D;
                if (picPng != null)
                {
                    EditorUtility.CompressTexture(picPng, TextureFormat.RGBA32, TextureCompressionQuality.Best);
                    EditorUtility.CompressTexture(picPng, TextureFormat.ETC2_RGBA8, TextureCompressionQuality.Best);
                    Debug.Log("adfadfa");
                    return;
                }
            }
        }
    }
    /// <summary>
    /// 设置模型的相关属性 压缩模型
    /// </summary>
    static string[] modelAssetDirs = { "Animation", "Model" };
    [MenuItem("Build/compressModel")]
    static void compressModel()
    {
        string scenePath = "Assets/ART/Role/";
        foreach (string subPath in Directory.GetDirectories(scenePath))
        {
            foreach (string subSubPath in Directory.GetDirectories(subPath))
            {
                foreach (string subd in modelAssetDirs)
                {
                    if (subSubPath.IndexOf("wuqi") != -1 || subSubPath.IndexOf("skill")!=-1)
                    {

                    }
                    else
                    {
                        string modelPath = Path.Combine(subSubPath, subd);
                        foreach (string fn in Directory.GetFiles(modelPath))
                        {
                            if (fn.IndexOf(".meta") > 0 || fn.IndexOf(".cs") > 0)
                                continue;
                            if (fn.IndexOf("FBX") != -1)
                            {
                                AssetImporter importer = AssetImporter.GetAtPath(fn);
                                ModelImporter modelImporter = (ModelImporter)importer;
                                modelImporter.animationCompression = ModelImporterAnimationCompression.Optimal;
                                modelImporter.meshCompression = ModelImporterMeshCompression.High;
                                modelImporter.isReadable = false;
                                modelImporter.importBlendShapes = false;
                            }
                        }
                    }
                }
            }
        }
    }

    [MenuItem("Assets/ResetSkillEvent")]
    static void ResetSkillEvent()
    {
        string path = AssetDatabase.GetAssetPath(Selection.activeObject);
        Debug.Log(path);
        string modelpath = GetModelPath(path);
        Debug.Log(modelpath);
        if (string.IsNullOrEmpty(modelpath))
        {
            Debug.Log("please select model path!");
            return;
        }

        Debug.Log(modelpath);
    }
}
 