using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace sw.ui.model
{
    [Serializable]
    public class MapNpc
    {
        public const int TYPE_FIGHT_NPC = 1;
        public const int TYPE_NPC = 2;

        public int id;
        public int x;
        public int y;
        public int level;
        public string modelId;
        public int type;
        public int ntype;
        public int enemyType;
        public int nkind;
        public int width;
        public int height;
        public int ai;
        public int scope;
        public int direction;
        public int chase;
        public int num;
        public int interval;
        public int speed;
        public int walklen;
        public string uniqueId;
        public System.Random rand;
        public string npcName;
        [NonSerialized]
        public GameObject target;
        public MapNpc(int param_id)
        {
            id = param_id;
            rand = new System.Random();
            uniqueId = id.ToString() + rand.Next(1, 1000).ToString();
        }

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;
            else if (obj.GetType().Equals(this.GetType()) == false)
            {
                return false;
            }
            else if ((obj as MapNpc) != null)
            {
                if ((obj as MapNpc).x == x && (obj as MapNpc).y == y && (obj as MapNpc).id == id)
                {
                    return true;
                }
                else
                    return false;
            }
            else
                return base.Equals(obj);
        }

        public override int GetHashCode()
        {
            return uniqueId.GetHashCode();
        }
    }
}
