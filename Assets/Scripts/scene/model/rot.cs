using System;
using System.Xml;
using UnityEngine;
public class rot : TEffectBase
{
	public Vector3 rotspeed = new Vector3(0f, 0f, 0f);
	private void Awake()
	{
		this.mEffectType = TEffectScriptType.TEffectScriptType_RotObject;
	}
	public override void GetValue(XmlElement ele)
	{
		string attribute = ele.GetAttribute("rotspeed");
		string[] array = attribute.Split(new char[]
		{
			','
		});
		this.rotspeed.x = float.Parse(array[0]);
		this.rotspeed.y = float.Parse(array[1]);
		this.rotspeed.z = float.Parse(array[2]);
		base.GetValue(ele);
	}
	public override void SaveValue(XmlElement ele)
	{
		ele.SetAttribute("rotspeed", string.Concat(new string[]
		{
			this.rotspeed.x.ToString(),
			",",
			this.rotspeed.y.ToString(),
			",",
			this.rotspeed.z.ToString()
		}));
		base.SaveValue(ele);
	}
	private void Update()
	{
		Vector3 vector = default(Vector3);
		vector = this.rotspeed * Time.deltaTime;
		Transform expr_1F = base.transform;
		expr_1F.eulerAngles=expr_1F.eulerAngles + vector;
	}
}
