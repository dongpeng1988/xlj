

using sw.game;
using sw.scene.util;
using sw.util;
using System.Collections.Generic;
using UnityEngine;
namespace sw.manager
{
    public class TestTerrainManager:ITerrainManager
    {
        AStarPathFinder _pathFinder = new AStarPathFinder();
        public void LoadData(string fn)
        {
            throw new System.NotImplementedException();
        }

        public UnityEngine.Vector3 GetPos(UnityEngine.Vector2 pt)
        {
            throw new System.NotImplementedException();
        }

        public void GetPath(UnityEngine.Vector2 from, UnityEngine.Vector2 to, System.Collections.Generic.List<UnityEngine.Vector2> path)
        {
            throw new System.NotImplementedException();
        }


        public game.IPathFinder pathFinder
        {
            get { return _pathFinder; }
        }

        Dictionary<uint, float> heightCache = new Dictionary<uint, float>();
        public float GetHeight(uint x, uint z)
        {
             

            uint k = (x << 16 )+z;
            float val;
            if (heightCache.TryGetValue(k, out val))
                return val;
            Ray ray = new Ray();
            ray.origin = new Vector3(x * ConstantsRes.GRID_SIZE, 1000.0f, -z * ConstantsRes.GRID_SIZE);
            ray.direction = new Vector3(0.0f, -1.0f, 0.0f);

            RaycastHit hit;
            LayerMask nl = LayerConst.MASK_GROUND;
            if (Physics.Raycast(ray, out hit, 1500.0f, nl))
            {
                float ret = (1000.0f - hit.distance);
                heightCache[k] = ret;
                return ret;
            }
            else
            {
                heightCache[k] = 0.0f;
                return 0.0f;
            }
        }
        public float GetHeight(float x, float z)
        {


            
            Ray ray = new Ray();
            ray.origin = new Vector3(x, 1000.0f, z);
            ray.direction = new Vector3(0.0f, -1.0f, 0.0f);

            RaycastHit hit;
            LayerMask nl = LayerConst.MASK_GROUND;
            if (Physics.Raycast(ray, out hit, 1500.0f, nl))
            {
                float ret = (1000.0f - hit.distance);
                
                return ret;
            }
            else
            {
                 
                return 0.0f;
            }
        }

    }
}
