using UnityEngine;
using System.Collections;

public class mndead : MonoBehaviour {
	
	public Vector3 dir;
	// Use this for initialization
	void Start () {
		Rigidbody[] rg = GetComponentsInChildren<Rigidbody>(); 
		
		foreach(Rigidbody rgn in rg)
		{
			rgn.isKinematic = true;
		}
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.D))
		{
				Rigidbody[] rg = GetComponentsInChildren<Rigidbody>();
				if(rg.Length>0)
				{
					//关闭动作
					Animation []pani = GetComponentsInChildren<Animation>();
					for(int i=0;i<pani.Length;i++)
					{
						pani[i].enabled = false;
					}
				}
				
				foreach(Rigidbody rgn in rg)
				{
					rgn.isKinematic =false;
				}
			vtt = true;
		}
	}
	bool vtt  =false;
	void LateUpdate()
	{
		if(vtt)
		{
			vtt =false;

			Rigidbody[] rg = GetComponentsInChildren<Rigidbody>();
			if(rg.Length>0)
			{
				//关闭动作
				Animation []pani = GetComponentsInChildren<Animation>();
				for(int i=0;i<pani.Length;i++)
				{
					pani[i].enabled = false;
				}
			}
		 	dir = -transform.forward;
			float pow=400;
			foreach(Rigidbody rgn in rg)
			{
				rgn.AddForce(dir.x*pow,pow,dir.z*pow);
			}
		}
		
	}
	void OnGUI()
	{
 
	}
}
