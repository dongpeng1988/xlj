

using sw.util;
using System.Collections.Generic;
using UnityEngine;
namespace sw.res
{
    public class GameObjectPool
    {
        private Dictionary<string, Stack<GameObject>> pools = new Dictionary<string,Stack<GameObject>>();
        private Dictionary<string, UnityEngine.GameObject> prefabs = new Dictionary<string, GameObject>();
        Dictionary<string, List<LoadingItem>> pendingLoad = new Dictionary<string, List<LoadingItem>>();
        public delegate void OnSpawned(GameObject go,object[] param);
        private Dictionary<int, string> idMaps = new Dictionary<int, string>();
        GameObject root;
        struct LoadingItem
        {
            public OnSpawned cb;
            public object[] param;
        }
        public GameObjectPool()
        {
            root = new GameObject("poolroot");
            root.transform.position = new Vector3(999999, 9999999, 999999);
            UnityEngine.Object.DontDestroyOnLoad(root);
        }
        void NotifySpawn(string path,GameObject prefab)
        {
            List<LoadingItem> cbs;
            if (pendingLoad.TryGetValue(path, out cbs))
            {
                for (int i = 0; i < cbs.Count; i++)
                {
                    if (prefab == null)
                        cbs[i].cb.Invoke(null,cbs[i].param);
                    else
                    {
                        GameObject go = GameObject.Instantiate(prefab);
                        AssetLoader2.Instance.ReplaceShader(go);
                        idMaps[go.GetInstanceID()] = path;
                       PoolGameObject po =  go.AddComponent<PoolGameObject>();
                       po.disposeHandler = onDispose;
                       cbs[i].cb.Invoke(go, cbs[i].param);
                    }
                    
                }
                pendingLoad.Remove(path);
            }
        }
        void onDispose(PoolGameObject go,bool destroy)
        {
            GameObject.Destroy(go.gameObject);
        }
        void onLoad(object o,object[] param)
        {
            string path = param[0] as string;
            GameObject go = o as GameObject;
            if (go == null)
            {
                NotifySpawn(path, null);
                return;
            }
            
            if(prefabs.ContainsKey(path) && prefabs[path] != go)
            {
                GameObject.Destroy(go);
                go = prefabs[path];
            }
            else
            {
                prefabs[path] = go;
               
            }
            NotifySpawn(path, go);
        }
        public void Despawn(GameObject obj)
        {
            if (obj == null)
                return;
            //return;
            string id;
            if (idMaps.TryGetValue(obj.GetInstanceID(), out id))
            {
                

                Stack<GameObject> q;
                if (!pools.TryGetValue(id, out q))
                {
                    q = new Stack<GameObject>();
                    pools[id] = q;
                }

                obj.transform.parent = root.transform;
                obj.SetActive(false);
                q.Push(obj);
                //LoggerHelper.Debug("Despawn  to pool  " + id + ",size:" + q.Count + ",instance:" + obj.GetInstanceID());
            }
            else
            {
                LoggerHelper.Debug("failed to find obj:" + obj.GetInstanceID());
                GameObject.Destroy(obj);
            }
        }
        public void Spawn(string path,string oname,OnSpawned cb,params object[] param)
        {
            GameObject result = null;
            Stack<GameObject> q;
            if (pools.TryGetValue(path, out q))
            {

                if (q.Count > 0)
                {
                    result = q.Pop();
                }
            }
            if (result == null)
            {
                UnityEngine.GameObject prefab;
                if (prefabs.TryGetValue(path, out prefab) && prefab)
                {
              
                    GameObject go = GameObject.Instantiate(prefab);
                    AssetLoader2.Instance.ReplaceShader(go);
                    idMaps[go.GetInstanceID()] = path;
                    PoolGameObject po = go.AddComponent<PoolGameObject>();
                    po.disposeHandler = onDispose;
                    cb.Invoke(go,param);
                    
                }
                else
                {
                    string assetname = path.Substring(path.LastIndexOf("/")+1);
                    List<LoadingItem> loadingItems;
                    if(!pendingLoad.TryGetValue(path,out loadingItems))
                    {
                        loadingItems = new List<LoadingItem>();
                        pendingLoad[path] = loadingItems;
                        loadingItems.Add(new LoadingItem() { cb = cb, param = param });
                        AssetLoader2.Instance.LoadAsset(path, oname, typeof(GameObject), onLoad, path);
                    }
                    else
                    {
                        loadingItems.Add(new LoadingItem() { cb = cb, param = param });
                    }
                    //loadingItems.Add(new LoadingItem() { cb = cb, param = param });
                }
            }
            else
                cb.Invoke(result,param);
        }
    }
}
