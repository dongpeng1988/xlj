using sw.util;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace sw.res
{
    public class CommonObjectPool:IObjectPool
    {
        private Dictionary<string, Stack<GameObject>> pools;
        private Dictionary<string, UnityEngine.Object> prefabs;
        private Dictionary<int, string> idMaps;
        private GameObject root;
        private Action<string, GameObject> onSpawn;
        private Action<string, GameObject> onDespawn;
        public CommonObjectPool(string poolName)
        {
            pools = new Dictionary<string, Stack<GameObject>>();
            prefabs = new Dictionary<string, UnityEngine.Object>();
            idMaps = new Dictionary<int, string>();
            root = new GameObject(poolName);
            UnityEngine.Object.DontDestroyOnLoad(root);
            GameObject.DontDestroyOnLoad(root);
        }

        //public void Add(uint id, GameObject obj)
        //{
        //    Queue<GameObject> q;
        //    if (!pools.TryGetValue(id, out q))
        //        q = new Queue<GameObject>();            
        //    q.Enqueue(obj);
        //}

        public GameObject Spawn(string id)
        {
            GameObject result=null;
            Stack<GameObject> q;
            if (pools.TryGetValue(id, out q))
            {
                
                if (q.Count > 0)
                {
                    result = q.Pop();

                   
                    //LoggerHelper.Debug("get from pool:" + id + ",instance:" + result.GetInstanceID());
                }
            }
            if(result  == null)
            {
                UnityEngine.Object prefab;
                if (prefabs.TryGetValue(id, out prefab) && prefab)
                {
                    result = GameObject.Instantiate(prefab) as GameObject;

                    //LoggerHelper.Debug("get from prefab:" + id + ",instance:" + result.GetInstanceID());
                }
                else
                    return null;
                    //LoggerHelper.Warning("failed to find prefab:" + id);
            }
            if (result != null)
            {
                result.name = id.ToString();
                result.transform.parent = root.transform;
                result.transform.position = Vector3.zero;
                result.transform.rotation = Quaternion.identity;
                result.transform.localScale = Vector3.one;
                result.SetActive(true);
                idMaps[result.GetInstanceID()] = id;

                try
                {
                    if (onSpawn != null)
                        this.onSpawn(id,result);
                }
                catch (Exception exception)
                {
                    LoggerHelper.Error(exception.ToString(), false);
                }

            }
            return result;
        }


        public void Clear()
        {
            foreach (KeyValuePair<string, Stack<GameObject>> pair in pools)
            {
                GameObject o;
                foreach (GameObject pair2 in pair.Value)
                    GameObject.Destroy(pair2);
            }
            pools = new Dictionary<string, Stack<GameObject>>();
            //foreach(KeyValuePair<uint,UnityEngine.Object> pair2 in prefabs)
            //    Object.Destroy(pair2.Value);
            prefabs = new Dictionary<string, UnityEngine.Object>();
            idMaps = new Dictionary<int, string>();
        }
        public void AddPrefab(string id, UnityEngine.Object prefab)
        {
            prefabs[id] = prefab;
        }


        public void Despawn(GameObject obj)
        {
            if (obj == null)
                return;
            //return;
            string id;
            if (idMaps.TryGetValue(obj.GetInstanceID(), out id))
            {
                if (this.onDespawn != null)
                    this.onDespawn(id, obj);

                Stack<GameObject> q;
                if (!pools.TryGetValue(id, out q))
                {
                    q = new Stack<GameObject>();
                    pools[id] = q;
                }
                else if (q.Contains(obj))
                    return;
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


        public Action<string, GameObject> OnSpawned
        {
            set { onSpawn = value; }
        }

        public Action<string, GameObject> OnDespawned
        {
            set { onDespawn = value; }
        }
    }
}
