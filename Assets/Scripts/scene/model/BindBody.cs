using System;
using UnityEngine;
public class BindBody : MonoBehaviour
{
	public Transform body;
	public string strBindAniName;
	private Transform oldbody;
	public bool bSetPlayAwake = true;
	public bool bPlyAwake;
    //void OnGUI()
    //{
    //    GUI.Button(new Rect(100, 226, 100, 50), "play");
    //    if (GUI.Button(new Rect(100, 226, 100, 50), "play"))
    //    {
    //        Play();
    //    }
    //}
	private void Start()
	{
		TEffectBase[] componentsInChildren = base.GetComponentsInChildren<TEffectBase>();
		TEffectBase[] array = componentsInChildren;
		for (int i = 0; i < array.Length; i++)
		{
			TEffectBase tEffectBase = array[i];
			tEffectBase.body = this;
		}
		this.SetChild(base.transform);
		this.StopTransForm(base.transform);
		if (this.bSetPlayAwake)
		{
			this.SetPlyAwake(base.transform, this.bPlyAwake);
			if(this.bPlyAwake)
			{
				this.Play();
			}
		}
	}
	public void SetPlyAwake(Transform ts, bool bv)
	{
		if (ts.GetComponent<Animation>())
		{
			ts.GetComponent<Animation>().playAutomatically=bv;
		}
		if (ts.GetComponent<ParticleSystem>())
		{
			ts.GetComponent<ParticleSystem>().playOnAwake=bv;
		}
		if (ts.GetComponent<AudioSource>())
		{
			ts.GetComponent<AudioSource>().playOnAwake=bv;
		}
		if (ts.GetComponent<Light>())
		{
			ts.GetComponent<Light>().enabled=bv;
		}
		foreach (Transform ts2 in ts)
		{
			this.SetPlyAwake(ts2, bv);
		}
	}
	public void StopTransForm(Transform ts)
	{
		Delay component = ts.GetComponent<Delay>();
		if (component)
		{
			return;
		}
		if (ts.GetComponent<Animation>())
		{
			ts.GetComponent<Animation>().Stop();
			ts.GetComponent<Animation>().wrapMode=WrapMode.Once;
		}
		if (ts.GetComponent<ParticleSystem>())
		{
			ts.GetComponent<ParticleSystem>().Stop();
		}
		if (ts.GetComponent<AudioSource>())
		{
			ts.GetComponent<AudioSource>().Stop();
		}
		foreach (Transform ts2 in ts)
		{
			this.StopTransForm(ts2);
		}
	}
    public void StopAnimator(Transform ts)
    {
        if (ts.GetComponent<Animator>())
        {
            ts.GetComponent<Animator>().SetTrigger("stop");
        }
        foreach (Transform ts2 in ts)
        {
            this.StopAnimator(ts2);
        }
    }
	private void Awake()
	{
	}
	public void SetBindBody(Transform tb)
	{
		this.body = tb;
		this.oldbody = tb;
		this.SetChild(base.transform);
	}
	private void SetChild(Transform ts)
	{
		if (this.body == null)
		{
			return;
		}
		EffectBind component = ts.GetComponent<EffectBind>();
		if (component != null)
		{
			if (this.body != null)
			{
				component.ts = TEngine.GetChildByName(this.body, component.boneName);
				if (component.ts == null)
				{
					string text = base.transform.name + ".找不到骨骼" + component.boneName;
					Debug.Log(text);
				}
			}
			else
			{
				Debug.Log("没有设置body");
			}
		}
		foreach (Transform child in ts)
		{
			this.SetChild(child);
		}
	}
	private void PlayTransForm(Transform ts)
	{
		Delay component = ts.GetComponent<Delay>();
		if (component)
		{
			component.Begin();
			return;
		}
		if (ts.GetComponent<Animation>())
		{
			ts.GetComponent<Animation>().Play();
			ts.GetComponent<Animation>().wrapMode=WrapMode.Once;
		}
        if (ts.GetComponent<Animator>())
        {
            ts.GetComponent<Animator>().SetTrigger("play");
        }
		if (ts.GetComponent<ParticleSystem>())
		{
			ts.GetComponent<ParticleSystem>().Play();
		}
		if (ts.GetComponent<AudioSource>())
		{
			ts.GetComponent<AudioSource>().Play();
		}
		foreach (Transform ts2 in ts)
		{
			this.PlayTransForm(ts2);
		}
	}
	public void Stop()
	{
		this.StopTransForm(base.transform);
        this.StopAnimator(base.transform);
	}
	public void Play()
	{
		this.PlayTransForm(base.transform);
	}
	private void Update()
	{
		if (this.oldbody != this.body)
		{
			this.oldbody = this.body;
			this.SetChild(base.transform);
		}
	}
}
