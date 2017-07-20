using UnityEngine;
using System.Collections;

public class liuguang : MonoBehaviour {

	// Use this for initialization
	public Vector2 offuv  = new Vector2();
	public float fMoveSpeedX = 2;
	public float fMoveSpeedY = 2;
	void Start () {
	 	 Mesh mesh =transform.GetComponent<MeshFilter>().mesh;
		 Vector3[] vertices  = mesh.vertices; 
		 Vector2[] uvs  = new Vector2[vertices.Length];
		 for (int i = 0 ; i < uvs.Length; i++)
			uvs[i] =new Vector2(vertices[i].x, vertices[i].z); 
		 mesh.uv2 = uvs;
	}
	
	// Update is called once per frame
	void Update () {
		
		offuv.x += Time.deltaTime * fMoveSpeedX;
		offuv.y += Time.deltaTime * fMoveSpeedY;
		transform.GetComponent<Renderer>().material.SetTextureOffset("_LiuTex", offuv);
	
	}
}
