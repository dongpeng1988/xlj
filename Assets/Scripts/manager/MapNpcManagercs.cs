

using sw.res;
using sw.scene.ctrl;
using sw.scene.model;
using System.Collections.Generic;
using UnityEngine;
using sw.manager;
#if UNITY_EDITOR
using UnityEditor;
using sw.ui.model;
using sw.util;
#endif
namespace sw.manager
{
    public class MapNpcManager:IMapNpcManager
    {
        Dictionary<string, GameObject> fxCache = new Dictionary<string, GameObject>();
        Dictionary<string, List<ShowItem>> toShowItems = new Dictionary<string, List<ShowItem>>();
        CommonObjectPool _fxPool;
        CommonObjectPool fxPool
        {
            get
            {
                if (_fxPool == null)
                    _fxPool = new CommonObjectPool("mapPool");
                return _fxPool;
            }
        } 
        Vector3 last_pos;
        public MapNpcManager()
        {

        }
        Transform _root = null;
        Transform getRoot()
        {
            if (_root == null)
            {
                GameObject obj = GameObject.Find("NpcRoot");
                if (obj == null)
                {
                    obj = new GameObject("NpcRoot");
                    obj.hideFlags = HideFlags.DontSave;
                }
                _root = obj.transform;
            }
            return _root;
        }
        public void ShowSkillFx(RoleCtrlDemo target = null, string roleName = "", Vector3 pos = new Vector3())
        {
            return;
            GameObject obj = fxPool.Spawn(roleName);
            if (obj == null)
            {
                List<ShowItem> items;
                if (!toShowItems.TryGetValue(roleName, out items))
                {
                    items = new List<ShowItem>();
                    toShowItems[roleName] = items;
                }
                items.Add(new ShowItem() { roleName = roleName, target = target });
                AssetLoader2.Instance.LoadAsset("model/" + roleName.ToLower() , roleName, typeof(GameObject), onLoadFx, roleName);
            }
            last_pos = pos;
            BindFx(obj, target, pos);
        }
        void BindFx(GameObject obj, RoleCtrlDemo target, Vector3 pos)
        {
            //Transform root = target.gameObject.transform;
            //if (root == null)
            //    return;
            if (obj == null)
                return;
            Transform objtran = obj.transform;
            //GameObject bossLayer = GameObject.Find("bossLayer");
            //objtran.parent = bossLayer.transform;
            //objtran.position = root.position;
            objtran.position = pos;
        }
#if UNITY_EDITOR
        public void Preload2(MapNpc npc,Vector3 pos)
        {
            //string fxname = npc.modelId;
            //Object prefab = EditorTool.LoadAssetBundle("model/" + fxname );
            //if (prefab == null)
            //{
            //    Debug.LogError("npc 资源找不到:" + fxname);
            //    return;
            //}
          
            //string subpath = "npc";
            //switch(npc.type)
            //{
            //    case 1:
            //        subpath = "monster";
            //        break;
            //    default:
            //        subpath = "npc";
            //        break;
            //}
            //Transform parentTrans =    getRoot().FindChild(subpath);
            //if(parentTrans == null)
            //{
            //    GameObject subroot = new GameObject(subpath);
            //    subroot.transform.SetParent(getRoot());
            //    parentTrans = subroot.transform;
            //}
            //string nodeName = "npc_" + npc.uniqueId;



            //GameObject npcObj = (GameObject)GameObject.Instantiate(prefab);
            //GameObject npcCont = new GameObject(nodeName);
            //npcObj.transform.SetParent(npcCont.transform);
            //npcObj.transform.localPosition = Vector3.zero;

            //npcCont.transform.SetParent(parentTrans);
            //npcCont.transform.localPosition = pos;
            //MapNpcView view = npcCont.AddComponent<MapNpcView>();
            //view.data = npc;
          

        }
#endif
        public void Preload(string fxname,Vector3 pos,string uniqueId)
        {
            last_pos = pos;
            AssetLoader2.Instance.LoadAsset("model/" + fxname.ToLower() , fxname, typeof(GameObject), onLoadFx, fxname + uniqueId);
        }
        void onLoadFx(object obj, object[] param)
        {
            GameObject gobj = obj as GameObject;
            if (gobj == null)
                return;
            string fxname = param[0] as string;
            gobj.name = fxname;
            fxPool.AddPrefab(fxname, gobj);
            List<ShowItem> items;
            if (toShowItems.TryGetValue(fxname, out items))
            {
                for (int i = 0; i < items.Count; i++)
                {
                    ShowItem item = items[i];
                    GameObject fx = fxPool.Spawn(fxname);
                    BindFx(fx, item.target, last_pos);
                }
                toShowItems.Remove(fxname);
            }
        }
    }
}
