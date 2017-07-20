

using sw.res;
using sw.scene.ctrl;
using sw.scene.model;
using System.Collections.Generic;
using UnityEngine;
using sw.manager;
namespace sw.manager
{
    public class MapWarpManager : IMapWarpManager
    {
        Dictionary<string, GameObject> fxCache = new Dictionary<string, GameObject>();
        Dictionary<string, List<ShowItem>> toShowItems = new Dictionary<string, List<ShowItem>>();
        CommonObjectPool _fxPool;
        CommonObjectPool fxPool
        {
            get
            {
                if (_fxPool == null)
                    _fxPool = new CommonObjectPool("mapWarpManager");
                return _fxPool;
            }
        } 
        Vector3 last_pos;
        string temp_node_name;
        public MapWarpManager()
        {

        }
        public void ShowSkillFx(RoleCtrlDemo target = null, string roleName = "", Vector3 pos = new Vector3())
        {
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
            GameObject outside_obj = new GameObject();
            outside_obj.name = temp_node_name;
            obj.transform.parent = outside_obj.transform;
            outside_obj.transform.position = pos;

            //Transform objtran = obj.transform;
            ////GameObject bossLayer = GameObject.Find("bossLayer");
            ////objtran.parent = bossLayer.transform;
            ////objtran.position = root.position;
            //objtran.position = pos;
        }

        public void Preload(string fxname, Vector3 pos, string node_name)
        {
            last_pos = pos;
            temp_node_name = node_name;
            AssetLoader2.Instance.LoadAsset("model/" + fxname.ToLower() , fxname, typeof(GameObject), onLoadFx, fxname);
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
