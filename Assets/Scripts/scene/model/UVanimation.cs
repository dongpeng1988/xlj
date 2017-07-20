using UnityEngine;
using System.Collections;





public class UVanimation : MonoBehaviour {
	public Vector2 Tex1speed;
	public Vector2 Tex2speed;
	private Vector2 TEX1uvoffset;
	private Vector2 TEX2uvoffset;
	public Vector2 TEX1uvScale=new Vector2(1,1);
	public Vector2 TEX2uvScale=new Vector2(1,1);
	public Color Tex1color;
	public Color Tex2color;

	private Material mat;
	[ContextMenu("Update")]
	void Awake()
	{
		mat = gameObject.GetComponent<Renderer> ().material;
		mat.SetTextureScale("_MainTex",TEX1uvScale);
		//mat.SetTextureScale("_TEX2",TEX2uvScale);
		mat.SetColor ("_TintColor", Tex1color);
		mat.SetColor ("_2Color", Tex2color);
	}

	void Update () {
		TEX1uvoffset = Tex1speed*Time.time;
		TEX2uvoffset = Tex2speed*Time.time;
		mat.SetTextureOffset("_MainTex",TEX1uvoffset);
		//mat.SetTextureOffset("_TEX2",TEX2uvoffset);

	}
}
