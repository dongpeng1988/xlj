

using sw.manager;
using sw.util;
using UnityEngine;
using sw.game;
namespace sw.scene.util
{
    public class DebugGrid:MonoBehaviour
    {
        public ITerrainManager terrainMan;
        static Material lineMaterial = null;
        public int gridSize = 10;
        public float heightOff = 0;
        public Transform target;
        public bool isMouseGrid = false;
        private float camposz;
        private float camposx;

        void OnRenderObject()
        {
            OnTDrawGizmos();
        } 
        void CreateLineMaterial()
        {
            if (!lineMaterial)
            {
                lineMaterial = new Material("Shader \"Lines/Colored Blended\" {" +
                "SubShader { Pass { " +
                " Blend SrcAlpha OneMinusSrcAlpha " +
                " ZWrite Off Cull Off Fog { Mode Off } " +
                " BindChannels {" +
                " Bind \"vertex\", vertex Bind \"color\", color }" +
                "} } }");
                lineMaterial.hideFlags = HideFlags.HideAndDontSave;
                lineMaterial.shader.hideFlags = HideFlags.HideAndDontSave;
            }
        }
        Color GetColor(int i, int j)
        {
           bool canwalk = terrainMan.pathFinder.canWalk(i, j, 1);
           //if (!canwalk)
           //    Debug.Log("can not walk:" + i + "," + j);
            return canwalk?new Color(1, 1, 1, 1): new Color(1, 0, 0, 1);
           

        }
        /**
     * 渲染网格
     */
        void OnTDrawGizmos()
        {
            CreateLineMaterial();
            // set the current material
            lineMaterial.SetPass(0);
            GL.Begin(GL.LINES);
            GL.Color(new Color(1, 1, 1, 1));

            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            LayerMask nl = LayerConst.MASK_GROUND;
            if (Physics.Raycast(ray, out hit, 1500.0f, nl))
            {

            }

            if (isMouseGrid && terrainMan != null)
            {
                camposx = (hit.point.x - terrainMan.pathFinder.origin_x) / ConstantsRes.GRID_SIZE - 1;
                camposz = (-(hit.point.z - terrainMan.pathFinder.origin_z)) / ConstantsRes.GRID_SIZE - 1;
            }
            else if (terrainMan != null)
            {
                camposx = (hit.point.x - terrainMan.pathFinder.origin_x) / ConstantsRes.GRID_SIZE;
                camposz = (-(hit.point.z - terrainMan.pathFinder.origin_z)) / ConstantsRes.GRID_SIZE;
            }
            else 
            {
                return;
            }
           // Debug.Log("camposx:" + camposx + ",camposz:" + camposz + ",mapWidth:" + terrainMan.pathFinder.mapWidth + "," + terrainMan.pathFinder.mapHeight);

            for (uint i = 0; i < terrainMan.pathFinder.mapWidth; i++)
            {
                for (uint j = 0; j < terrainMan.pathFinder.mapHeight; j++)
                {
                    if(isMouseGrid)
                    {
                        if (camposx - i > (int)(terrainMan.pathFinder.edit_col_num / 2) || camposx - i < -(int)(terrainMan.pathFinder.edit_col_num / 2)) continue;
                        if (camposz - j > (int)(terrainMan.pathFinder.edit_col_num / 2) || camposz - j < -(int)(terrainMan.pathFinder.edit_col_num / 2)) continue;

                        if(terrainMan.pathFinder.edit_flag == 0)
                            GL.Color(new Color(0f,1f,0f,1f));
                        else
                            GL.Color(new Color(1f, 0f, 0f, 1f));
                    }
                    else
                    {
                        if (camposx - i > gridSize || camposx - i < -gridSize) continue;
                        if (camposz - j > gridSize || camposz - j < -gridSize) continue;

                        GL.Color(GetColor((int)i, (int)j));
                    }
                    

                    //GL.Vertex3(i * Constants.GRID_SIZE, heightOff + terrainMan.GetHeight(i, j), -j * Constants.GRID_SIZE);
                    //GL.Vertex3(i * Constants.GRID_SIZE, heightOff + terrainMan.GetHeight(i, (j + 1)), -(j + 1) * Constants.GRID_SIZE);
                    float h1 = terrainMan.GetHeight(i, j);

                    if (Mathf.Abs(h1 - target.position.y) > 1)
                        h1 = target.position.y;
                    float h2 = terrainMan.GetHeight(i, (j + 1));
                    if (Mathf.Abs(h2 - target.position.y) > 1)
                        h2 = target.position.y;
                    GL.Vertex3(i * ConstantsRes.GRID_SIZE + terrainMan.pathFinder.origin_x, heightOff + h1, -j * ConstantsRes.GRID_SIZE + terrainMan.pathFinder.origin_z);
                    GL.Vertex3(i * ConstantsRes.GRID_SIZE + terrainMan.pathFinder.origin_x, heightOff + h2, -(j + 1) * ConstantsRes.GRID_SIZE + terrainMan.pathFinder.origin_z);
                    
                   
                }
            }
            for (uint i = 0; i < terrainMan.pathFinder.mapWidth; i++)
            {
                for (uint j = 0; j < terrainMan.pathFinder.mapHeight; j++)
                {
                    if(isMouseGrid)
                    {
                        if (camposx - i > (int)(terrainMan.pathFinder.edit_col_num / 2) || camposx - i < -(int)(terrainMan.pathFinder.edit_col_num / 2)) continue;
                        if (camposz - j > (int)(terrainMan.pathFinder.edit_col_num / 2) || camposz - j < -(int)(terrainMan.pathFinder.edit_col_num / 2)) continue;

                        if (terrainMan.pathFinder.edit_flag == 0)
                            GL.Color(new Color(0f, 1f, 0f, 1f));
                        else
                            GL.Color(new Color(1f, 0f, 0f, 1f));
                    }
                    else
                    {
                        if (camposx - i > gridSize || camposx - i < -gridSize) continue;
                        if (camposz - j > gridSize || camposz - j < -gridSize) continue;
                        GL.Color(GetColor((int)i, (int)j));
                    }
                    

                    //GL.Vertex3(i * Constants.GRID_SIZE, heightOff + terrainMan.GetHeight(i, j), -j * Constants.GRID_SIZE);
                    //GL.Vertex3((i + 1) * Constants.GRID_SIZE, heightOff + terrainMan.GetHeight(i + 1, j), -j * Constants.GRID_SIZE);

                    float h1 = terrainMan.GetHeight(i, j);
                    if (Mathf.Abs(h1 -target.position.y)>1)
                        h1 = target.position.y;
                    float h2 = terrainMan.GetHeight(i + 1, j);
                    if (Mathf.Abs(h2 - target.position.y) > 1)
                        h2 = target.position.y;

                    GL.Vertex3(i * ConstantsRes.GRID_SIZE + terrainMan.pathFinder.origin_x, heightOff + h1, -j * ConstantsRes.GRID_SIZE + terrainMan.pathFinder.origin_z);
                    GL.Vertex3((i + 1) * ConstantsRes.GRID_SIZE + terrainMan.pathFinder.origin_x, heightOff + h2, -j * ConstantsRes.GRID_SIZE + terrainMan.pathFinder.origin_z);
                    
                }
            }

            GL.End();


           // DrawSelectState();

            //DrawPath();

        }
    }
}
