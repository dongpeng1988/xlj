using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using sw.ui.model;

public class EditMapCameraManager
{
    public bool showMainCamera = true;
    public GameObject editMapCamera_obj;
    public Camera editMapCamera;
    public Camera mainCamera;
    public bool use_tile_101002 = false;
    public string mapResId;
    public string mapTileId;
    public void switchEditMapCamera()
    {
        CameraCtrl mainCameraCtrl;
        EditMapCameraCtrl editMapCameraCtrl;
        showMainCamera = !showMainCamera;
        GameObject mainCamera_obj = GameObject.Find("Main Camera");
        mainCamera = mainCamera_obj.GetComponent<Camera>();
        if(!showMainCamera)
        {
            mainCameraCtrl = mainCamera_obj.GetComponent<CameraCtrl>();
            UnityEngine.Object.Destroy(mainCameraCtrl);
            mainCamera_obj.AddComponent<EditMapCameraCtrl>();
        }
        else
        {
            editMapCameraCtrl = mainCamera_obj.GetComponent<EditMapCameraCtrl>();
            UnityEngine.Object.Destroy(editMapCameraCtrl);
            mainCameraCtrl = mainCamera_obj.AddComponent<CameraCtrl>();
            mainCameraCtrl.taget = GameObject.Find("renwu").transform;

        }
        //if (editMapCamera_obj == null || editMapCamera_obj.name == "")
        //{
        //    editMapCamera_obj = new GameObject();
        //    editMapCamera_obj.transform.parent = mainCamera_obj.transform.parent;
        //    editMapCamera_obj.transform.position = mainCamera_obj.transform.position;
        //    editMapCamera_obj.transform.rotation = mainCamera_obj.transform.rotation;
        //    //editMapCamera.
        //    editMapCamera_obj.gameObject.AddComponent<EditMapCameraCtrl>();
        //    editMapCamera_obj.gameObject.AddComponent<Camera>();
        //    editMapCamera_obj.name = "editMapCamera";

        //    editMapCamera = editMapCamera_obj.gameObject.GetComponent<Camera>();
        //    editMapCamera.depth = 0;
        //    editMapCamera.fieldOfView = 50;
        //}
        ////(mainCamera as Camera).enabled = showMainCamera;
        //editMapCamera.enabled = !showMainCamera;
        
    }

    public void readMapXML(int mapXmlId)
    {
        EditMapManager.Instance.readMapXML(mapXmlId);
    }

    public void saveMapXML()
    {
        EditMapManager.Instance.saveMapXML();
    }

    public void addWarp(MapWarp warp)
    {
        EditMapManager.Instance.addMapWarp(warp);
    }
    private static EditMapCameraManager _instance;
    public static EditMapCameraManager Instance
    {
        get
        {
            if (_instance == null)
            {
                _instance = new EditMapCameraManager();
            }
            return _instance;
        }

    }
}

   