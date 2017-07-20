using sw.game.model;
using sw.util;
using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using sw.scene.util;
using sw.manager;
using System.IO;
using sw.ctrl;
using sw.ui.model;
namespace sw.game
{
    public class AStarPathFinder:IPathFinder
    {
        private ByteArray _gridData;
		private Node _root;
		private Dictionary<int,Node> _nodes;
		private int _colNum;
		private int _rowNum;
        private float _origin_x;
        private float _origin_z;
		private const float diagCost = 1.4142135623731f;
		private const float straightCost = 1.0f;
        delegate float DistFun(Node node1,Node node2);
		DistFun heuristic;
		public int count;
		private uint _findVer = 0;
		List<Node> searchNodes;
		private uint _version;
        private ITerrainManager terrain;
        private Transform roleTrans;
        private Dictionary<int, int> _changedNodes;
        private ByteArray _editGridData;

        private int _edit_col_num = 1;
        private int _edit_flag = 1;
		public  uint version
        {
            get {return _version;}
        }
		 
        public  float origin_x
        {
            get { return _origin_x; }
        }

        public float origin_z
        {
            get { return _origin_z; }
        }
        public int edit_flag
        {
            get { return _edit_flag; }
        }

        public int edit_col_num
        {
            get { return _edit_col_num; }
        }
 
		
		private const int  MAX_FLOYD = 3;
		
		private const int MAX_STEP = 50;
		
		public   int  mapWidth
        {
            get
		        {
			        return _colNum;
		        }
        }
		public   int  mapHeight
        {
            get
		{
			return _rowNum;
		}
        }
		
		public  AStarPathFinder()
		{
			_nodes = new Dictionary<int,Node>();
			this.heuristic = this.manhattanHeuristic;
			 
//			this.heuristic = this.diagonalHeuristic;
		}
		public  Boolean fillData(ByteArray data)
		{
			if(data == null)
			{
				_gridData = null;
				_nodes = null;
			}
			else
			{
				 
				uint magic = data.readUnsignedInt();
				_version = data.readUnsignedInt();
				_colNum = data.readInt();
				_rowNum = data.readInt();
                _origin_x = data.readFloat();
                _origin_z = data.readFloat();
				if (data.size() < _colNum * _rowNum * 2)
					return false;
                byte[] newBuff = new byte[data.size()];
                Array.Copy(data.getBuffer(),data.position,newBuff,0,data.size());
				_gridData = new ByteArray(newBuff);
				 
				_nodes = new Dictionary<int,Node>();
                _changedNodes = new Dictionary<int, int>();
                Debug.Log("map size:" + _colNum + "*" + _rowNum+",orig:"+_origin_x+","+_origin_z);
			}
			
			return true;
		}
		public  int getWalkLevel(int x,int  y)
		{
			if (x < 0 || y < 0 || x>=_colNum|| y>=_rowNum)
				return -1;
			
			if(null == _gridData)
				return -1;
			int i = (x << 8) + y;
			if (_nodes.ContainsKey(i))
				return _nodes[i].walkLevel;
			else
			{
				_gridData.position = (y * _colNum + x) * 2; 
				int flag = _gridData.readUnsignedByte();		
				return flag & 0x7f;
			}
		}
		public  int getStatus(int x,int  y)
		{
			int i = (x << 8) + y;
			if (_nodes[i] != null&& _nodes[i].version ==(int) _findVer)
				return _nodes[i].status;
			else
			{
				return 0;
			}
		}
		private  Node getNode(int x,int  y)
		{
			if (x < 0 || y < 0 || x>=_colNum|| y>=_rowNum)
				return null;
			int i = (x << 8) + y;
			if (!_nodes.ContainsKey(i))				
			{
				_gridData.position = (y * _colNum + x) * 2; 
				int flag = _gridData.readUnsignedByte();		
			 
				_nodes[i] = new Node(x,y,flag & 0x7f,(flag&0x80)>0);
			}
			return _nodes[i];
		}
		private  Boolean contain(Node node,List<Node>   arr)
		{
			int l = arr.Count;
			for ( int i = 0; i < l; ++i) {
				if ( arr[i] == node ) return true;
			}
			
			return false;	
		}
		private  void addNode(Node node,List<Node>  arr)
		{
			if (arr.Count == 0)
			{
				arr.Add(node);
				return;
			}
			int high = arr.Count-1;
			int low = 0;
			int mid ;
			int len = arr.Count;
			if (node.f < arr[high].f)
			{
                arr.Add(node);
				
				return;
			}
			if (node.f > arr[0].f)
			{
				high = 0;
			}
			else
			{
				while (high-low>1)
				{
					mid = (high + low) / 2;
					if (arr[mid].f < node.f)
						high  = mid;
					else
						low= mid;
					
				}
				
				//trace("high:" + high);
				if (arr[high].f > node.f)			
					high++;
			}
            arr.Insert(high, node);
            //while (len>high)
            //{
            //    arr[len] = arr[len - 1];
            //    len--;
            //}
			
            //arr[high] = node;
			 
		}
		private  void checkNode(Node curNode,Node nextNode,Node  destNode,List<Node> open,int walkLevel,float cost)
		{
			count++;
		
//			if(searchNodes && nextNode)
//				searchNodes.push({x:nextNode.x,y:nextNode.y,status:nextNode.status});
			if (nextNode == null || nextNode.walkLevel >= walkLevel)
				return;
			//check neighbor
			
			if (nextNode.x != curNode.x && nextNode.y != curNode.y)
			{
				if (getNode(curNode.x, nextNode.y).walkLevel >= walkLevel&&getNode(nextNode.x,curNode.y).walkLevel >= walkLevel)
					return;
				 
			}
			float g = curNode.g + cost;
			float h = this.heuristic(nextNode, destNode);
			 
			float f = g + h;
			int i = (nextNode.x << 8) + nextNode.y;
			 
			if(nextNode.version==this._findVer && nextNode.status>0 )
			{
				if (nextNode.f > f)
				{
					//trace("adjust before:" + nextNode);
					nextNode.f = f;
					nextNode.g = g;
					nextNode.h = h;
					nextNode.parent = curNode;
					//trace("adjust after:" + nextNode+",parent:"+curNode);
				}
			}
			else
			{
				nextNode.f = f;
				nextNode.g = g;
				nextNode.h = h;
				nextNode.parent = curNode;
				addNode(nextNode, open);
			 
				nextNode.status = 1;
				nextNode.version =(int) _findVer;
				//trace("new node:" + nextNode);
			}
		}
		private  Node getMinNode(List<Node> nodes)
		{
			float minVal = float.MaxValue;
			Node minNode = null;
			int minIndex = -1;
            for(int i=0;i<nodes.Count;i++)
            {
                if (nodes[i].f < minVal) {
					minNode = nodes[i];
					minVal = nodes[i].f;
					minIndex = i;
				}
            }
			 
			
			int len = nodes.Count;
			for ( int i = minIndex; i < len-1; i++)
			{
				nodes[i] = nodes[i + 1];
			}
			nodes.RemoveAt(0);
			
			return minNode;
			/*
			nodes[minIndex] = null;
			return minNode;*/
		}
		private  Node getWalkableNode(int x,int y,int radius,int walkLevel)
		{
			Node node;
			int i;
			for( i = -radius;i<=radius;i++)
			{
				node = getNode(x+i, y-radius);
				if (node != null&&node.walkLevel < walkLevel)
				{
					return node;
				}
			}
			for(i = -radius;i<=radius;i++)			 
			{
				node = getNode(x+i, y+radius);
				if (node != null&&node.walkLevel < walkLevel)
				{
					return node;
				}
			}
			for(i = -radius;i<=radius;i++)			 
			{
				node = getNode(x-radius, y+i);
				if (node != null&&node.walkLevel < walkLevel)
				{
					return node;
				}
			}
			for(i = -radius;i<=radius;i++)		 
			{
				node = getNode(x+radius, y+i);
				if (node != null&&node.walkLevel < walkLevel)
				{
					return node;
				}
			}
			return null;
		}
        public IntPoint findByDir(int fromX, int fromY, Vector2 dir, int walkLevel, int minDist = 1, int maxDis = 10)
        {
            int xdir = Math.Sign(dir.x);
            int ydir = Math.Sign(dir.y);

            int i = 0;
            int j = 0;
            int startX = fromX / ConstantsRes.MapGridWidth / 2;
            int startY = fromY / ConstantsRes.MapGridHeight / 2;
            
            
           
            int nextX = ((i + (xdir > 0 ? 1 : 0)) * xdir + startX) * ConstantsRes.MapGridWidth * 2;
            int nextY = ((j + (ydir > 0 ? 1 : 0)) * ydir + startY) * ConstantsRes.MapGridHeight * 2;
            int xydir = xdir * ydir;
            while (true)
            {
                int delta = ((fromX - nextX) * (int)(dir.y * 1000) - (fromY - nextY) * (int)(dir.x * 1000)) * xydir;
                if (delta > 0)
                {
                    if (getWalkLevel(startX + (i + 1) * xdir, startY + j * ydir) >= walkLevel)
                        break;
                    i++;
                    nextX = ((i + (xdir > 0 ? 1 : 0)) * xdir + startX) * ConstantsRes.MapGridWidth * 2;
                   
                }
                else if (delta == 0)
                {
                    if (getWalkLevel(startX + (i + 1) * xdir, startY + j * ydir) < walkLevel)
                    {
                        i++;
                        nextX = ((i + (xdir > 0 ? 1 : 0)) * xdir + startX) * ConstantsRes.MapGridWidth * 2;
                        
                    }
                    else if (getWalkLevel(startX + i * xdir, startY + (j + 1) * ydir) < walkLevel)
                    {
                        j++;
                        nextY = ((j + (ydir > 0 ? 1 : 0)) * ydir + startY) * ConstantsRes.MapGridHeight * 2;
                       
                    }
                    else
                        break;
                        
                }
                else
                {
                    if (getWalkLevel(startX + i  * xdir, startY + (j+1) * ydir) >= walkLevel)
                        break;
                    j++;
                    nextY = ((j + (ydir > 0 ? 1 : 0)) * ydir + startY) * ConstantsRes.MapGridHeight * 2;
                  
                }
                if (j >= maxDis || i >= maxDis   )
                    break;
                //if (points != null)
                //    points.Add(new IntPoint(startX + i * xdir, startY + j * ydir));
                //if (getWalkLevel((startX + i * xdir), (startY + j * ydir)) >= walkLevel)
                //    return true;
            }
            
            if (i > 0 || j > 0)
           {
               if (getWalkLevel((startX + i * xdir), (startY + j * ydir)) >= walkLevel)
               {
                   LoggerHelper.Debug("ss");
               }
                if(i>0)
                {
                    float x1 = (startX + xdir * (i)) * ConstantsRes.MapGridWidth * 2;
                    float x2 = (startX + xdir * (i )+1) * ConstantsRes.MapGridWidth * 2;
                    
                    if(dir.y != 0 )
                    {
                        int ypos1 = (startY + ydir * (j)) * ConstantsRes.MapGridWidth * 2;
                        int ypos2 = (startY + ydir *j+1) * ConstantsRes.MapGridWidth * 2; 
                        float x3 = fromX + (ypos1 - fromY) * dir.x / dir.y;
                        float x4 = fromX + (ypos2 - fromY) * dir.x / dir.y;
                        //LoggerHelper.Debug("x1:" + x1 + ",x2:" + x2 + "x3:" + x3 + "x4:" + x4);
                        x3 = Mathf.Min(x1,x2,x3,x4);
                        x4 = Mathf.Max(x1,x2,x3,x4);
                        if(dir.x>0)
                        {
                            x1 = Mathf.Max(x1, x3);
                            x2 = Mathf.Min(x2, x4);
                        }
                        else
                        {
                            x1 = Mathf.Min(x1, x4);
                            x2 = Mathf.Max(x2, x3);
                        }
                    }
                    x1 = (x1 + x2) / 2;
                    IntPoint pt =  new IntPoint((int)x1, (int)(fromY+(x1-fromX) * dir.y / dir.x));
                   // if ((int)(pt.x / Constants.MapGridWidth / 2) != (startX + i * xdir) || (int)(pt.y / Constants.MapGridWidth / 2) != (startY + j * ydir))
                    if (getWalkLevel((int)(pt.x / ConstantsRes.MapGridWidth / 2), (int)(pt.y / ConstantsRes.MapGridWidth / 2)) >= walkLevel)
                        LoggerHelper.Debug("incorrect pt:" + (int)(pt.x / ConstantsRes.MapGridWidth / 2) + "!=" + (startX + i * xdir) + " or " + (int)(pt.y / ConstantsRes.MapGridWidth / 2) + " !=" + (startY + j * ydir)+",pt.y:"+pt.y+","+pt.x);
                    return pt;

                }
                else if(j>0)
                {
                    float y1 = (startY + ydir * (j)) * ConstantsRes.MapGridWidth * 2;
                    float y2 = (startY + ydir * j+1) * ConstantsRes.MapGridWidth * 2;

                    int xpos1 = (startX + xdir * (j)) * ConstantsRes.MapGridWidth * 2;
                    int xpos2 = (startX + xdir * j + 1) * ConstantsRes.MapGridWidth * 2;
                    float y3 = fromY + (xpos1 - fromX) * dir.y / dir.x;
                    float y4 = fromY + (xpos2 - fromX) * dir.y / dir.x;
                    //LoggerHelper.Debug("y1:" + y1 + ",y2:" + y2 + "y3:" + y3 + "y4:" + y4);
                  
                    y3 = Mathf.Min(y1, y2, y3, y4);
                    y4 = Mathf.Max(y1, y2, y3, y4);
                    if (dir.x != 0)
                    {
                        if (dir.y > 0)
                        {
                            y1 = Mathf.Max(y1, y3);
                            y2 = Mathf.Min(y2, y4);
                        }
                        else
                        {
                            y1 = Mathf.Min(y1, y4);
                            y2 = Mathf.Max(y2, y3);
                        }
                    }
                    y1 = (y1 + y2) / 2;
                    IntPoint pt = new IntPoint((int)(fromX + (y1 - fromY) * dir.x / dir.y), (int)y1);
                    if (getWalkLevel((int)(pt.x / ConstantsRes.MapGridWidth / 2), (int)(pt.y / ConstantsRes.MapGridWidth / 2)) >= walkLevel)
                        LoggerHelper.Debug("incorrect2 pt:" + (int)(pt.x / ConstantsRes.MapGridWidth / 2) + "!=" + (startX + i * xdir) + " or " + (int)(pt.y / ConstantsRes.MapGridWidth / 2) + " !=" + (startY + j * ydir) + ",pt.y:" + pt.y + "," + pt.x);
                    
                    return pt;
                }
           }
            return IntPoint.zero;
        }
		/* INTERFACE xw.game.service.IPathFinder */
		
		public  List<WalkStep> find(int startX,int startY,int endX,int endY,int walkLevel,Boolean usFloyd= false ,Dictionary<string,List<WalkStep>> midData=null )
		{
			count = 0;
			
			if (_gridData == null)
				return null;
			if (startX == endX && startY == endY)
				return null;
			_findVer++;
			List<Node> openNodes = new List<Node>();
            
			 
			Node curNode = getNode(startX, startY);
            if (curNode == null)
                return null;
			if (curNode.walkLevel >= walkLevel)
				return null;
			Node firstNode = curNode;
			Node destNode = getNode(endX, endY);
			if (destNode == null)
				return null;
			if (destNode.walkLevel >= walkLevel)
			{
                int i=1;
				for(i  = 1;i<MAX_STEP;i++)
				{
					destNode = getWalkableNode(endX,endY,i,walkLevel);
					if(destNode != null)
						break;
				}
                if (destNode == null)
                {
                    LoggerHelper.Warning("step more than :" + i);
                    return null;
                }
				endX = destNode.x;
				endY = destNode.y;
 
			}
			if (startX == endX && startY == endY)
				return null;
			if(usFloyd)
			{
				if(!hasBarriar(startX,startY,endX,endY,walkLevel))
				{
					List<WalkStep> pathDirect = new List<WalkStep>();
					WalkStep step2 = new WalkStep();
                    step2.pt = new IntPoint(endX,endY);
					 
					pathDirect.Add(step2);
					WalkStep step1 = new WalkStep();
                    step1.pt = new IntPoint(startX,startY);
					 
					pathDirect.Add(step1);
                    //adjustDir(pathDirect);
					return pathDirect;
				}
			}
			curNode.g = 0;
			curNode.h = this.heuristic(curNode, destNode);
			curNode.f = curNode.g + curNode.f;
            //int tm = TimerManager.getCurrentTime();
			
			int cnt = 0;
			int maxOpenSz = 0;
			
			while (curNode != destNode)
			{
			 
				
				checkNode(curNode,getNode(curNode.x - 1, curNode.y+1),destNode,openNodes,walkLevel,diagCost);
				checkNode(curNode,getNode(curNode.x + 1, curNode.y-1),destNode,openNodes,walkLevel,diagCost);
				checkNode(curNode,getNode(curNode.x - 1, curNode.y-1),destNode,openNodes,walkLevel,diagCost);
				checkNode(curNode,getNode(curNode.x + 1, curNode.y+1),destNode,openNodes,walkLevel,diagCost);
				checkNode(curNode, getNode(curNode.x - 1, curNode.y), destNode, openNodes, walkLevel, straightCost);
				checkNode(curNode,getNode(curNode.x , curNode.y-1),destNode,openNodes,walkLevel,straightCost);
				checkNode(curNode, getNode(curNode.x , curNode.y + 1), destNode, openNodes,  walkLevel, straightCost);
				checkNode(curNode,getNode(curNode.x + 1, curNode.y),destNode,openNodes,walkLevel,straightCost);
				//closeNodes[(curNode.x<<8)+curNode.y] = 1;
				curNode.status = 2;
				curNode.version =(int) _findVer;
				if (openNodes.Count == 0)
					return null;
				if (openNodes.Count > maxOpenSz)
					maxOpenSz = openNodes.Count;
				
				 
			 
				curNode = openNodes[openNodes.Count-1];
                openNodes.RemoveAt(openNodes.Count - 1);
			 
				cnt++;
				//if (cnt > 5)
				//return null;
			}

			List<WalkStep> path = buildPath(destNode,firstNode);
			if(midData != null)
				midData["orig"] = path;
			if(usFloyd)
				return floyd(path,walkLevel,midData);
			return path;
			
		}
        //private  int getDir(int x1,int  y1,int  x2,int  y2)
        //{
        //    if (x1 < x2)
        //    {
        //        if (y1 < y2)
        //            return DirectionType.SouthEast;
        //        else if (y1 > y2)
        //            return DirectionType.NorthEast;
        //        else
        //            return DirectionType.East;
        //    }
        //    else if (x1 > x2)
        //    {
        //        if (y1 < y2)
        //            return DirectionType.SouthWest;
        //        else if (y1 > y2)
        //            return DirectionType.NorthWest;
        //        else
        //            return DirectionType.West;
        //    }
        //    else
        //    {
        //        if (y1 < y2)
        //            return DirectionType.South;
        //        else if (y1 > y2)
        //            return DirectionType.North;
        //    }
        //    return DirectionType.South;
        //}
        private List<WalkStep> buildPath(Node dest, Node fist)
		{
			List<WalkStep>  path = new List<WalkStep>();
			Node node = dest;
			WalkStep lastStep = new WalkStep();
            lastStep.pt = new IntPoint(node.x,node.y);
			 
			lastStep.transparent = node.transparent;
			path.Add(lastStep);
            //if(node.parent != null)
            //    lastStep.dir =DirectionType.calcDirection(node.parent.x, node.parent.y, node.x, node.y,0);
			while (node != fist) {
				node = node.parent;
				WalkStep step = new WalkStep();
                //if(node.parent != null)
                //    step.dir = DirectionType.calcDirection(node.parent.x, node.parent.y, node.x, node.y,0);
                //else
                //    step.dir = DirectionType.South;
                step.pt = new IntPoint(node.x,node.y);
				 
				step.transparent = node.transparent;
				lastStep = step;
				path.Add( step );
			}
			
			return path;	
			
		}
		
		
		/****************************************************************************** 
		*
		*	These are our avaailable heuristics 
		*
		******************************************************************************/
        private float euclidianHeuristic(Node node, Node destinationNode)
		{
			float dx = node.x - destinationNode.x;
			float dy = node.y - destinationNode.y;
			
			return Mathf.Sqrt( dx * dx + dy * dy )  ;
		}
		
		private   float manhattanHeuristic(Node node,Node  destinationNode)
		{
			return Mathf.Abs(node.x - destinationNode.x)   + 
				   Mathf.Abs(node.y - destinationNode.y) ;
		}

        private float diagonalHeuristic(Node node, Node destinationNode)
		{
			float dx = Mathf.Abs(node.x - destinationNode.x);
			float dy = Mathf.Abs(node.y - destinationNode.y);
			
			float diag = Mathf.Min( dx, dy );
			float straight = dx + dy;
			
			return diagCost * diag + straightCost * (straight - 2 * diag);
		}
		
		public  Boolean isTransparent(int x,int  y)
		{
			if (x < 0 || y < 0 || x>=_colNum|| y>=_rowNum)
				return false;
			if(null == _gridData)
				return false;
			int i = (x << 8) + y;
			if (_nodes.ContainsKey(i))
				return _nodes[i].transparent;
			else
			{
				_gridData.position = (y * _colNum + x) * 2; 
				int flag = _gridData.readUnsignedByte();		
				return (flag & 0x80)>0;
			}
			
		}
		private  Boolean inLine(WalkStep step1,WalkStep step2,WalkStep step3)
		{
			return (step1.pt.x - step3.pt.x)*(step2.pt.y - step3.pt.y) == (step2.pt.x - step3.pt.x)*(step1.pt.y - step3.pt.y);
		}
		public  Boolean hasBarriarPixel2(int fromX,int fromY,int toX,int toY,int walkLevel,List<IntPoint> points=null )
		{
			int xdir = fromX>toX?-1:1;
			int ydir = fromY>toY?-1:1;
			
			int i = 0;
			int j = 0;
			int startX = fromX/ConstantsRes.MapGridWidth/2;
			int startY = fromY/ConstantsRes.MapGridHeight/2;
			int xCount = Mathf.Abs((int)(fromX/ConstantsRes.MapGridWidth/2) - (int)(toX/ConstantsRes.MapGridWidth/2));
			int yCount = Mathf.Abs((int)(fromY/ConstantsRes.MapGridHeight/2) - (int)(toY/ConstantsRes.MapGridHeight/2));
			if(xCount == 0 && yCount == 0)
				return false;
			int deltaX = (toX - fromX);
			int deltaY = (toY - fromY);
			int nextX = ((i+(xdir>0?1:0))*xdir+startX)*ConstantsRes.MapGridWidth*2;
			int nextY = ((j+(ydir>0?1:0))*ydir+startY)*ConstantsRes.MapGridHeight*2;
			int xydir =xdir*ydir;
			while(true)
			{
				int delta = ((fromX - nextX)*deltaY-(fromY-nextY)*deltaX)*xydir;
				if(delta>0)
				{
					i++;
					nextX = ((i+(xdir>0?1:0))*xdir+startX)*ConstantsRes.MapGridWidth*2;
					xCount--;
				}
				else if(delta == 0)
				{
					if(getWalkLevel(startX+(i+1)*xdir,startY+j*ydir)< walkLevel)
					{
						i++;
						nextX = ((i+(xdir>0?1:0))*xdir+startX)*ConstantsRes.MapGridWidth*2;
						xCount--;
					}
					else if(getWalkLevel(startX+i*xdir,startY+(j+1)*ydir)< walkLevel)
					{
						j++;
						nextY = ((j+(ydir>0?1:0))*ydir+startY)*ConstantsRes.MapGridHeight*2;
						yCount--;
					}
					else
						return true;
				}
				else
				{
					j++;
					nextY = ((j+(ydir>0?1:0))*ydir+startY)*ConstantsRes.MapGridHeight*2;
					yCount--;
				}
				if(yCount<0 || xCount<0||(xCount==0&&yCount==0)) 
					break;
				if(points != null)
					points.Add(new IntPoint(startX+i*xdir,startY+j*ydir));
				if(getWalkLevel((startX+i*xdir),(startY+j*ydir))>= walkLevel)
					return true;
			}
			return false;
		}
		public  Boolean hasBarriarPixel(int fromX,int fromY,int toX,int toY,int walkLevel,List<IntPoint> points=null )
		{
			int xdir = fromX>toX?-1:1;
			int ydir = fromY>toY?-1:1;
			
			int i = 0;
			int j = 0;
			int startX = fromX/ConstantsRes.MapGridWidth;
			int startY = fromY/ConstantsRes.MapGridHeight;
			int xCount = Mathf.Abs((int)(fromX/ConstantsRes.MapGridWidth) - (int)(toX/ConstantsRes.MapGridWidth));
			int yCount = Mathf.Abs((int)(fromY/ConstantsRes.MapGridHeight) - (int)(toY/ConstantsRes.MapGridHeight));
			if(xCount == 0 && yCount == 0)
				return false;
			int deltaX = (toX - fromX);
			int deltaY = (toY - fromY);
			int nextX = ((i+(xdir>0?1:0))*xdir+startX)*ConstantsRes.MapGridWidth;
			int nextY = ((j+(ydir>0?1:0))*ydir+startY)*ConstantsRes.MapGridHeight;
			int xydir =xdir*ydir;
			while(true)
			{
				int delta = ((fromX - nextX)*deltaY-(fromY-nextY)*deltaX)*xydir;
				if(delta>0)
				{
					i++;
					nextX = ((i+(xdir>0?1:0))*xdir+startX)*ConstantsRes.MapGridWidth;
					xCount--;
				}
				else if(delta == 0)
				{
					if(getWalkLevel(startX+(i+1)*xdir,startY+j*ydir)< walkLevel)
					{
						i++;
						nextX = ((i+(xdir>0?1:0))*xdir+startX)*ConstantsRes.MapGridWidth;
						xCount--;
					}
					else if(getWalkLevel(startX+i*xdir,startY+(j+1)*ydir)< walkLevel)
					{
						j++;
						nextY = ((j+(ydir>0?1:0))*ydir+startY)*ConstantsRes.MapGridHeight;
						yCount--;
					}
					else
						return true;
				}
				else
				{
					j++;
					nextY = ((j+(ydir>0?1:0))*ydir+startY)*ConstantsRes.MapGridHeight;
					yCount--;
				}
				if(yCount<0 || xCount<0||(xCount==0&&yCount==0)) 
					break;
				if(points != null)
					points.Add(new IntPoint(startX+i*xdir,startY+j*ydir));
				if(getWalkLevel(startX+i*xdir,startY+j*ydir)>= walkLevel)
					return true;
			}
			return false;
		}
		
		public  Boolean hasBarriar(int fromX,int fromY,int toX,int toY,int walkLevel,List<IntPoint> points=null )
		{
			 
			
			
			int xdir = fromX>toX?-1:1;
			int ydir = fromY>toY?-1:1;
			
			int i = 0;
			int j = 0;
			
			int xCount = Mathf.Abs(fromX - toX);
			int yCount = Mathf.Abs(fromY - toY);
			int deltaX = (toX - fromX);
			int deltaY = (toY - fromY);
			
			while(true)
			{
 
				int delta = deltaY*(2*i*xdir+1)*ydir -(2*j*ydir+1)*xdir*deltaX;
				if(delta>0)					
 
				{
					j +=ydir;
					yCount--;
 
				}
				else if(delta == 0)
				{
					if(getWalkLevel(fromX+i+xdir,fromY+j)< walkLevel)
					{
						i += xdir;
						xCount--;
					}
					else if(getWalkLevel(fromX+i,fromY+j+ydir)< walkLevel)
					{
						j += ydir;
						yCount--;
					}
					else
						return true;
				}
				else
				{
					i += xdir;
 
					xCount--;
				 
				}
 
				
				if(yCount<0 || xCount<0||(xCount==0&&yCount==0)) 
					break;
				if(points != null)
					points.Add(new IntPoint(fromX+i,fromY+j));
				if(getWalkLevel(fromX+i,fromY+j)>= walkLevel)
					return true;
			}
			 
			return false;
		}
		public  List<WalkStep> floyd(List<WalkStep> path,int walkLevel,Dictionary<string,List<WalkStep>> midData=null )
		{
 
			int i = 0;
			WalkStep step = path[0];
 
			List<WalkStep> newPath = path;
			int retry = 0;
			while(retry<MAX_FLOYD && newPath.Count>2)
			{
				List<WalkStep> resultPath = new List<WalkStep>();
				resultPath.Add(newPath[0]);
				i=1;
				step = newPath[0];
				bool shouldEnd = true;
				while(i<newPath.Count-1)
				{
					if(hasBarriar(step.pt.x,step.pt.y,newPath[i+1].pt.x,newPath[i+1].pt.y,walkLevel))
					{
						step = newPath[i];
						resultPath.Add(step);
						
					}
					else
						shouldEnd = false;
					i++;
					
				}
				resultPath.Add(newPath[newPath.Count-1]);
				newPath = resultPath;
				if(midData != null)
					midData["retry_"+retry]=newPath;
				if(shouldEnd)
					break;
				retry++;
			}
			
			if(midData != null)
				midData["final"] = newPath;
            //adjustDir(newPath);
			return newPath;
			
		}
        //private  void adjustDir(List<WalkStep> arr)
        //{
        //    int len = arr.Count;
        //    for(  int i =len-1;i>0;i--)
        //    {
        //        arr[i].dir = DirectionType.calcDirection(arr[i].pt.x,arr[i].pt.y,arr[i-1].pt.x,arr[i-1].pt.y,0);
				
        //    }
        //    arr[0].dir = arr[1].dir;
        //}
	   delegate void Fun(int x,int y);
		public  IntPoint getClosestAvailPoint(IntPoint from,int toX,int toY,int minDist= 2 ,int maxDist=100 ,int walkLevel= 1 ,Boolean checkBarriar=true )
		{
			IntPoint minPoint = new IntPoint(-1,-1);
			int minPointDist = int.MaxValue;
//			if(minDist == 0 && getWalkLevel(toX,toY)< walkLevel && (!checkBarriar || !hasBarriar(toX,toY,x,y,walkLevel))
//				return new IntPoint(toX,toY);
           

            
			Fun fun = (int x ,int y )=>
			{
				if(getWalkLevel(x,y)< walkLevel)
				{
					if(!checkBarriar || !hasBarriar(toX,toY,x,y,walkLevel))
					{
						int dist = Mathf.Max(Mathf.Abs(x-from.x),Mathf.Abs(y-from.y));
						if(minPointDist>dist)
						{
							minPointDist = dist;
							minPoint.x = x;
							minPoint.y = y;
						}
						
					}
				}
			};
			for(  int i = minDist;i<maxDist;i++)
			{
				for(int  j  = toX-i;j<toX+i;j++)
				{
					fun(j,toY-i);
					fun(j,toY+i);
					
				}
				 
				for(int j = toY-i;j<toY+i;j++)			 
				{
					fun(toX-i,j);
					fun(toX+i,j);
				}
				if(minPoint.x>=0 && minPoint.y>=0)
					return minPoint;
			}
			
			return IntPoint.zero;
		}
		
		public  Boolean canWalk(int x,int  y,int  walkLevel)
		{
            int walkLv = getWalkLevel(x, y);
            if (walkLv == -1)
            {
                return false;
            }
            return walkLv < walkLevel;
		}
        /*
         * The size of outside grid is 64 * 64 
         * */
        public const int INSIDE_GRID_COL_NUM = 64;
        GameObject root;
        public GameObject GetTestMesh()
        {
            root = new GameObject();
            illegalCanWalkArea = new Dictionary<Vector2,int>();
            //List<Vector3> verts = new List<Vector3>();
            //List<int> triangles = new List<int>();
            //List<Color> colors = new List<Color>();
            if (_editGridData == null)
                _editGridData = new ByteArray(_gridData.getBuffer());

            int OUTSIDE_GRID_COL_NUM = (int)Mathf.Ceil((float)mapWidth / INSIDE_GRID_COL_NUM);
            int OUTSIDE_GRID_ROW_NUM = (int)Mathf.Ceil((float)mapHeight / INSIDE_GRID_COL_NUM);

            for (int i = 0; i < OUTSIDE_GRID_COL_NUM;i ++ )
                for(int j = 0;j < OUTSIDE_GRID_ROW_NUM;j ++)
                    build_mesh_i_j(i,j);

            return root;

           /*
                for (int i = 0; i < mapWidth; i++)
                    for (int j = 0; j < mapHeight; j++)
                    {

                        if (testCanWalk(i, j, 1))
                        {
                            int idx = verts.Count;
                            Vector3 pt = PathUtil.Logic2Real(new Vector3(i, j, 0));
                            //Vector3 origin = new Vector3(pt.x,1000,pt.z);
                            // Ray ray = new Ray(origin, direction);
                            //if(Physics.Raycast(ray,out hitInfo,1500.0f,groundLayer))
                            float h1 = terrain.GetHeight(pt.x, pt.y);
                            if (Mathf.Abs(h1) - roleTrans.position.y > 1)
                                h1 = roleTrans.position.y;
                            h1 = h1 + 0.5f;
                            verts.Add(new Vector3(pt.x, h1, pt.y));


                            pt = PathUtil.Logic2Real(new Vector3(i + 1, j, 0));
                            h1 = terrain.GetHeight(pt.x, pt.y);
                            if (Mathf.Abs(h1) - roleTrans.position.y > 1)
                                h1 = roleTrans.position.y;
                            h1 = h1 + 0.5f;
                            verts.Add(new Vector3(pt.x, h1, pt.y));

                            pt = PathUtil.Logic2Real(new Vector3(i + 1, j + 1, 0));
                            h1 = terrain.GetHeight(pt.x, pt.y);
                            if (Mathf.Abs(h1) - roleTrans.position.y > 1)
                                h1 = roleTrans.position.y;
                            h1 = h1 + 0.5f;
                            verts.Add(new Vector3(pt.x, h1, pt.y));

                            pt = PathUtil.Logic2Real(new Vector3(i, j + 1, 0));
                            h1 = terrain.GetHeight(pt.x, pt.y);
                            if (Mathf.Abs(h1) - roleTrans.position.y > 1)
                                h1 = roleTrans.position.y;
                            h1 = h1 + 0.5f;
                            verts.Add(new Vector3(pt.x, h1, pt.y));
                            triangles.Add(idx);
                            triangles.Add(idx + 1);
                            triangles.Add(idx + 2);
                            triangles.Add(idx);
                            triangles.Add(idx + 2);
                            triangles.Add(idx + 3);
                            colors.Add(new Color(0f, 1f, 0f));
                            colors.Add(new Color(0f, 1f, 0f));
                            colors.Add(new Color(0f, 1f, 0f));
                            colors.Add(new Color(0f, 1f, 0f));
                            if (verts.Count >= 4100)
                            {
                                Mesh m = new Mesh();
                                m.vertices = verts.ToArray();
                                m.triangles = triangles.ToArray();
                                m.colors = colors.ToArray();
                                GameObject obj = new GameObject();
                                MeshFilter mf = obj.AddComponent<MeshFilter>();
                                obj.AddComponent<MeshRenderer>();
                                MeshRenderer mr = obj.GetComponent<MeshRenderer>();
                                //mr.material = new Material(Shader.Find("Unlit/Transparent Vertexlit"));
                                //mr.material = Resources.Load("Ground_tile_material") as Material;
                                //GameObject win = GameObject.Instantiate(Resources.Load("Prefabs/ground_prefab")) as GameObject;
                                mr.material = Resources.Load("Materials/Ground_tile_material") as Material;
                                //obj.GetComponent<MeshRenderer>().material = new Material(new Shader());
                                mf.mesh = m;
                                mf.transform.parent = root.transform;
                                verts = new List<Vector3>();
                                triangles = new List<int>();
                                colors = new List<Color>();

                            }
                        }
                        else
                        {
                            if (i == 190 && j == 174)
                            {
                                Debug.Log("get the point");
                            }
                            int idx = verts.Count;
                            Vector3 pt = PathUtil.Logic2Real(new Vector3(i, j, 0));
                            float h1 = terrain.GetHeight(pt.x, pt.y);
                            if (Mathf.Abs(h1) - roleTrans.position.y > 1)
                                h1 = roleTrans.position.y;
                            h1 = h1 + 0.5f;
                            verts.Add(new Vector3(pt.x, h1, pt.y));


                            pt = PathUtil.Logic2Real(new Vector3(i + 1, j, 0));
                            h1 = terrain.GetHeight(pt.x, pt.y);
                            if (Mathf.Abs(h1) - roleTrans.position.y > 1)
                                h1 = roleTrans.position.y;
                            h1 = h1 + 0.5f;
                            verts.Add(new Vector3(pt.x, h1, pt.y));

                            pt = PathUtil.Logic2Real(new Vector3(i + 1, j + 1, 0));
                            h1 = terrain.GetHeight(pt.x, pt.y);
                            if (Mathf.Abs(h1) - roleTrans.position.y > 1)
                                h1 = roleTrans.position.y;
                            h1 = h1 + 0.5f;
                            verts.Add(new Vector3(pt.x, h1, pt.y));

                            pt = PathUtil.Logic2Real(new Vector3(i, j + 1, 0));
                            h1 = terrain.GetHeight(pt.x, pt.y);
                            if (Mathf.Abs(h1) - roleTrans.position.y > 1)
                                h1 = roleTrans.position.y;
                            h1 = h1 + 0.5f;
                            verts.Add(new Vector3(pt.x, h1, pt.y));
                            triangles.Add(idx);
                            triangles.Add(idx + 1);
                            triangles.Add(idx + 2);
                            triangles.Add(idx);
                            triangles.Add(idx + 2);
                            triangles.Add(idx + 3);
                            colors.Add(new Color(1f, 0f, 0f));
                            colors.Add(new Color(1f, 0f, 0f));
                            colors.Add(new Color(1f, 0f, 0f));
                            colors.Add(new Color(1f, 0f, 0f));
                            if (verts.Count >= 4100)
                            {
                                Mesh m = new Mesh();
                                m.vertices = verts.ToArray();
                                m.triangles = triangles.ToArray();
                                m.colors = colors.ToArray();
                                GameObject obj = new GameObject();
                                MeshFilter mf = obj.AddComponent<MeshFilter>();
                                obj.AddComponent<MeshRenderer>();
                                MeshRenderer mr = obj.GetComponent<MeshRenderer>();
                                //mr.material = new Material(Shader.Find("Unlit/Transparent Vertexlit"));
                                //mr.material = Resources.Load("Ground_tile_material") as Material;
                                //GameObject win = GameObject.Instantiate(Resources.Load("Prefabs/ground_prefab")) as GameObject;
                                mr.material = Resources.Load("Materials/Ground_tile_material") as Material;
                                //obj.GetComponent<MeshRenderer>().material = new Material(new Shader());
                                mf.mesh = m;
                                mf.transform.parent = root.transform;
                                verts = new List<Vector3>();
                                triangles = new List<int>();
                                colors = new List<Color>();

                            }
                        }
                        //else
                        //{
                        //    colors.Add(new Color(0f,0f,0f));
                        //    colors.Add(new Color(0f,0f,0f));
                        //    colors.Add(new Color(0f,0f,0f));
                        //    colors.Add(new Color(0f,0f,0f));
                        //}
                    }
            if (verts.Count > 0)
            {
                Mesh m = new Mesh();
                m.vertices = verts.ToArray();
                m.triangles = triangles.ToArray();
                m.colors = colors.ToArray();
                GameObject obj = new GameObject();
                MeshFilter mf = obj.AddComponent<MeshFilter>();
                obj.AddComponent<MeshRenderer>();
                MeshRenderer mr = obj.GetComponent<MeshRenderer>();
                //GameObject win = GameObject.Instantiate(Resources.Load("Prefabs/ground_prefab")) as GameObject;
                mr.material = Resources.Load("Materials/Ground_tile_material") as Material;
                mf.mesh = m;
                mf.transform.parent = root.transform;
            }



            return root;
            * */
        }
        void update_mesh_i_j(GameObject obj,int i,int j)
        {
            

            int OUTSIDE_GRID_COL_NUM = (int)Mathf.Ceil((float)mapWidth / INSIDE_GRID_COL_NUM);
            int OUTSIDE_GRID_ROW_NUM = (int)Mathf.Ceil((float)mapHeight / INSIDE_GRID_COL_NUM);

            int col_lower = i * INSIDE_GRID_COL_NUM;
            int col_upper = ((i + 1) * INSIDE_GRID_COL_NUM < mapWidth) ? (i + 1) * INSIDE_GRID_COL_NUM : mapWidth;
            int row_lower = j * INSIDE_GRID_COL_NUM;
            int row_upper = ((j + 1) * INSIDE_GRID_COL_NUM < mapHeight) ? (j + 1) * INSIDE_GRID_COL_NUM : mapHeight;

           
            List<Color> colors = new List<Color>();

            for (int k = col_lower; k < col_upper; k++)
            {
                for (int l = row_lower; l < row_upper; l++)
                {
                    if (testCanWalk(k, l, 1))
                    {
                        //如果有碰撞点
                        if (checkTileHaveHitInfo(k, l))
                        {
                            if (check_in_zone(k, l) > 0)
                            {
                                colors.Add(new Color(0f, 0f, 1f));
                                colors.Add(new Color(0f, 0f, 1f));
                                colors.Add(new Color(0f, 0f, 1f));
                                colors.Add(new Color(0f, 0f, 1f));
                            }
                            else
                            {
                                colors.Add(new Color(0f, 0.5f, 0f));
                                colors.Add(new Color(0f, 0.5f, 0f));
                                colors.Add(new Color(0f, 0.5f, 0f));
                                colors.Add(new Color(0f, 0.5f, 0f));
                            }
                        }
                        //没有碰撞点，标记为黄色
                        else
                        {
                            colors.Add(new Color(1f, 1f, 0f));
                            colors.Add(new Color(1f, 1f, 0f));
                            colors.Add(new Color(1f, 1f, 0f));
                            colors.Add(new Color(1f, 1f, 0f));

                            Vector2 temp_pt = new Vector2(k, l);
                            if (!illegalCanWalkArea.ContainsKey(temp_pt))
                                illegalCanWalkArea.Add(temp_pt, 1);
                        }

                    }
                    else
                    {
                        colors.Add(new Color(1f, 0f, 0f));
                        colors.Add(new Color(1f, 0f, 0f));
                        colors.Add(new Color(1f, 0f, 0f));
                        colors.Add(new Color(1f, 0f, 0f));
                    }
                }
            }
            MeshFilter mf = obj.GetComponent<MeshFilter>();

            Mesh m = mf.sharedMesh;
          
            m.colors = colors.ToArray();
        
        }
        public void build_mesh_i_j(int i, int j)
        {
            int OUTSIDE_GRID_COL_NUM = (int)Mathf.Ceil((float)mapWidth / INSIDE_GRID_COL_NUM);
            int OUTSIDE_GRID_ROW_NUM = (int)Mathf.Ceil((float)mapHeight / INSIDE_GRID_COL_NUM);

            int col_lower = i * INSIDE_GRID_COL_NUM;
            int col_upper = ((i + 1) * INSIDE_GRID_COL_NUM < mapWidth) ? (i + 1) * INSIDE_GRID_COL_NUM : mapWidth;
            int row_lower = j * INSIDE_GRID_COL_NUM;
            int row_upper = ((j + 1) * INSIDE_GRID_COL_NUM < mapHeight) ? (j + 1) * INSIDE_GRID_COL_NUM : mapHeight;

            List<Vector3> verts = new List<Vector3>();
            List<int> triangles = new List<int>();
            List<Color> colors = new List<Color>();

            for (int k = col_lower; k < col_upper; k++)
            {
                for (int l = row_lower; l < row_upper; l++)
                {

                    int idx = verts.Count;
                    Vector3 pt = PathUtilEdit.Logic2Real(new Vector3(k, l, 0));
                    LayerMask groundLayer = LayerConst.MASK_GROUND;
                    Vector3 origin = new Vector3(pt.x,1000.0f,pt.y);
                    Vector3 direction = new Vector3(0.0f, -1.0f, 0.0f);
                    Ray ray = new Ray(origin, direction);
                    RaycastHit hitInfo;
                    float h2 = 0;
                    if (Physics.Raycast(ray, out hitInfo, 1500.0f, groundLayer))
                        h2 = hitInfo.point.y + 0.2f;
                    else if(Physics.Raycast(ray, out hitInfo, 1500.0f))
                        h2 = hitInfo.point.y + 0.2f;
                    float h1 = terrain.GetHeight(pt.x, pt.y);
                    //if (Mathf.Abs(h1) - roleTrans.position.y > 1)
                    //    h1 = roleTrans.position.y;
                    h1 = h1 + 0.1f;
                    verts.Add(new Vector3(pt.x, h2, pt.y));


                    pt = PathUtilEdit.Logic2Real(new Vector3(k + 1, l, 0));
                    origin = new Vector3(pt.x,1000.0f,pt.y);
                    direction = new Vector3(0.0f, -1.0f, 0.0f);
                    ray = new Ray(origin, direction);
                    if (Physics.Raycast(ray, out hitInfo, 1500.0f, groundLayer))
                        h2 = hitInfo.point.y + 0.2f;
                    else if (Physics.Raycast(ray, out hitInfo, 1500.0f))
                        h2 = hitInfo.point.y + 0.2f;
                    h1 = terrain.GetHeight(pt.x, pt.y);
                    //if (Mathf.Abs(h1) - roleTrans.position.y > 1)
                    //    h1 = roleTrans.position.y;
                    h1 = h1 + 0.1f;
                    verts.Add(new Vector3(pt.x, h2, pt.y));

                    pt = PathUtilEdit.Logic2Real(new Vector3(k + 1, l + 1, 0));
                    origin = new Vector3(pt.x,1000.0f,pt.y);
                    direction = new Vector3(0.0f, -1.0f, 0.0f);
                    ray = new Ray(origin, direction);
                    if (Physics.Raycast(ray, out hitInfo, 1500.0f, groundLayer))
                        h2 = hitInfo.point.y + 0.2f;
                    else if (Physics.Raycast(ray, out hitInfo, 1500.0f))
                        h2 = hitInfo.point.y + 0.2f;
                    h1 = terrain.GetHeight(pt.x, pt.y);
                    //if (Mathf.Abs(h1) - roleTrans.position.y > 1)
                    //    h1 = roleTrans.position.y;
                    h1 = h1 + 0.1f;
                    verts.Add(new Vector3(pt.x, h2, pt.y));

                    pt = PathUtilEdit.Logic2Real(new Vector3(k, l + 1, 0));
                    origin = new Vector3(pt.x,1000.0f,pt.y);
                    direction = new Vector3(0.0f, -1.0f, 0.0f);
                    ray = new Ray(origin, direction);
                    if (Physics.Raycast(ray, out hitInfo, 1500.0f, groundLayer))
                        h2 = hitInfo.point.y + 0.2f;
                    else if (Physics.Raycast(ray, out hitInfo, 1500.0f))
                        h2 = hitInfo.point.y + 0.2f;
                    h1 = terrain.GetHeight(pt.x, pt.y);
                    //if (Mathf.Abs(h1) - roleTrans.position.y > 1)
                    //    h1 = roleTrans.position.y;
                    h1 = h1 + 0.1f;
                    verts.Add(new Vector3(pt.x, h2, pt.y));
                    triangles.Add(idx);
                    triangles.Add(idx + 1);
                    triangles.Add(idx + 2);
                    triangles.Add(idx);
                    triangles.Add(idx + 2);
                    triangles.Add(idx + 3);
                    if (testCanWalk(k, l, 1))
                    {
                        //如果有碰撞点
                        if (checkTileHaveHitInfo(k, l))
                        {
                            if (check_in_zone(k, l) > 0)
                            {
                                colors.Add(new Color(0f, 0f, 1f));
                                colors.Add(new Color(0f, 0f, 1f));
                                colors.Add(new Color(0f, 0f, 1f));
                                colors.Add(new Color(0f, 0f, 1f));
                            }
                            else
                            {
                                colors.Add(new Color(0f, 0.5f, 0f));
                                colors.Add(new Color(0f, 0.5f, 0f));
                                colors.Add(new Color(0f, 0.5f, 0f));
                                colors.Add(new Color(0f, 0.5f, 0f));
                            }
                        }
                        //没有碰撞点，标记为黄色
                        else
                        {
                            colors.Add(new Color(1f, 1f, 0f));
                            colors.Add(new Color(1f, 1f, 0f));
                            colors.Add(new Color(1f, 1f, 0f));
                            colors.Add(new Color(1f, 1f, 0f));

                            Vector2 temp_pt = new Vector2(k, l);
                            if (!illegalCanWalkArea.ContainsKey(temp_pt))
                                illegalCanWalkArea.Add(temp_pt, 1);
                        }
                    }
                    else
                    {
                        colors.Add(new Color(1f, 0f, 0f));
                        colors.Add(new Color(1f, 0f, 0f));
                        colors.Add(new Color(1f, 0f, 0f));
                        colors.Add(new Color(1f, 0f, 0f));
                    }
                }
            }
            Mesh m = new Mesh();
            m.vertices = verts.ToArray();
            m.triangles = triangles.ToArray();
            m.colors = colors.ToArray();
            GameObject obj = new GameObject();
            obj.layer = LayerConst.LAYER_TIMEMESH;
            obj.name = "Ground_Mesh_" + i + "_" + j;
           //BoxCollider col =  obj.AddComponent<BoxCollider>();
           //col.isTrigger = true;
           //col.size = m.bounds.extents;
            MeshFilter mf = obj.AddComponent<MeshFilter>();
            obj.AddComponent<MeshRenderer>();
            MeshRenderer mr = obj.GetComponent<MeshRenderer>();
            mr.material = Resources.Load("Materials/Ground_tile_material") as Material;
            //mr.material.renderQueue = 300000000;
            //Debug.Log("Material renderer queue is" + mr.material.renderQueue);
            mf.mesh = m;
            mf.transform.parent = root.transform;
        }

        private MapNode  temp_check_node;
        private int check_in_zone(int x,int y)
        {
            if (temp_check_node == null)
                temp_check_node = new MapNode();
            temp_check_node.x = x;
            temp_check_node.y = y;
            if (EditMapManager.Instance.zoneCollection != null)
            {
                foreach (KeyValuePair<int, MapZone> temp_zone in EditMapManager.Instance.zoneCollection)
                {
                    if (temp_zone.Value.nodeDict.ContainsKey(temp_check_node))
                    {
                        return temp_zone.Key;
                    }
                }
            }
            return 0;
        }
        public  void testRay()
        {
            LayerMask groundLayer = LayerConst.MASK_GROUND;
            float h2 = 0;
            Vector3 origin = new Vector3(153.8f, 1000, -159f);
            Vector3 direction = new Vector3(0.0f, -1.0f, 0.0f);
            RaycastHit hitInfo;
            Ray ray = new Ray(origin, direction);
            if (Physics.Raycast(ray, out hitInfo, 1500.0f, groundLayer))
            {
                h2 = hitInfo.point.y + 1.5f;
                Debug.Log("hit the ground layer");
            }
            else if (Physics.Raycast(ray, out hitInfo, 1500.0f))
            {
                h2 = hitInfo.point.y + 1.5f;
                Debug.Log("have not hit the ground layer");
            }
                
        }

        public void rebuild_mesh(int x,int y)
        {
            if(root != null)
            {
                int i = x / INSIDE_GRID_COL_NUM;
                int j = y / INSIDE_GRID_COL_NUM;
                Transform changed_mesh = root.transform.FindChild("Ground_Mesh_" + i + "_" + j);
                UnityEngine.Object.DestroyImmediate(changed_mesh.gameObject);
                update_mesh_i_j(changed_mesh.gameObject,i,j);
            }
        }

        public void rebuild_mesh(Dictionary<Vector2, int> nodesDict)
        {
            foreach (KeyValuePair<Vector2, int> coord in nodesDict)
            {
                //Debug.Log("update groud mesh " + "Ground_Mesh_" + coord.Key.x + "_" + coord.Key.y);
                Transform changed_mesh = root.transform.FindChild("Ground_Mesh_" + coord.Key.x + "_" + coord.Key.y);
             //   UnityEngine.Object.DestroyImmediate(changed_mesh.gameObject);
               update_mesh_i_j(changed_mesh.gameObject,(int)coord.Key.x, (int)coord.Key.y);
            }
        }

        public void setRoleTransAndTerrain(Transform trans,ITerrainManager terr)
        {
            roleTrans = trans;
            terrain = terr;
        }

        Dictionary<Vector2, int> changed_coord;
        public void editTile(int x, int y)
        {
            int colWidth = _edit_col_num / 2;
            int i, j;

            if( changed_coord == null)
                changed_coord = new Dictionary<Vector2, int>();
            else
            {
                changed_coord.Clear();
            }

            for (i = 0; i < _edit_col_num; i++)
            {
                j = 0;
                for (; j < _edit_col_num; j++)
                {
                    if (x - colWidth + i < 0)
                        continue;
                    if (y - colWidth + j < 0)
                        continue;
                    //_gridData.position = ((y - colWidth + j) * _colNum + x) * 2;
                    //_gridData.write(flag);
                    _changedNodes[((y - colWidth + j) * _colNum + x - colWidth + i) * 2] = _edit_flag;
                    Vector2 coord = new Vector2((int)(x / INSIDE_GRID_COL_NUM),(int)(y / INSIDE_GRID_COL_NUM));
                    changed_coord[coord] = 1;
                }
            }
            rebuild_mesh(changed_coord);
        }


        public void setColFlag(int col,int flag)
        {
            _edit_col_num = col * col;
            _edit_flag = flag;
        }

        public void useThisTile()
        {
            for (int i = 0; i < _editGridData.getBuffer().Length; i++)
            {
                if (_changedNodes.ContainsKey(i))
                    _gridData.getBuffer()[i] = (byte)_changedNodes[i];
            }
            _nodes = new Dictionary<int, Node>();
        }

        private Boolean testCanWalk(int x, int y, int walkLevel)
        {
            int walkLv = testGetWalkLevel(x, y);
            if (walkLv == -1)
            {
                return false;
            }
            return walkLv < walkLevel;
        }

        private int testGetWalkLevel(int x, int y)
        {
            if (x < 0 || y < 0 || x >= _colNum || y >= _rowNum)
                return -1;

            if (null == _editGridData)
                return -1;
            _editGridData.position = (y * _colNum + x) * 2;
            int flag;
            if (_changedNodes.ContainsKey((y * _colNum + x) * 2))
            {
                flag = _changedNodes[(y * _colNum + x) * 2];
            }
            else
                flag = _editGridData.readUnsignedByte();
            return flag & 0x7f;
        }

        public void saveTile(string resid,string datadir = "",string mapTileId = "")
        {
            string targetPath = Application.streamingAssetsPath.Substring(0, Application.streamingAssetsPath.Length - 15) + "map/";
            Directory.CreateDirectory(targetPath);

            string xmlDir = datadir + "../地图数据文件/xianwang/res/" + mapTileId + "/";
            Directory.CreateDirectory(xmlDir);
            // + mapTileId + ".tile";
            DateTime dt = DateTime.Now;
            _version = (uint)dt.ToFileTimeUtc();

            FileStream fs;
            fs = new FileStream(targetPath + resid + ".bytes", FileMode.Create);
            BinaryWriter bw = new BinaryWriter(fs);
            bw.Write(0x0821);
            bw.Write(_version);
            bw.Write(_colNum);
            bw.Write(_rowNum);
            bw.Write((float)origin_x);
            bw.Write((float)origin_z);
            Debug.Log("地图通过性大小为" + _editGridData.getBuffer().Length);
            for (int i = 0; i < _editGridData.getBuffer().Length; i++)
            {
                if (_changedNodes.ContainsKey(i))
                    bw.Write((byte)_changedNodes[i]);
                else
                {
                    _editGridData.position = i;
                    bw.Write(_editGridData.getBuffer()[i]);
                }
            }
            bw.Close();
            fs.Close();

            _editGridData.position = 0;
            FileStream fs1 = new FileStream(xmlDir + mapTileId + ".hlm", FileMode.Create);
            BinaryWriter bw1 = new BinaryWriter(fs1);
            bw1.Write(0x0821);
            bw1.Write(_version);
            bw1.Write(_colNum);
            bw1.Write(_rowNum);
            bw1.Write((float)origin_x);
            bw1.Write((float)origin_z);
            for (int i = 0; i < _editGridData.getBuffer().Length; i++)
            {
                if (_changedNodes.ContainsKey(i))
                    bw1.Write((byte)_changedNodes[i]);
                else
                {
                    _editGridData.position = i;
                    bw1.Write(_editGridData.getBuffer()[i]);
                }
            }
            bw.Close();
            fs.Close();

        }

        public void editZone( int x,int y,int addOrDelete)
        {
            int colWidth = 2;
            int i, j;
            int type = 0;
            if (changed_coord == null)
                changed_coord = new Dictionary<Vector2, int>();
            else
            {
                changed_coord.Clear();
            }

            for (i = 0; i < colWidth; i++)
            {
                j = 0;
                for (; j < colWidth; j++)
                {
                    if (x - colWidth + i < 0)
                        continue;
                    if (y - colWidth + j < 0)
                        continue;

                    MapNode node = new MapNode(EditMapManager.Instance.editing_zone_param.id,x,y,type);
                    EditMapManager.Instance.editZoneNode(node, addOrDelete);
                    Vector2 coord = new Vector2((int)(x / INSIDE_GRID_COL_NUM), (int)(y / INSIDE_GRID_COL_NUM));
                    changed_coord[coord] = 1;
                }
            }
            rebuild_mesh(changed_coord);
        }

        Dictionary<Vector2,int> illegalCanWalkArea;
        public Dictionary<Vector2,int> checkCanWalkArea()
        {
            return illegalCanWalkArea;
        }

        private bool checkTileHaveHitInfo(int i,int j)
        {
            LayerMask groundLayer = LayerConst.MASK_GROUND;
            RaycastHit hitInfo;
            float x = origin_x + (float)(i + 0.5) * ConstantsRes.GRID_SIZE;
                float z = origin_z - (float)(j + 0.5) * ConstantsRes.GRID_SIZE;
                Vector3 origin = new Vector3(x, 1000, z);
                Vector3 direction = new Vector3(0.0f, -1.0f, 0.0f);
                Ray ray = new Ray(origin, direction);
                if (Physics.Raycast(ray, out hitInfo, 1500.0f, groundLayer))
                {
                    if (hitInfo.point.y == 0)
                        Debug.Log("point is illegal x :" + hitInfo.point.x + "z:" + hitInfo.point.z);
                    return true;
                }
                else
                    return false;
        }
        Dictionary<int, Dictionary<Vector2, int>> connectivityDict;
        List<int> connectivityList;
        public Dictionary<int,Dictionary<Vector2,int>> getConnectivityDict()
        {
            connectivityList = null;
            connectivityList = new List<int>();
            connectivityDict = null;
            connectivityDict = new Dictionary<int, Dictionary<Vector2, int>>();
            int countTotal = 0;
            int countCanPass = 0;
            for (int j = 0; j < _rowNum;j ++ )
            {
                int i = 0;
                for( ;i < _colNum ;i++)
                {
                    connectivityList.Add(j * _colNum + i);
                    _gridData.position = (j * _colNum + i) * 2;
                    int flag = _gridData.readUnsignedByte();

               
                    if (flag == 0)
                    {
                        Dictionary<Vector2,int> tempDict = new Dictionary<Vector2,int>();
                        tempDict.Add(new Vector2(i, j), j * _colNum + i);
                        if (!connectivityDict.ContainsKey(j * _colNum + i))
                            connectivityDict.Add(j * _colNum + i, tempDict);
                        else
                        {
                            //Debug.Log("when init connectivityDict,exist key " + i * _rowNum + j);
                        }
                        countCanPass++;
                    }
                    countTotal++;
                }
                
                    
            }
            for (int j = 0; j < _rowNum;j ++ )
            {
                int i = 0;
                for(; i< _colNum ;i ++)
                {
                    _gridData.position = (j * _colNum + i) * 2;
                    int flag = _gridData.readUnsignedByte();
                    if (flag != 0)
                        continue;
                    if(j == 0)
                    {
                        if(i == 0)
                            continue;
                        _gridData.position = (j * _colNum + i - 1) * 2;
                        int flag_i_1 = _gridData.readUnsignedByte();

                        if (CheckFlagCanWalk(flag_i_1))
                        {
                            ConnectSecondToFirst(j * _colNum + i - 1, j * _colNum + i);
                        }
                    }
                    else if(i == 0)
                    {
                        _gridData.position = ((j - 1) * _colNum + i) * 2;
                        int flag_j_1 = _gridData.readUnsignedByte();

                        if (CheckFlagCanWalk(flag_j_1 ))
                        {
                            ConnectSecondToFirst((j - 1) * _colNum + i, j * _colNum + i);
                        }
                    }
                    else
                    {
                        _gridData.position = (j * _colNum + i - 1) * 2;
                        int flag_i_1 = _gridData.readUnsignedByte();

                        _gridData.position = ((j - 1) * _colNum + i) * 2;
                        int flag_j_1 = _gridData.readUnsignedByte();

                        
                        //if (flag_i_1 == flag_j_1)
                        //    continue;
                        //先判断上面部分和左面部分如何并，再判断
                        if (!CheckFlagCanWalk(flag_i_1) && !CheckFlagCanWalk(flag_j_1))
                        {
                            continue;
                        }
                        else if (!CheckFlagCanWalk(flag_i_1) && CheckFlagCanWalk(flag_j_1))
                        {
                            ConnectSecondToFirst(( j - 1) * _colNum + i , j * _colNum + i);
                        }
                        else if(CheckFlagCanWalk(flag_i_1) && !CheckFlagCanWalk(flag_j_1))
                        {
                            ConnectSecondToFirst(j * _colNum + i - 1, j  * _colNum + i);
                        }
                        else
                        {
                            int areaId1 = connectivityList[j * _colNum + i - 1];
                            int areaId2 = connectivityList[(j - 1) * _colNum + i];
                            if (areaId1 < areaId2)
                            {
                                ConnectSecondToFirst(j * _colNum + i - 1, (j - 1) * _colNum + i);
                                ConnectSecondToFirst(j * _colNum + i - 1, j * _colNum + i);
                            }
                            else if (areaId1 > areaId2)
                            {
                                ConnectSecondToFirst((j - 1) * _colNum + i, j * _colNum + i -1);
                                ConnectSecondToFirst((j - 1) * _colNum + i, j * _colNum + i);
                            }
                            else
                            {
                                ConnectSecondToFirst((j - 1) * _colNum + i, j * _colNum + i);
                            }
                        }
                        
                        
                    }
                }
            }
            Debug.Log("At last,left dict num is" + connectivityDict.Count);
            return connectivityDict;
        }
        private bool CheckFlagCanWalk(int flag)
        {
            if (flag == 0)
                return true;
            return false;
        }
        private void ConnectSecondToFirst(int areaIndex1,int areaIndex2)
        {
            int areaId1 = connectivityList[areaIndex1];
            int areaId2 = connectivityList[areaIndex2];
            if (!connectivityDict.ContainsKey(areaId1) || !connectivityDict.ContainsKey(areaId2))
            {
                Debug.Log("not exist area" + areaId1 + " or " + areaId2);
                return;
            }

            Dictionary<Vector2, int> areaDict1 = connectivityDict[areaId1];
            Dictionary<Vector2, int> areaDict2 = connectivityDict[areaId2];
            foreach(Vector2 node2 in areaDict2.Keys)
            {
                if (!areaDict1.ContainsKey(node2))
                    areaDict1.Add(node2, areaId1);
                else
                {
                    int aa = 1;
                }
                connectivityList[(int)(node2.y * _colNum + node2.x)] = areaId1;
            }
            connectivityDict.Remove(areaId2);

            //Debug.Log("after delete area,left dict num is" + connectivityDict.Count);
        }

        Dictionary<int,Dictionary<Vector2, int>> leftConnectivityDict;
        int _cache_edit_flag = 0;
        int _cache_edit_col_num = 0;
        public void clearConnectivityToNum(int leftNum)
        {
            Debug.Log("need to clear connectivity area num to " + leftNum + " left");
            leftConnectivityDict = null;
            leftConnectivityDict = new Dictionary<int,Dictionary<Vector2,int>>();
            for(int i = 0;i < leftNum;i++)
            {
                int lastBiggestDictNum = 0;
                int lastBiggestDictIdx = -1;
                Dictionary<Vector2,int> areaDict;
                foreach(int areaIdx in connectivityDict.Keys)
                {
                    areaDict = connectivityDict[areaIdx];
                    if (areaDict.Count > lastBiggestDictNum && !(leftConnectivityDict.ContainsKey(areaIdx)))
                    {
                        lastBiggestDictNum = areaDict.Count;
                        lastBiggestDictIdx = areaIdx;
                    }
                }

                leftConnectivityDict.Add(lastBiggestDictIdx, connectivityDict[lastBiggestDictIdx]);
                Debug.Log("the lastBiggestDictNum is " + lastBiggestDictNum);
            }

            _cache_edit_flag = _edit_flag;
            _cache_edit_col_num = _edit_col_num;
            _edit_flag = 1;
            _edit_col_num = 1;
            foreach (int needClearIdx in connectivityDict.Keys)
            {
                if (leftConnectivityDict.ContainsKey(needClearIdx))
                    continue;
                Dictionary<Vector2, int> needClearDict = connectivityDict[needClearIdx];
                foreach(Vector2 clearPt in needClearDict.Keys)
                {
                    editTile((int)clearPt.x,(int)clearPt.y);
                }
            }
            _edit_flag = _cache_edit_flag;
            _edit_col_num = _cache_edit_col_num;
        }
	}
}
class Node 
{
	public float f,g,h;
	public int  x ,y;
	 
	public int status;
	public int version;
	public Node parent;
	private int _walkLevel;
	public bool transparent;
	public  Node(int x,int y,int walkLevel,bool transparent)
	{
		f = 0;
		g = 0;
		h = 0;
		version = 0;
		this.x = x;
		this.y = y;
		this._walkLevel = walkLevel;
		this.transparent = transparent;
	}
	public  String toString()
	{
		return "x:" + x + ",y:" + y + ",f:"+f+",g:"+g+",h:"+h+  ",transparent:" + transparent;
	}
	
	public  int  walkLevel 
    {
        get
            {
		    return _walkLevel;
	    }
    }
	
 
}
