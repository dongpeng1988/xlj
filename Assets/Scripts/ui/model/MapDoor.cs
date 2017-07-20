using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace sw.ui.model
{
    [Serializable]
    public class MapDoor
    {
        public int id;
        public int type;
        public int x;
        public int y;
        public int width;
        public int height;
        public int state;
        public string res;
        public string eulerangles;
        public GameObject target;

        public MapDoor()
        {
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
