using UnityEngine;
using System.Collections;

public class roteffect : MonoBehaviour {

 	Vector2 offuv = new Vector2();
	public float rotspeed = 5;
	void Start () {
	 	 Mesh mesh =transform.GetComponent<MeshFilter>().mesh;
		 Vector3[] vertices  = mesh.vertices; 
		 Vector2[] uvs  = new Vector2[vertices.Length];
		 for (int i = 0 ; i < uvs.Length; i++)
			uvs[i] =new Vector2(vertices[i].x/10.0f, vertices[i].z/10.0f); 
		 mesh.uv2 = uvs;
	}
	
	// Update is called once per frame
	void Update () 
	{
		Quaternion rotation = new Quaternion();
		
		rotation = Quaternion.Euler(new Vector3(0, Time.time * rotspeed, 0));
		
		Matrix4x4 matrot = new Matrix4x4();
		matrot.SetTRS(new Vector3(0.5f,0,0.5f),rotation,new Vector3(1,1,1));
		
		Mesh mesh =transform.GetComponent<MeshFilter>().mesh;
		Vector3[] vertices  = mesh.vertices; 
		Vector2[] uvs  = new Vector2[vertices.Length];
		for (int i = 0 ; i < uvs.Length; i++)
		{
			uvs[i] =new Vector2(vertices[i].x/10.0f, vertices[i].z/10.0f); 
			Vector3 np =matrot.MultiplyPoint(new Vector3(uvs[i].x,0,uvs[i].y));
			uvs[i].x = np.x ;
			uvs[i].y = np.z ;
		}
		mesh.uv2 = uvs;
 
	}
}
