using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEditor;
using UnityEngine;
using sw.ctrl;

public class EditMapTool:ScriptableObject
{
    [MenuItem("Build/SwitchCamera")]
    static void SwitchCamera()
    {
      
        EditMapCameraManager.Instance.switchEditMapCamera();
    }
    [MenuItem("Build/UseTile")]
    static void useTile()
    {
        EditMapCameraManager.Instance.use_tile_101002 = !EditMapCameraManager.Instance.use_tile_101002;
    }

}

