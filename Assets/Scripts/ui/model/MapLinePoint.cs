using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using sw.game.model;

namespace sw.ui.model
{
    [Serializable]
    public class MapLinePoint
    {

        public int x;
        public int y;
        public MapLinePoint(int _x,int _y)
        {
            x = _x;
            y = _y;
        }
    }
}
