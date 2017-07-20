using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace sw.ui.model
{
    [Serializable]
    public class MapTrigger
    {
        public int id;
        public int type;
        public int x;
        public int y;
        public int width;
        public int height;
        public int triggerType;
        public string triggerParam;
        public int targetType;
        public string targetParam;
        public string eulerangles;
        public GameObject target;
 

        public MapTrigger()
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
