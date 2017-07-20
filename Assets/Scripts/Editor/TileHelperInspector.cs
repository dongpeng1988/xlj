using sw.scene.util;
using sw.util;
using UnityEditor;
using UnityEngine;
[CustomEditor(typeof(TileHelper))]
public class TileHelperInspector : Editor
{
    static int s_Hash = "TileHelperHash".GetHashCode();
    bool isDragging = false;
    protected   void OnDisable()
    {
       
      //  NGUIEditorTools.HideMoveTool(false);
    }
    static public void HideMoveTool(bool hide)
    {
#if !UNITY_4_3
        UnityEditor.Tools.hidden = hide && (UnityEditor.Tools.current == UnityEditor.Tool.Move)  ;
#endif
    }
    public void OnSceneGUI()
    {
        if ( EditorData.terrainMan == null)
            return;
    if(!EditorData.start_edit_tile)
    {
        HideMoveTool(false);
        return;
    }
        Event e = Event.current;
        int id = GUIUtility.GetControlID(s_Hash, FocusType.Passive);
        EventType type = e.GetTypeForControl(id);
        switch (type)
        {
            case EventType.MouseDown:
                {
                    if(e.button == 0)
                    {
                        if(e.control)
                        {
                             Ray ray = HandleUtility.GUIPointToWorldRay(e.mousePosition);
                             //Debug.Log("mouse pos:"+e.mousePosition);
                                RaycastHit hit;
                                LayerMask nl = LayerConst.MASK_GROUND;

                                if (Physics.Raycast(ray, out hit, 1500.0f, nl))
                                {
                                    int endX = PathUtilEdit.Real2LogicX(hit.point.x);
                                    int endZ = PathUtilEdit.Real2LogicZ(hit.point.z);
                                    Debug.Log("hit:" + hit.point+",x:"+endX+",z:"+endZ);
                                }
                                e.Use();
                        }
                        else
                        {
                            HideMoveTool(true);
                            Debug.Log("on mouse down:" + EditorData.start_edit_tile);
                            if (EditorData.start_edit_tile)
                            {
                                Vector2 mpos = e.mousePosition;
                                mpos.y = Screen.height - mpos.y;
                                Ray ray = HandleUtility.GUIPointToWorldRay(e.mousePosition);
                                RaycastHit hit;
                                LayerMask nl = LayerConst.MASK_GROUND;

                                if (Physics.Raycast(ray, out hit, 1500.0f, nl))
                                {
                                    Debug.Log("hit:" + hit.point);
                                    int endX = PathUtilEdit.Real2LogicX(hit.point.x);
                                    int endZ = PathUtilEdit.Real2LogicZ(hit.point.z);

                                    if (EditMapManager.Instance.EDIT_ZONE)
                                        EditorData.terrainMan.pathFinder.editZone(endX, endZ, 1);
                                    else
                                        EditorData.terrainMan.pathFinder.editTile(endX, endZ);
                                }

                                isDragging = true;
                            }
                            GUIUtility.hotControl = GUIUtility.keyboardControl = id;
                            e.Use();
                        }
                    }
                }
                break;
            case EventType.MouseUp:
                {
                    HideMoveTool(false);
                    if (GUIUtility.hotControl == id)
                    {
                        GUIUtility.hotControl = 0;
                        GUIUtility.keyboardControl = 0;
                        Debug.Log("set hot ctrl 0");
                    }
                }
                break;
            case EventType.MouseDrag:
                {
                    if (e.button == 0)
                    {
                        Ray ray = HandleUtility.GUIPointToWorldRay(e.mousePosition);
                        RaycastHit hit;
                        LayerMask nl = LayerConst.MASK_GROUND;

                        if (Physics.Raycast(ray, out hit, 1500.0f, nl))
                        {
                            int endX = PathUtilEdit.Real2LogicX(hit.point.x);
                            int endZ = PathUtilEdit.Real2LogicZ(hit.point.z);

                            if (EditMapManager.Instance.EDIT_ZONE)
                                EditorData.terrainMan.pathFinder.editZone(endX, endZ, 1);
                            else
                                EditorData.terrainMan.pathFinder.editTile(endX, endZ);
                        }
                    }
                }
                break;
        }
    }
}
 
