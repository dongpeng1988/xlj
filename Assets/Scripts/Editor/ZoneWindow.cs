using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using UnityEditor;

class ZoneWindow:EditorWindow
{
    [MenuItem("Build/ZoneWindow")]
    static  void openZoneWindow()
    {
        ZoneWindow window = (ZoneWindow)GetWindow(typeof(ZoneWindow));
    }

    void OnGUI()
    {

    }
}

