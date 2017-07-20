using UnityEngine;
using System.Collections;

public class TextureChange : MonoBehaviour {
	
	public int curTexIdx;
	public Texture2D [] img;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if( Input.GetKeyDown(KeyCode.Y) )
		{
			curTexIdx++;
			if(img.Length>0)
			{
				transform.GetComponent<Renderer>().material.mainTexture = img[curTexIdx%img.Length];
			}
		}
	}
	
}
