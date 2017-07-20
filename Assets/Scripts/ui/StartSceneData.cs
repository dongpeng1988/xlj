using UnityEngine;
using System.Collections;
using sw.util;

public class StartSceneData : MonoBehaviour {

    //public GameObject mUIParent;

    void Awake()
    {
        
    }
    void Start()
    {
        Screen.orientation = ScreenOrientation.AutoRotation;
        Screen.autorotateToLandscapeLeft = true;
        Screen.autorotateToLandscapeRight = true;
        Screen.autorotateToPortrait = false;
        Screen.autorotateToPortraitUpsideDown = false;
        AdaptiveUI();
 
        Screen.sleepTimeout = SleepTimeout.NeverSleep;
//#if UNITY_ANDROID || UNITY_IPHONE
//        Handheld.PlayFullScreenMovie("loading.mp4", Color.black, FullScreenMovieControlMode.CancelOnInput);
//#endif
    }

    private void AdaptiveUI()
    {
        int ManualWidth = 960;
        int ManualHeight = 640;
        UIRoot[] uiRoot = GameObject.FindObjectsOfType<UIRoot>();
        for (int i = 0; i < uiRoot.Length; i++)
        {
            if (uiRoot[i] != null)
            {
                if (System.Convert.ToSingle(Screen.height) / Screen.width > System.Convert.ToSingle(ManualHeight) / ManualWidth)
                    uiRoot[i].manualHeight = Mathf.RoundToInt(System.Convert.ToSingle(ManualWidth) / Screen.width * Screen.height);
                else
                    uiRoot[i].manualHeight = ManualHeight;
            }
        }
       
    }

    
}
