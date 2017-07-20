using System;
using UnityEngine;
public class UVAni : MonoBehaviour
{
	public float fUVMoveSpeedX = 2f;
	public float fUVMoveSpeedY = 2f;
	private Vector2 offset = default(Vector2);
	private void Start()
	{
	}
	private void Update()
	{
		if (base.GetComponent<Renderer>() != null && base.GetComponent<Renderer>().material != null)
		{
			this.offset.x = this.offset.x + Time.deltaTime * this.fUVMoveSpeedX;
			this.offset.y = this.offset.y + Time.deltaTime * this.fUVMoveSpeedY;
			base.GetComponent<Renderer>().material.mainTextureOffset=this.offset;
		}
	}
}
