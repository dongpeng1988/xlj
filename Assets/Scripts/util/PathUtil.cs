using sw.game.model;
using UnityEngine;

namespace sw.util
{
    public class PathUtilEdit
    {
        public static float origin_x = 0;
        public static float origin_z = 0;
        public static Vector3 Real2Logic(ref Vector3 pt)
        {
            pt.x = (pt.x - origin_x) / ConstantsRes.GRID_SIZE;
            pt.y = -(pt.y - origin_z) / ConstantsRes.GRID_SIZE/ConstantsRes.ZScale;
            return pt;
        }
      
        
        public static float RealDist(Vector2 pt1,Vector2 pt2)
        {
            return Mathf.Sqrt((pt1.x - pt2.x) * (pt1.x - pt2.x) + (pt1.y - pt2.y) * (pt1.y - pt2.y) / (ConstantsRes.ZScale2));                               
        }
        public static int Real2LogicX(float val)
        {
            return (int)((val - origin_x) / ConstantsRes.GRID_SIZE);
        }
        public static int Real2LogicZ(float val)
        {
            return -(int)((val - origin_z) / ConstantsRes.GRID_SIZE / ConstantsRes.ZScale);
        }
        public static float Logic2RealLen(float len)
        {
            return ConstantsRes.GRID_SIZE * len;
        }
        //public static Vector2 Real2Pixel(Vector2 pt)
        //{
        //    Vector2 rpt = new Vector2(pt.x*/Constants.GRID_SIZE
        //}
        public static Vector3 Logic2Real(ref Vector3 pt)
        {
            pt.x = pt.x  * ConstantsRes.GRID_SIZE + origin_x;
            pt.y= (-(pt.y  * ConstantsRes.GRID_SIZE) + origin_z)* ConstantsRes.ZScale;
            return pt;
        }
        public static Vector2 Logic2Real(IntPoint pt)
        {
            return new Vector2(pt.x * ConstantsRes.GRID_SIZE + origin_x,  -ConstantsRes.GRID_SIZE  * pt.y + origin_z); 
           
        }
        public static Vector3 LogicCenter2Real(IntPoint pt)
        {
            return new Vector3((pt.x + 0.5f) * ConstantsRes.GRID_SIZE + origin_x, 0, -(pt.y + 0.5f) * ConstantsRes.GRID_SIZE + origin_z);

        }
        public static Vector2 logicCenter2Real(int x,int y)
        {
            Vector2 pt = new Vector2();
            pt.x = (x + 0.5f) * ConstantsRes.GRID_SIZE + origin_x;
            pt.y = (-(y +  0.5f)) * ConstantsRes.GRID_SIZE * ConstantsRes.ZScale + origin_z;
            return pt;
        }
        public static IntPoint Real2Logic(Vector2 pt)
        {
            IntPoint ipt = new IntPoint();
            ipt.x = (int)((pt.x - origin_x)/ ConstantsRes.GRID_SIZE);
            ipt.y = (int)(-(pt.y - origin_z) / ConstantsRes.GRID_SIZE / ConstantsRes.ZScale);
            return ipt;
        }
        public static IntPoint Real2Logic(Vector3 pt)
        {
            IntPoint ipt = new IntPoint();
            ipt.x = (int)((pt.x - origin_x) / ConstantsRes.GRID_SIZE);
            ipt.y = (int)(-(pt.z - origin_z) / ConstantsRes.GRID_SIZE / ConstantsRes.ZScale);
            return ipt;
        }
        public static Vector3 pixel2Logic(Vector3 pt)
        {
            pt.x = pt.x / ConstantsRes.MapGridWidth;
            pt.y = -pt.y / ConstantsRes.MapGridWidth;
            return pt;
        }
        public static int pixel2Logic(int val)
        {

            return (int)(val / ConstantsRes.MapGridWidth);
            
        }
        public static IntPoint pixel2Logic(Vector2 pt)
        {
            IntPoint newpt = new IntPoint();
            newpt.x = (int)(pt.x / ConstantsRes.MapGridWidth);
            newpt.y = (int)(pt.y / ConstantsRes.MapGridWidth);
            return newpt;
        }
        public static IntPoint pixel2Logic(IntPoint pt)
        {
            IntPoint newpt = new IntPoint();
            newpt.x = (int)(pt.x / ConstantsRes.MapGridWidth);
            newpt.y = (int)(pt.y / ConstantsRes.MapGridWidth);
            return newpt;
        }
        public static float pixel2RealX(float val)
        {
            return val / ConstantsRes.UnitPixel;
        }
        public static float pixel2RealZ(float val)
        {
            return -val *ConstantsRes.ZScale/ ConstantsRes.UnitPixel;
        }
        public static IntPoint Real2Pixel(Vector2 pt)
        {
            return new IntPoint((int)(pt.x * ConstantsRes.UnitPixel), -(int)(pt.y * ConstantsRes.UnitPixel / ConstantsRes.ZScale));
        }
        public static int Real2PixelX(float val)
        {
            return (int)(val * ConstantsRes.UnitPixel);
        }
        public static int Real2PixelZ(float val)
        {
            return (int)(val * ConstantsRes.UnitPixel / ConstantsRes.ZScale);
        }

        public static Vector2 pixel2Real(Vector2 pt)
        {
            return new Vector2(pt.x / ConstantsRes.UnitPixel, -pt.y *ConstantsRes.ZScale / ConstantsRes.UnitPixel);
        }
        public static Vector2 pixel2Real(IntPoint pt)
        {
            return new Vector2((float)pt.x / ConstantsRes.UnitPixel, -pt.y * ConstantsRes.ZScale / ConstantsRes.UnitPixel);
        }
        public static Vector3 Logic2Real(Vector3 pt)
        {
            pt.x = pt.x * ConstantsRes.GRID_SIZE + origin_x;
            pt.y = (-pt.y * ConstantsRes.GRID_SIZE + origin_z)*ConstantsRes.ZScale;
            return pt;
        }
        public static float Logic2RealX(float val)
        {
            return (val+0.5f) * ConstantsRes.GRID_SIZE + origin_x;
         
        }
        public static float Logic2RealZ(float val)
        {
            return (-(val+0.5f) * ConstantsRes.GRID_SIZE + origin_z) * ConstantsRes.ZScale;

        }

        public static Vector2 logicCenter2Pixel2(int x, int y)
        {
            Vector2 result = new Vector2();
            result.x = (x + 0.5f) * ConstantsRes.MapGridWidth;
            result.y = (y + 0.5f) * ConstantsRes.MapGridHeight;
            return result;
        }
        public static IntPoint logicCenter2Pixel(int x, int y)
        {
            IntPoint result = new IntPoint();
            result.x =(int)( (x + 0.5f) * ConstantsRes.MapGridWidth);
            result.y = (int)((y + 0.5f) * ConstantsRes.MapGridHeight);
            return result;
        }
    }
}
