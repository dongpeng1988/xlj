
using sw.res;
using System;
using System.Collections.Generic;
using UnityEngine;
public class LODLoader:MonoBehaviour
{
    public string path;
    public string assetName;
    public Bounds bounds;
    public static Vector3 rolePos;
    Transform trans;
    const float LOAD_DIST_X = 50;
    const float LOAD_DIST_Z = 50;
    bool canShow;
    GameObject subNode;
    public int lightmapIndex;
    public Vector4 offsetScale;
    public int index;
    public Action<int> del;
    public Dictionary<string, SaveLightmapToRenderer.LightmapInfo> litmaps = new Dictionary<string, SaveLightmapToRenderer.LightmapInfo>();
    void Start()
    {
        trans = base.transform;
        //InvokeRepeating("checkDist", 0.2f, 0.2f);
    }
    public void setPath(string _path)
    {
        path = _path;
        assetName = _path.Split('/')[_path.Split('/').Length - 1];
        assetName = assetName.Split('.')[0];
    }
    public void saveLitMap(GameObject go)
    {
        //Renderer[] renders = go.gameObject.GetComponentsInChildren<Renderer>();
        //for (int i = 0; i < renders.Length; i++)
        //{
        //    SaveLightmapToRenderer.LightmapInfo info = new SaveLightmapToRenderer.LightmapInfo();
        //    info.renderer = renders[i];
        //    info.lightmapIndex = renders[i].lightmapIndex;
        //    info.offsetScale = renders[i].lightmapScaleOffset;
        //    litmaps.Add(info.renderer.gameObject.name,info);
        //}
        if (go.GetComponent<Renderer>() != null)
        {
            Renderer r = go.GetComponent<Renderer>();
            lightmapIndex = r.lightmapIndex;
            offsetScale = r.lightmapScaleOffset;
        }
    }
    public bool checkDist()
    {
        //if (canShow)
        //    return;
        //AssetLoader2.Instance.LoadAsset(path, assetName, typeof(GameObject), onLoad);
        //Debug.Log(name + " pos:" + Camera.main.transform.InverseTransformPoint(trans.position));
        if (subNode!=null)
            return true;
        Vector3 delta = base.transform.position - rolePos;
        bool show = Mathf.Abs(delta.x) - bounds.extents.x < LOAD_DIST_X && Mathf.Abs(delta.z) - bounds.extents.z < LOAD_DIST_Z;
        if (canShow == show)
            return false;
        canShow = show;
        if (canShow)
        {
            if (subNode != null)
                subNode.SetActive(true);
            else
                AssetLoader2.Instance.LoadAsset(path, assetName, typeof(GameObject), onLoad);
        }
        return false;
        //else if (subNode != null)
        //    subNode.SetActive(false);
    }
    void onLoad(UnityEngine.Object obj, object[] param)
    {
        if (obj == null)
            return;
        if (subNode != null)
            return;
        subNode = GameObject.Instantiate(obj) as GameObject;
        subNode.gameObject.SetActive(true);
        Transform t = subNode.transform;
        t.SetParent(trans);
        t.localPosition = Vector3.zero;
        t.localScale = Vector3.one;
        t.localRotation = Quaternion.identity;
        if (subNode.GetComponent<Renderer>() != null)
        {
            Renderer r = subNode.GetComponent<Renderer>();
            r.lightmapIndex = lightmapIndex;
            r.lightmapScaleOffset=offsetScale;
        }
        //del(index);
        //canShow = true;

    }
}
 
