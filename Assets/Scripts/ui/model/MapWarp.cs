using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace sw.ui.model
{
    [Serializable]
    public class MapWarp
    {
        public int id;
        public int warpType;
        public string warpName;
        public int warpX;
        public int warpY;
        public int destMapId = -1;

        public int destMapX;
        public int destMapY;
        public int type = -1;
        public int state = -1;
        public int openCondition = 0;
        public GameObject target;
        public  MapWarp()
        {

        }

        //public int id
        //{ 
        //    get { return warpX * 1000 + warpY; }
        //}

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            else if (obj.GetType().Equals(this.GetType()) == false)
            {
                return false;
            }
            else if ((obj as MapWarp) != null)
            {
                if ((obj as MapWarp).id == id)
                {
                    return true;
                }
                else
                    return false;
            }
            else
                return base.Equals(obj);
        }
    }
}
