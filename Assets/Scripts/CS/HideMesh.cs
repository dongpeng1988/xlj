using UnityEngine;
using System.Collections;

public class HideMesh : MonoBehaviour {
	public string execptname;
	// Use this for initialization
	public void THideMeshRenderer(Transform pf,bool tv)
	{
		if(pf.name!=execptname)
		{
			pf.GetComponent<Renderer>().enabled = tv;
		}
		foreach(Transform ts in pf.transform)
		{
			THideMeshRenderer(ts,tv);
		}
	}
	void Start () {
		THideMeshRenderer(transform,false);
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
