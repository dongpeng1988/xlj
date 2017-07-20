using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using UnityEditor;

class NpcWindow:EditorWindow
{
    [MenuItem("Build/NpcWindow")]
    static  void openNpcWindow()
    {
        NpcWindow npcWindow = (NpcWindow)GetWindow(typeof(NpcWindow));
    }

    void OnGUI()
    {

    }
}

