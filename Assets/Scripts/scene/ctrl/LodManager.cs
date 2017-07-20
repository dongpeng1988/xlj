
using sw.scene.ctrl;
using System;
using System.Collections.Generic;
using UnityEngine;
namespace sw.scene.ctrl
{
    public class LodManager:MonoBehaviour
    {
        public LODLoader[] updats;
        public int num;
        void Start()
        {
            InvokeRepeating("Update1", 0.2f, 0.2f);

        }
        void Update1()
        {
            for (int i = 0; i < updats.Length;i++ )
            {
                if (updats[i] != null)
                {
                    if (updats[i].checkDist())
                    {
                        updats[i] = null;
                        i--;
                    }
                }
            }
        }
        public void addAcTion(LODLoader ac)
        {
            updats[num]=ac;
            ac.index = num;
            ac.del = delAct;
            num++;
        }
        public void delAct(int index)
        {
            updats[index] = null;
        }
    }
}
