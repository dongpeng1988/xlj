

using UnityEditor;
using UnityEngine;
public  class MapToolWindow:EditorWindow
{
    [MenuItem("Build/MapTool")]
    static void showMapTool()
    {

        MapToolWindow window = (MapToolWindow)GetWindow(typeof(MapToolWindow));
        window.Show();


    }
    GameObject testMesh;
    void loadTile()
    {
        if (EditorData.terrainMan == null)
            return;
        Debug.Log("load tile");
     if(testMesh != null)
         GameObject.Destroy(testMesh); 
       testMesh = EditorData.terrainMan.pathFinder.GetTestMesh();
       testMesh.AddComponent<TileHelper>();
       testMesh.hideFlags = HideFlags.DontSave|HideFlags.NotEditable;
      testMesh.transform.localPosition = new Vector3(EditorData.terrainMan.pathFinder.origin_x, 0, EditorData.terrainMan.pathFinder.origin_z);
                    
    }



    int countShift = -1;
    bool selected,showMesh;
    int curTool = 0;
    string[] toolbars = new string[] {"通过","不可通过" };
    void OnGUI()
    {
        bool show = GUILayout.Toggle(showMesh, "显示通过性", "Button");
        if (show && show != showMesh)
        {
            Debug.Log("show:" + show + ",showmesh:" + showMesh);
            loadTile();
        }
        showMesh = show;
        if (showMesh)
        {
     
            bool cursel = GUILayout.Toggle(selected, "编辑", "Button");
            
            selected = cursel;
            EditorData.start_edit_tile = selected;
            if (selected)
            {
               
                //if(EditorData.terrainMan != null)
                //{
                //    countShift++;
                //    EditorData.terrainMan.pathFinder.setColFlag(countShift % 3 + 1, 1);
                //}
                curTool = GUILayout.Toolbar(curTool, toolbars);
            }
        }
        else if(testMesh != null)
        {
            GameObject.Destroy(testMesh);
            testMesh = null;
        }

        //float buttonWidth = (_position.width - EditorGUIUtility.labelWidth) / enumLength;
 
        //Rect buttonPos = new Rect (_position.x + EditorGUIUtility.labelWidth + buttonWidth * i, _position.y, buttonWidth, _position.height);
         
     
        
         
        //EditorGUILayout.Slider()
    }
}
 
