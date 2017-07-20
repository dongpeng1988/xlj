using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace sw.ui.model
{
    [Serializable]
    public class MapZone
    {
        public int id;
        public int type;
        public int countryflag;
        public int x;
        public int y;
        public int width;
        public int height;
        public int regiontype;
        public int reliveHp;
        public int zoneindex;
        public string eulerangles;
        public GameObject target;
        public Dictionary<MapNode,int> nodeDict;

        public MapZone()
        {
            nodeDict = new Dictionary<MapNode, int>();
        }

        //public int real_x
        //{
        //    get
        //    {
        //        return x - width / 2;
        //    }
        //    set
        //    {
        //        x = value + width / 2;
        //    }

        //}
        //public int real_y
        //{
        //    get
        //    {
        //        return y - height / 2;
        //    }
        //    set
        //    {
        //        y = value + height / 2;
        //    }
        //}
    }
}
