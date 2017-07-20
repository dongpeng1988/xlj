

using sw.game;
using System.Collections.Generic;
using UnityEngine;
namespace sw.manager
{
    public interface ITerrainManager
    {
        void LoadData(string fn);
        Vector3 GetPos(Vector2 pt);
        float GetHeight(uint x, uint z);
        float GetHeight(float x, float z);
        IPathFinder pathFinder { get; }
        //void GetPath(Vector2 from, Vector2 to, List<Vector2> path);

    }
}
