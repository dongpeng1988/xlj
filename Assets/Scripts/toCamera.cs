using UnityEngine;
using System.Collections;

public class toCamera : MonoBehaviour {
	
	public float dist = 20;
	public float maxDis = 20;
	// Use this for initialization
	void Start () {
	
	}
	void OnPerRender()
	{
	}

	void LateUpdate()
	{
		Vector3 dir = Camera.main.transform.position - transform.position;
		float maxdis = dir.magnitude;
		dir.Normalize();
		transform.position =  transform.parent.position + dir* Mathf.Min(maxdis*0.5f,dist); 
//		if(dist>maxDis)
//			dist =maxDis;
//		if(dist<0)
//			dist = 0;
		//transform.look(
	}

}
