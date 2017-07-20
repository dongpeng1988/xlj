using UnityEngine;
using System.Collections;

public class lightmap : MonoBehaviour {

	/**
	 * @Lynn
	 * 3中Lightmaps加载方式 只需选择一种添加
    	 */

	public Texture2D [] textures;             //SingleLightmaps
	public Texture2D [] direLightmaps;        //DirectionalLightmaps
	public Texture2D [] dualLightmaps;        //DualLightmaps
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
