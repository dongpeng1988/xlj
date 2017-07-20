using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using sw.game.model;

namespace sw.ui.model
{
    [Serializable]
    public class MapLine
    {
        public static int TYPE_PLAYER = 1;
        public static int TYPE_BOSS = 0;

        public int id;
        public int type;
        public int x;
        public int y;
        public int starobjid;
        public List<MapLinePoint> linepts;
        public int bCircle = 1;
        public GameObject target;
        //private string _pointsStr;
        //public string pointsStr
        //{
        //    set
        //    {
        //        _pointsStr = value;
        //        linepts = new List<Vector2>();
        //        string[] ptArr = _pointsStr.Split(';');
        //        for (int j = 0; j < ptArr.Length; j++)
        //        {
        //            linepts.Add(new Vector2(int.Parse(ptArr[j].Split(' ')[0]), int.Parse(ptArr[j].Split(' ')[1])));
        //        }
        //    }
        //    get
        //    {
        //        return _pointsStr;
        //    }
        //}
        public MapLine(int startobjid_value)
        {
            starobjid = startobjid_value;
        }
    }
}
