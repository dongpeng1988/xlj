using UnityEngine;
using System.Collections;

public class toCameraWidthXV : MonoBehaviour {
	
	public string colname ="_TintColor";
	public Color col;
	public float angle = 0;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void LateUpdate  () {
		
	
	 	//transform.rotation = Quaternion.LookRotation(Camera.main.transform.position);
		Vector3 pos =  Camera.main.transform.position - transform.position;
		
		
		float roty =  Mathf.Atan2(pos.x,pos.z);
		
        transform.eulerAngles = new Vector3(0  ,roty / Mathf.PI* 180.0f, angle);
		if(GetComponent<Renderer>())
		{
			//renderer.material.color = col;
			GetComponent<Renderer>().material.SetColor(colname,col);
		}
	}
}
