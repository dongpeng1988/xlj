using UnityEngine;
using System.Collections;

public class Move : MonoBehaviour {
	
	public float fMoveSpeed = 0.2f;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
		Vector3 npos = new Vector3();
		npos = transform.position;
		npos.x += fMoveSpeed* Time.deltaTime;
		transform.position = npos;
	/*	if(fMoveSpeed>0)
		{
			if(npos.x> 130)
			{
				fMoveSpeed*=-1.0f;
			}
		}
		else{
			if(npos.x < 100)
			{
				fMoveSpeed*=-1.0f;
			}
		}
		*/
	}
}
