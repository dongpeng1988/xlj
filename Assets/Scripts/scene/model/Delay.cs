using System;
using UnityEngine;
public class Delay : MonoBehaviour
{
	public float fDestroyTime = -1f;
	public float fDelayTime = 0f;
	public bool bEffectChild;
	public bool bPlayOnStart;
    public Transform modelTrans;
    public float fDelayTime1 = 0f;
    public Transform modelTrans1;
    public float fDelayTime2 = 0f;
    public Transform modelTrans2;
    public float fDelayTime3 = 0f;
    public Transform modelTrans3;
    public float fDelayTime4 = 0f;
    public Transform modelTrans4;
	public virtual void Start()
	{
        //if (this.bEffectChild)
        //{
        //    this.Stop(base.transform, this.bEffectChild);
        //}
        //if (this.bPlayOnStart)
        //{
        //    this.Begin();
        //}
	}
    protected virtual void OnEnable()
    {
        if (this.bEffectChild)
        {
            this.Stop(base.transform, this.bEffectChild);
        }
        if (this.bPlayOnStart)
        {
            this.Begin();
        }
    }
	private void Stop(Transform ts, bool befchild)
	{
		if (ts.GetComponent<Animation>())
		{
			ts.GetComponent<Animation>().Stop();
            ts.GetComponent<Animation>().wrapMode = WrapMode.Once;
		}
		if (ts.GetComponent<ParticleSystem>())
		{
			ts.GetComponent<ParticleSystem>().Stop(true);
		}
		if (ts.GetComponent<ParticleEmitter>())
		{
			ts.GetComponent<ParticleEmitter>().emit=false;
		}
		if (ts.GetComponent<AudioSource>())
		{
			ts.GetComponent<AudioSource>().Stop();
		}
		if (!befchild)
		{
			return;
		}
		foreach (Transform ts2 in ts)
		{
			this.Stop(ts2, befchild);
		}
	}
	public void Stop()
	{
		base.CancelInvoke("PlayOnTimeOver");
		base.CancelInvoke("DestroyTimeOver");
	}
	public void Begin()
	{
		if (this.fDelayTime >0f&&modelTrans != null)
		{
             modelTrans.gameObject.SetActive(false);
			base.Invoke("PlayOnTimeOver", this.fDelayTime);
		}
		if (this.fDestroyTime > 0f)
		{
			base.Invoke("DestroyTimeOver", this.fDestroyTime);
		}
        if (this.fDelayTime1 > 0f && modelTrans1 != null)
        {
            modelTrans1.gameObject.SetActive(false);
            base.Invoke("PlayOnTimeOver1", this.fDelayTime1);
        }
        if (this.fDelayTime2 > 0f && modelTrans2 != null)
        {
            modelTrans2.gameObject.SetActive(false);
            base.Invoke("PlayOnTimeOver2", this.fDelayTime2);
        }
        if (this.fDelayTime3 > 0f && modelTrans3 != null)
        {
            modelTrans3.gameObject.SetActive(false);
            base.Invoke("PlayOnTimeOver3", this.fDelayTime3);
        }
        if (this.fDelayTime4 > 0f && modelTrans4 != null)
        {
            modelTrans4.gameObject.SetActive(false);
            base.Invoke("PlayOnTimeOver4", this.fDelayTime4);
        }
	}
	private void DestroyTimeOver()
	{
        UnityEngine.Object.DestroyObject(base.gameObject);
	}
	private void PlayOnTimeOver()
	{
        Debug.Log("delay end start play");
		this.Play(base.transform, this.bEffectChild);
        if (modelTrans != null)
            modelTrans.gameObject.SetActive(true);
	}
	public virtual void Play(Transform ts, bool befchild)
	{
		if (ts.GetComponent<ParticleEmitter>())
		{
            Debug.Log("ParticleEmitter play");
            ts.GetComponent<ParticleEmitter>().emit = true;
		}
		if (ts.GetComponent<Animation>())
		{
            Debug.Log("Animation play");
			ts.GetComponent<Animation>().Play();
		}
		if (ts.GetComponent<ParticleSystem>())
		{
            Debug.Log("ParticleSystem play");
			ts.GetComponent<ParticleSystem>().Play(true);
		}
		if (ts.GetComponent<AudioSource>())
		{
            Debug.Log("AudioSource play");
			ts.GetComponent<AudioSource>().Play();
		}
		if (!befchild)
		{
            Debug.Log("befchild flase return");
			return;
		}
		if (ts.GetComponent<TEffectBase>() != null)
		{
            Debug.Log("TEffectBase play");
			ts.GetComponent<TEffectBase>().Play();
		}
		foreach (Transform transform in ts)
		{
			if (transform.GetComponent<Delay>())
			{
				transform.GetComponent<Delay>().Begin();
			}
			else
			{
				this.Play(transform, befchild);
			}
		}
        Debug.Log("TEffectBase play");
	}
    private void PlayOnTimeOver1()
    {
        if (modelTrans1 != null)
            modelTrans1.gameObject.SetActive(true);
    }
    private void PlayOnTimeOver2()
    {
        if (modelTrans2 != null)
            modelTrans2.gameObject.SetActive(true);
    }
    private void PlayOnTimeOver3()
    {
        if (modelTrans3 != null)
            modelTrans3.gameObject.SetActive(true);
    }
    private void PlayOnTimeOver4()
    {
        if (modelTrans4 != null)
            modelTrans4.gameObject.SetActive(true);
    }
	private void Update()
	{
	}
}
