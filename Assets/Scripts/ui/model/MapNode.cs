using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace sw.ui.model
{
    public class MapNode
    {
        public int type;
        public int x;
        public int y;
        public int zoneId;

        public MapNode(int tid = 0, int tx = 0, int ty = 0, int ttype = 0)
        {
            zoneId = tid;
            x = tx;
            y = ty;
            type = ttype;
        }
        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            else if (obj.GetType().Equals(this.GetType()) == false)
            {
                return false;
            }
            else if ((obj as MapNode) != null)
            {
                if ((obj as MapNode).x == x && (obj as MapNode).y == y)
                {
                    return true;
                }
                else
                    return false;
            }
            else
                return base.Equals(obj);
        }

        //considering y < 10000
        public override int GetHashCode()
        {
            return x * 10000 + y;
        }
    }

}
