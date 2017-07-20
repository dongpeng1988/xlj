using UnityEngine;
using System.Collections;

public class CurrentQuests : MonoBehaviour
{
    bool isInited = false;

    void OnEnable() 
    {
        if (!isInited)
        {
            isInited = true;
            InitQuests();
        }
    }

    void InitQuests()
    {
        
    }
}
