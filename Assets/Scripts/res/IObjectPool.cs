using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace sw.res
{
    public interface IObjectPool
    {
        //void Add(string id,GameObject obj);
        GameObject Spawn(string id);
        void AddPrefab(string id, UnityEngine.Object prefab);
        void Despawn(GameObject obj);
        void Clear();
        Action<string, GameObject> OnSpawned {  set; }
        Action<string, GameObject> OnDespawned { set; }
    }
}
