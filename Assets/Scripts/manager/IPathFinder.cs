
using sw.manager;
using sw.game.model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using sw.util;

namespace sw.game
{
    public interface IPathFinder
    {
        IntPoint findByDir(int fromX, int fromY, Vector2 dir, int walkLevel, int minDist = 1, int maxDis = 10);
        List<WalkStep> find(int startX, int startY, int endX, int endY, int walkLevel, Boolean useFloyd = false, Dictionary<string, List<WalkStep>> midData = null);
		 int   mapWidth{get;}
		 int   mapHeight{get;}
		 Boolean fillData(ByteArray data);
         
		 Boolean isTransparent(int x,int y);
		/**
		 * 寻找从from 到 to 最近的可到达点
		 * @param from
		 * @param to
		 * @param direct true:直线连线上找,false:在目标点周围找
		 * @param checkBarriar 是否检查障碍
		 * @param minDist 最小距离
		 * @param maxDist 最大距离
		 * @param walkLevel 通过等级
		 * @return 
		 * 
		 */		
		 IntPoint getClosestAvailPoint(IntPoint from,int toX,int toY,int minDist= 2 ,int maxDist=100 ,int walkLevel= 1 ,Boolean checkBarriar=true );
         Boolean hasBarriar(int fromX, int fromY, int toX, int toY, int walkLevel, List<IntPoint> points = null);
		/**
		 * 根据像素进行障碍判定
		 */
         Boolean hasBarriarPixel(int fromX, int fromY, int toX, int toY, int walkLevel, List<IntPoint> points = null);
		/**
		 * 根据像素*2进行障碍判定
		 */
         Boolean hasBarriarPixel2(int fromX, int fromY, int toX, int toY, int walkLevel, List<IntPoint> points = null);
			
		 Boolean canWalk(int x,int y,int walkLevel);
		
		 uint  version{get;}
        float origin_x{get;}


        float origin_z { get; }

         GameObject GetTestMesh();
         void setRoleTransAndTerrain(Transform trans, ITerrainManager terr);
         void saveTile(string resid,string datadir = "",string mapTileId = "");
         void editTile(int x, int y);
         void editZone(int x, int y, int addOrDelete);
         void useThisTile();
         void setColFlag(int col, int flag);
        int edit_flag{get;}

        int edit_col_num { get; }
        void testRay();
        Dictionary<Vector2,int> checkCanWalkArea();
        Dictionary<int, Dictionary<Vector2, int>> getConnectivityDict();
        void clearConnectivityToNum(int leftNum);
    }
}
