using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace sw.game.model
{
    public class WalkStep
    {
        public IntPoint pt;
        public int	dir;
		public bool transparent;
		public  WalkStep()
		{
		}
		public override   String ToString()
		{
            return "x:" + pt.x + ",y:" + pt.y + ",dir:" + dir + ",transparent:" + transparent;
		}
    }
}
