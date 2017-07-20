using System;
using UnityEngine;
public class EffectBind : MonoBehaviour
{
	public Transform ts;
	public string boneName;
	public Vector3 refpos = default(Vector3);
	public Vector3 refrot = default(Vector3);
	public bool bOnlyBindPos;
	public float fRefHeight = 0.1f;
	public bool bTieDi;
	private void Start()
	{
	}
	private void Update()
	{
	}
	private void LateUpdate()
	{
		if (this.ts != null)
		{
			base.transform.position=this.ts.position + this.refpos;
			if (!this.bOnlyBindPos)
			{
				base.transform.eulerAngles=this.ts.eulerAngles + this.refrot;
			}
			if (this.bTieDi)
			{
				Vector3 position = base.transform.position;
				position.y = TEngine.GetAbsoluteTerrHei(position.x, position.z) + this.fRefHeight;
				base.transform.position=position;
			}
		}
	}
}
