using UnityEngine;
using System.Collections;
using sw.scene.util;
using sw.util;
using System.IO;
using sw.ctrl;
public class edittile : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

   public static void createTile()
    {
       float xMax = 0,xMin = 0,zMax = 0,zMin = 0,yMax=0,yMin=0,xMaxSize = 0,xMinSize = 0;
        MeshRenderer[] rendererObjs;
        rendererObjs = GameObject.FindObjectsOfType<MeshRenderer>();
        int count_items = 0,total_size = 0;
       foreach (MeshRenderer item in rendererObjs)
       {
           if (item.gameObject.layer !=  LayerConst.LAYER_GROUND)
               continue;
           if (xMax < item.bounds.max.x)
               xMax = item.bounds.max.x;
           if (xMin > item.bounds.min.x)
               xMin = item.bounds.min.x;
           if (zMax < item.bounds.max.z)
               zMax = item.bounds.max.z;
           if (zMin > item.bounds.min.z)
               zMin = item.bounds.min.z;
           if (yMax < item.bounds.max.y)
               yMax = item.bounds.max.y;
           if (yMin > item.bounds.min.y)
               yMin = item.bounds.min.y;

           if (xMaxSize < item.bounds.size.x)
               xMaxSize = item.bounds.size.x;
           if (xMinSize > item.bounds.size.x)
               xMinSize = item.bounds.size.x;
           count_items++;
       }
       Debug.Log("xMax xMin zMax zMin yMax yMin" + xMax + "  " + xMin + "  " + zMax + "  " + zMin+"  " + yMax + "  " + yMin);
       Debug.Log("all meshrenderer is" + rendererObjs.Length + " layer ground" + LayerConst.LAYER_GROUND + "count_items is" + count_items + "size is " + total_size);

       int col_num = 0, row_num = 0;
       float origin_x = 0, origin_z = 0;

       origin_x = xMin;
       origin_z = zMax;

       col_num = (int)((xMax - xMin) / Constants.GRID_SIZE);
       row_num = (int)((zMax - zMin) / Constants.GRID_SIZE);
       col_num = 400;
       row_num = 400;
       Debug.Log("tileWidth tileHeight" + col_num + row_num);

       RaycastHit hitInfo;
       LayerMask groundLayer = LayerConst.MASK_GROUND;
       int count_can_walk = 0;
       int count_total_point = 0;

       uint _version = 0;
       string targetPath = Application.streamingAssetsPath.Substring(0, Application.streamingAssetsPath.Length - 15) + "map/";
       Directory.CreateDirectory(targetPath);
       FileStream fs;
       fs = new FileStream(targetPath + EditMapCameraManager.Instance.mapResId+ ".bytes", FileMode.Create);
       BinaryWriter bw = new BinaryWriter(fs);
       bw.Write(0x0821);
       
       bw.Write(_version);
       bw.Write(col_num);
       bw.Write(row_num);
       bw.Write((float)origin_x);
       bw.Write((float)origin_z);



       int i = 0;
       for (int j = 0; j < row_num; j++)
      
       {
           i = 0;
           for (; i < col_num; i++)
           {
               float x = origin_x + (float)(i + 0.5) * Constants.GRID_SIZE;
               float z = origin_z - (float)(j + 0.5) * Constants.GRID_SIZE;
               Vector3 origin = new Vector3(x, 1000, z);
               Vector3 direction = new Vector3(0.0f, -1.0f, 0.0f);
               Ray ray = new Ray(origin, direction);
               //if(Physics.Raycast(ray,out hitInfo,1500.0f,groundLayer))
               //if (Mathf.Abs((origin.x - 150) * Constants.GRID_SIZE) < 20 && Mathf.Abs((origin.z - 160) * Constants.GRID_SIZE) < 20)
               //if ((-origin.z) > 100)
               //if (Mathf.Abs(origin.x - 159) < 20 && Mathf.Abs(-origin.z- 171) < 20)
               if(true)
               {
                   count_can_walk++;
                   if (Mathf.Abs(origin.x - 149) < 0.7 && Mathf.Abs(-origin.z - 147) < 0.7)
                   {
                       Debug.Log("point " + origin.x + "  " + origin.x + "can pass");
                   }
                   bw.Write((byte)0);
               }
               else
               {
                   if (Mathf.Abs(origin.x - 149) < 0.7 && Mathf.Abs(-origin.z - 147) < 0.7)
                   {
                       Debug.Log("point " + origin.x + "  " + origin.x + "can not pass");
                   }
                   bw.Write((byte)1);
               }

               bw.Write((byte)0);
               count_total_point++;
           }
       }


            
            
       bw.Close();
       fs.Close();

       Debug.Log("count_can_walk count_total_point" + count_can_walk +"  "+ count_total_point);
       
    }
}
