using System;
using System.Xml;
using UnityEngine;
public class TEffectBase : MonoBehaviour
{
	public BindBody body;
	public TEffectScriptType mEffectType;
	public virtual void SaveValue(XmlElement ele)
	{
	}
	public virtual void GetValue(XmlElement ele)
	{
	}
	public virtual void ReInit()
	{
	}
	public virtual void Play()
	{
	}
	public virtual string GetCaption()
	{
		return base.GetType().ToString();
	}
}
