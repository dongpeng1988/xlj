
using System;
using System.Collections;
using System.IO;
using UnityEngine;
public class TileImg : MonoBehaviour
{
    int count = 0;
    public Camera camera;
    public GameObject target;
    private Bounds bound;
    private int screenSize = 256;
    private bool next;
    private const float GRIDSIZE = 0.8f;
    private const int GRIDPIXEL = 4;
    const int BLOCKPIXEL = 256;
    private const float BLOCKSIZE = 250 * GRIDSIZE / GRIDPIXEL;
    
    void Start()
    {
        camera = Camera.main;
        target = gameObject;
       

    }
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.D))
        {
            GetBoundBox();
            Debug.Log("bounds:" + bound);
            next = true;
            StartCoroutine(DoImg());
        }
        else if (Input.GetKeyDown(KeyCode.N))
        {
            next = true;
        }
    }
    private void GetBoundBox()
    {
        //bound = new Bounds(new Vector3(42.8f, 7.2f, -67.5f), new Vector3(28.1f * 2, 24.1f * 2, 35.2f * 2));
        //return;
        Transform tran = target.transform;

        //Debug.Log("trans name:" + tran.name);
        MeshFilter[] meshes = tran.GetComponentsInChildren<MeshFilter>();
        //Quaternion quat = tran.rotation;//object axis AABB
        //tran.rotation = Quaternion.Euler(0f, 0f, 0f);
        //Debug.Log("mesh len:" + meshes.Length);
        bool bFirst = true;
        for (int i = 0; i < meshes.Length; i++)
        {
            Mesh ms = meshes[i].mesh;
            if (bFirst)
                bound = new Bounds(ms.bounds.center, ms.bounds.extents);
            else
                bound.Encapsulate(ms.bounds);
            bFirst = false;
            //Vector3 tr = meshes[i].gameObject.transform.position;
            //Vector3 ls = meshes[i].gameObject.transform.lossyScale;
            //Quaternion lr = meshes[i].gameObject.transform.rotation;
            //int vc = ms.vertexCount;
            //for (int j = 0; j < vc; j++)
            //{
            //    if (i == 0 && j == 0)
            //    {
            //        bound = new Bounds(tr + lr * Vector3.Scale(ls, ms.vertices[j]), Vector3.zero);
            //    }
            //    else
            //    {
            //        bound.Encapsulate(tr + lr * Vector3.Scale(ls, ms.vertices[j]));
            //    }
            //}
        }
        MeshRenderer[] renders = tran.GetComponentsInChildren<MeshRenderer>();
        //Debug.Log("renders len:" + renders.Length);
        for (int i = 0; i < renders.Length; i++)
        {
            bound.Encapsulate(renders[i].bounds);
            Debug.Log("render bounds:" + renders[i].bounds);
        }
        SkinnedMeshRenderer[] renders2 = tran.GetComponentsInChildren<SkinnedMeshRenderer>();
        //Debug.Log("renders2 len:" + renders2.Length);
        for (int i = 0; i < renders2.Length; i++)
        {
            bound.Encapsulate(renders2[i].bounds);
            //Debug.Log("render bounds:" + renders2[i].bounds);
        }

        //tran.rotation = quat;
    }

    IEnumerator DoImg()
    {

        CameraCtrl ctrl = camera.GetComponent<CameraCtrl>();
        RenderSettings.fog = false;
        if (ctrl != null)
            ctrl.enabled = false;
        
        float z = bound.extents.z * 2;
        float startX = bound.center.x - bound.extents.x;
        float startZ = bound.center.z - bound.extents.z;
   

        int w = (int)Math.Ceiling(bound.extents.x * GRIDPIXEL * 2 / GRIDSIZE / BLOCKPIXEL);
        int h = (int)Math.Ceiling(bound.extents.z * GRIDPIXEL * 2 / GRIDSIZE / BLOCKPIXEL);
        startZ -= (h * BLOCKSIZE - bound.extents.z * 2);
        camera.orthographic = true;

        camera.orthographicSize = (float)Screen.height * BLOCKSIZE / 2 / BLOCKPIXEL;
        Debug.Log("w:" + w + ",h:" + h + ",orthographicSize:" + camera.orthographicSize);
        Texture2D texture = new Texture2D(w * BLOCKPIXEL, h * BLOCKPIXEL, TextureFormat.RGB24, false);
        int width = Screen.width;
        int height = Screen.height;
        Texture2D texture2 = new Texture2D(BLOCKPIXEL, BLOCKPIXEL, TextureFormat.RGB24, false);
        //Rect r = camera.pixelRect;
        //RenderTexture rt = new RenderTexture(width, height, 0);
        //camera.pixelRect = new Rect(0, 0, Screen.width, Screen.height);  
        //camera.targetTexture = rt;  
        
        for (int i = 0; i < w; i++)
            for (int j = 0; j < h; j++)
            {
                camera.transform.position = new Vector3((i + 0.5f) * BLOCKSIZE + startX, 500, startZ + (j + 0.5f) * BLOCKSIZE);
                camera.transform.rotation = Quaternion.Euler(90, 0, 0);
                Debug.Log("delta:" + bound.center.x + "," + bound.extents.x + ",pos:" + camera.transform.position);
                yield return new WaitForEndOfFrame();
                Rect rect = new Rect((Screen.width - BLOCKPIXEL) / 2, (Screen.height - BLOCKPIXEL) / 2, BLOCKPIXEL, BLOCKPIXEL);

                texture.ReadPixels(rect, i * BLOCKPIXEL, j * BLOCKPIXEL);
                //texture2.ReadPixels(rect, 0, 0);
                //texture2.Apply();
                //yield return null;
                //byte[] bytes = texture2.EncodeToPNG();

                // save our test image (could also upload to WWW)
                //File.WriteAllBytes(Application.dataPath + "/../testscreen-" + i + "_" + j + ".png", bytes);

                count++;
                next = false;
                //while (!next)
                yield return null;
            }


        //camera.targetTexture = null;
        //RenderTexture.active = null;
        //UnityEngine.Object.Destroy(rt);  
        DestroyObject(texture2);
        texture.Apply();

        // split the process up--ReadPixels() and the GetPixels() call inside of the encoder are both pretty heavy
        yield return 0;

        byte[] bytes2 = texture.EncodeToPNG();

        // save our test image (could also upload to WWW)
        File.WriteAllBytes(Application.dataPath + "/../testscreen.png", bytes2);
        //count++;

        // Added by Karl. - Tell unity to delete the texture, by default it seems to keep hold of it and memory crashes will occur after too many screenshots.
        DestroyObject(texture);
        Debug.Log("finished.......................");

    }
}
