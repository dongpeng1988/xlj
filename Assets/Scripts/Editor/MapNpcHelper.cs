
using sw.ui.model;
using sw.ui.view;
using sw.util;
using System.Collections.Generic;
using UnityEngine;
public class MapNpcHelper
{
    Transform _root = null;
    public Transform getRoot()
    {
        if (_root == null)
        {
            GameObject obj = GameObject.Find("NpcRoot");
            if (obj == null)
            {
                obj = new GameObject("NpcRoot");
                //obj.hideFlags = HideFlags.DontSave;
            }
            _root = obj.transform;
        }
        return _root;
    }
    public void Reset()
    {
         GameObject obj = GameObject.Find("NpcRoot");
         if (obj != null)
         {
             GameObject.DestroyImmediate(obj);
         }
         obj = new GameObject("NpcRoot");
         //obj.hideFlags = HideFlags.DontSave;
         _root = obj.transform;
    }

    public GameObject LoadNpc(MapNpc npc, Vector3 pos)
    {
        string fxname = npc.modelId;
        Object prefab = EditorTool.LoadAssetBundle("model/" + fxname );
        if (prefab == null)
        {
            Debug.LogError("npc 资源找不到:" + fxname);
            npc.modelId = "n_fujiaertongnv";
            fxname = npc.modelId;
            prefab = EditorTool.LoadAssetBundle("model/" + fxname );
            
             
        }

        string subpath = "npc";
        switch (npc.type)
        {
            case 1:
                subpath = "monster";
                break;
            default:
                subpath = "npc";
                break;
        }
        Transform parentTrans = getRoot().FindChild(subpath);
        if (parentTrans == null)
        {
            GameObject subroot = new GameObject(subpath);
            subroot.transform.SetParent(getRoot());
            parentTrans = subroot.transform;
        }
        string nodeName = "npc_" + npc.uniqueId;



        GameObject npcObj = (GameObject)GameObject.Instantiate(prefab);
        GameObject npcCont = new GameObject(nodeName);
        npcObj.transform.SetParent(npcCont.transform);
        npcObj.transform.localPosition = Vector3.zero;

        npcCont.transform.SetParent(parentTrans);
        //x y坐标
        npcCont.transform.localPosition = pos;
        //direction 是弧度 * 1000 只记了y方向的旋转
        //npcCont.transform.localRotation.eulerAngles = new Vector3(0,npc.direction / 1000 / 2 / Mathf.PI * 360,0);
        MapNpcView view = npcCont.AddComponent<MapNpcView>();
        view.data = npc;
        npc.target = npcCont;
        return npcCont;

    }
    public GameObject AddMapZone(MapZone zone, Vector3 pos)
    {
        GameObject go = new GameObject("mapzone_" + zone.id);
        MeshFilter mf = go.AddComponent<MeshFilter>();
        MeshRenderer mr = go.AddComponent<MeshRenderer>();
        Mesh mesh = new Mesh();
        List<Vector3> verts = new List<Vector3>();
        if (zone.regiontype == 0)
        {
            float x = PathUtilEdit.Logic2RealLen(zone.width / 2f);
            float z = PathUtilEdit.Logic2RealLen(zone.height / 2f);

            //verts.Add(new Vector3(0, 0, 2f*z));
            //verts.Add(new Vector3(2f*x, 0, 2f*z));
            //verts.Add(new Vector3(2f*x, 0, 0));
            //verts.Add(new Vector3(0, 0, 0));

            verts.Add(new Vector3(0, 0, 0));
            verts.Add(new Vector3(2f * x, 0, 0));
            verts.Add(new Vector3(2f * x, 0, -2f * z));
            verts.Add(new Vector3(0, 0, -2f * z));
            
            
            
            mesh.vertices = verts.ToArray();
 
            
            mesh.SetTriangles(new int[] { 0, 1, 2, 0, 2, 3 }, 0);
            Color cl = new Color(0, 0, 1);
            mesh.colors = new Color[] { cl, cl, cl, cl };
        }
        else
        {
            Debug.LogError("暂不支持点列类型的区域");
            return null;
        }
        mr.material = Resources.Load("Materials/Ground_tile_material") as Material;
        mf.mesh = mesh;
        string subpath = "zone";
        Transform parentTrans = getRoot().FindChild(subpath);
        if (parentTrans == null)
        {
            GameObject subroot = new GameObject(subpath);
            subroot.transform.SetParent(getRoot());
            parentTrans = subroot.transform;
        }
        go.transform.SetParent(parentTrans);
        go.transform.localPosition = pos;
        if (zone.eulerangles != null)
        {
            string[] arr = zone.eulerangles.Split(',');
            if (arr.Length == 3)
            {
                //npcObj.transform.Rotate(float.Parse(arr[0]), float.Parse(arr[1]), float.Parse(arr[2]));
                go.transform.localRotation = Quaternion.Euler(float.Parse(arr[0]), float.Parse(arr[1]), float.Parse(arr[2]));
            }
        }
        MapZoneView view = go.AddComponent<MapZoneView>();
        view.data = zone;
        zone.target = go;
        return go;
    }
    public GameObject AddWarp(MapWarp warp,Vector3 pos)
    {

        Object prefab = EditorTool.LoadAssetBundle("model/n_fujiaertongnv.unity3d");
        if (prefab == null)
        {
            Debug.LogError("传送门 资源找不到:model/n_fujiaertongnv.unity3d");

            return null;


        }

        string subpath = "warp";
        Transform parentTrans = getRoot().FindChild(subpath);
        if (parentTrans == null)
        {
            GameObject subroot = new GameObject(subpath);
            subroot.transform.SetParent(getRoot());
            parentTrans = subroot.transform;
        }
        string nodeName = "warp_" + warp.id;



        GameObject npcObj = (GameObject)GameObject.Instantiate(prefab);
        npcObj.name = nodeName;


        npcObj.transform.SetParent(parentTrans);
        npcObj.transform.localPosition = pos;
        MapWarpView view = npcObj.AddComponent<MapWarpView>();
        view.data = warp;
        foreach(ParticleSystem ps in npcObj.GetComponentsInChildren<ParticleSystem>())
        {
            ps.Play(true);
        }
        warp.target = npcObj;
        return npcObj;
    }

    public GameObject AddDoor(MapDoor door, Vector3 pos)
    {

        Object prefab = EditorTool.LoadAssetBundle("model/sence_chuansong.unity3d");
        if (prefab == null)
        {
            Debug.LogError("阻挡门 资源找不到:model/sence_chuansong.unity3d");

            return null;


        }

        string subpath = "door";
        Transform parentTrans = getRoot().FindChild(subpath);
        if (parentTrans == null)
        {
            GameObject subroot = new GameObject(subpath);
            subroot.transform.SetParent(getRoot());
            parentTrans = subroot.transform;
        }
        string nodeName = "door_" + door.id;



        GameObject npcObj = (GameObject)GameObject.Instantiate(prefab);
        npcObj.name = nodeName;


        npcObj.transform.SetParent(parentTrans);
        npcObj.transform.localPosition = pos;
        if(door.eulerangles != null)
        {
            string[] arr = door.eulerangles.Split(',');
            if (arr.Length == 3)
            {
                //npcObj.transform.Rotate(float.Parse(arr[0]), float.Parse(arr[1]), float.Parse(arr[2]));
                npcObj.transform.localRotation = Quaternion.Euler(float.Parse(arr[0]), float.Parse(arr[1]), float.Parse(arr[2]));
            }
        }
            
        MapDoorView view = npcObj.AddComponent<MapDoorView>();
        view.data = door;
        foreach (ParticleSystem ps in npcObj.GetComponentsInChildren<ParticleSystem>())
        {
            ps.Play(true);
        }
        door.target = npcObj;
        return npcObj;
    }

    public GameObject AddTrigger(MapTrigger trigger, Vector3 pos)
    {
        Object prefab = EditorTool.LoadAssetBundle("model/scene_portal_e.unity3d");
        if (prefab == null)
        {
            Debug.LogError("传送门 资源找不到:model/scene_portal_e.unity3d");

            return null;


        }

        string subpath = "trigger";
        Transform parentTrans = getRoot().FindChild(subpath);
        if (parentTrans == null)
        {
            GameObject subroot = new GameObject(subpath);
            subroot.transform.SetParent(getRoot());
            parentTrans = subroot.transform;
        }
        string nodeName = "trigger_" + trigger.id;



        GameObject npcObj = (GameObject)GameObject.Instantiate(prefab);
        npcObj.name = nodeName;


        npcObj.transform.SetParent(parentTrans);
        npcObj.transform.localPosition = pos;
        if(trigger.eulerangles != null)
        {
            string[] arr = trigger.eulerangles.Split(',');
            if (arr.Length == 3)
            {
                //npcObj.transform.Rotate(float.Parse(arr[0]), float.Parse(arr[1]), float.Parse(arr[2]));
                npcObj.transform.localRotation = Quaternion.Euler(float.Parse(arr[0]), float.Parse(arr[1]), float.Parse(arr[2]));
            }
        }
        
        
        MapTriggerView view = npcObj.AddComponent<MapTriggerView>();
        view.data = trigger;
        foreach (ParticleSystem ps in npcObj.GetComponentsInChildren<ParticleSystem>())
        {
            ps.Play(true);
        }
        trigger.target = npcObj;
        return npcObj;
    }


    public GameObject AddEffectPoint(MapEffectPoint effectPoint, Vector3 pos)
    {
        if (effectPoint.res == "" || effectPoint.res == null)
            effectPoint.res = "fx/scene_anquanquhouqiu";
        Object prefab = EditorTool.LoadAssetBundle(effectPoint.res+".unity3d");
        //Object prefab = EditorTool.LoadAssetBundle("fx/scene_anquanquhouqiu.unity3d");
        if (prefab == null)
        {
            Debug.LogError("传送门 资源找不到:" + effectPoint.res );
            //Debug.LogError("传送门 资源找不到:fx/scene_anquanquhouqiu.unity3d");
            return null;
        }

        string subpath = "effectPoint";
        Transform parentTrans = getRoot().FindChild(subpath);
        if (parentTrans == null)
        {
            GameObject subroot = new GameObject(subpath);
            subroot.transform.SetParent(getRoot());
            parentTrans = subroot.transform;
        }
        string nodeName = "effect_" + effectPoint.id;



        GameObject npcObj = (GameObject)GameObject.Instantiate(prefab);
        npcObj.name = nodeName;


        npcObj.transform.SetParent(parentTrans);
        npcObj.transform.localPosition = pos;
        if (effectPoint.eulerangles != null)
        {
            string[] arr = effectPoint.eulerangles.Split(',');
            if (arr.Length == 3)
            {
                //npcObj.transform.Rotate(float.Parse(arr[0]), float.Parse(arr[1]), float.Parse(arr[2]));
                npcObj.transform.localRotation = Quaternion.Euler(float.Parse(arr[0]), float.Parse(arr[1]), float.Parse(arr[2]));
            }
        }
        
        
        MapEffectPointView view = npcObj.AddComponent<MapEffectPointView>();
        view.data = effectPoint;
        foreach (ParticleSystem ps in npcObj.GetComponentsInChildren<ParticleSystem>())
        {
            ps.Play(true);
        }
        effectPoint.target = npcObj;
        return npcObj;
    }
    

    public GameObject AddLine(MapLine line)
    {
        string subpath = "line";
        Transform parentTrans = getRoot().FindChild(subpath);
        if (parentTrans == null)
        {
            GameObject subroot = new GameObject(subpath);
            subroot.transform.SetParent(getRoot());
            parentTrans = subroot.transform;
        }

        string thirdpath = "mapline_" + line.starobjid;
        Transform grandParentTrans = getRoot().FindChild(thirdpath);
        GameObject thirdroot;
        if (grandParentTrans == null)
        {
            thirdroot = new GameObject(thirdpath);
            MapLineView view = thirdroot.AddComponent<MapLineView>();
            view.data = line;
            thirdroot.transform.SetParent(parentTrans);
            grandParentTrans = thirdroot.transform;
        }
        else
            thirdroot = grandParentTrans.gameObject;

        for(int i = 0 ;i < line.linepts.Count ;i ++)
        {
            if (grandParentTrans.FindChild("points" + (i + 1)))
                continue;

            
            GameObject go = new GameObject("points" + (i+1));
            MeshFilter mf = go.AddComponent<MeshFilter>();
            MeshRenderer mr = go.AddComponent<MeshRenderer>();
            MapLinePointView pointView = go.AddComponent<MapLinePointView>();
            pointView.data = line.linepts[i];
            pointView.target = go;
            Mesh mesh = new Mesh();
            List<Vector3> verts = new List<Vector3>();

            float x = 0.5f;
            float z = 0.5f;

            verts.Add(new Vector3(-x, 0, z));
            verts.Add(new Vector3(x, 0, z));
            verts.Add(new Vector3(x, 0, -z));
            verts.Add(new Vector3(-x, 0, -z));
            mesh.vertices = verts.ToArray();


            mesh.SetTriangles(new int[] { 0, 1, 2, 0, 2, 3 }, 0);
            Color cl = new Color(0, 1, 1);
            mesh.colors = new Color[] { cl, cl, cl, cl };

            mr.material = Resources.Load("Materials/Ground_tile_material") as Material;
            mf.mesh = mesh;

            go.transform.SetParent(grandParentTrans);
            Vector2 real_pos = PathUtilEdit.logicCenter2Real((int)line.linepts[i].x, (int)line.linepts[i].y);
            float h1 = EditorData.terrainMan.GetHeight(real_pos.x, real_pos.y) + 0.1f;
            Vector3 tempPos = new Vector3(real_pos.x, h1, real_pos.y);
            go.transform.localPosition = tempPos;
        }





        line.target = thirdroot;
        return thirdroot;
    }
}
 