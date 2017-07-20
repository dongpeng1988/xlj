using UnityEngine;
using System.Collections;

public class SetMateril : MonoBehaviour {
	public Color col = new Color(1,1,1,1);
	void SetColor(Transform ts,Color col)
	{
		if(ts.GetComponent<Renderer>()!=null)
		{
			foreach(Material mt in ts.GetComponent<Renderer>().sharedMaterials)
			{
				if(mt!=null)
				{
					mt.color = col;
				}
			}
		}
		foreach(Transform ch in ts)
		{
			SetColor(ch,col);
		}
	}
	// Use this for initialization
	void Start () {

		
	}
	
	// Update is called once per frame
	void Update () {
		SetColor(transform,col);
	}
}
