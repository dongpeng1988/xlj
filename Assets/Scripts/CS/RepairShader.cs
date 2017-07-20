using UnityEngine;
using System.Collections;

public class RepairShader : MonoBehaviour {

	// Use this for initialization
	void Start () {
		RepShader(transform);
	}
	void RepShader(Transform tst)
	{
		if(tst.GetComponent<Renderer>()!=null)
		{
			foreach(Material mt in tst.GetComponent<Renderer>().sharedMaterials)
			{
				if(mt.shader.name.Length==0)
				{
					mt.shader = Shader.Find("Diffuse");
				}
			}
		}
		
		foreach(Transform tc in tst)
		{
			RepShader(tc);
		}
	}
	// Update is called once per frame
	void Update () {
	
	}
}
