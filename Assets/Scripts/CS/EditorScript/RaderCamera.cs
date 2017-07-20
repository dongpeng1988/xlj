using UnityEngine;
using System.Collections;
using System.IO;
public class RaderCamera : MonoBehaviour {
	
	public RenderTexture rtex  ;
	// Use this for initialization
	void Start () {
		 
	}
	
	public void SaveRadarMap(string radarname)
	{				
        //float nwid = TerrainManager.GetInstance().terrwid;
		
		float mt =200 * 1.5f;// Mathf.Sqrt( nwid*nwid +nwid*nwid);
		
        //GetComponent<Camera>().transform.position = new Vector3(nwid/2,100 ,nwid/2);
		GetComponent<Camera>().transform.eulerAngles = new Vector3(90, 0 ,0);
		GetComponent<Camera>().orthographicSize = mt/2;
		GetComponent<Camera>().Render();
		RenderTexture.active = rtex; //thumbnail is a RenderTexture
		Texture2D thumb_tex = new Texture2D(1024, 1024 ,TextureFormat.RGB24,false);
		thumb_tex.ReadPixels(GetComponent<Camera>().pixelRect,0,0,true);
		RenderTexture.active = null;
		thumb_tex.Apply();
		byte[] bytes = thumb_tex.EncodeToPNG(); 
		
 
        using (FileStream fs = File.Create(radarname))
        {
            fs.Write(bytes, 0, bytes.Length);
        }
	}
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.S))
		{

		}
	}
}
