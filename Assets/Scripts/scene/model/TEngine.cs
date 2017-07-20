using System;
using System.Collections.Generic;
using UnityEngine;
	public class TEngine
	{
		public delegate float GetSceneRefHeightCallback(LayerMask _mask, out Transform ts, Vector3 pos, float refhei);
		public delegate float GetSceneHeightCallback(float x, float z, LayerMask _mask, out Transform ts);
		public static TEngine.GetSceneRefHeightCallback pcallbackgetrefhei = null;
		public static TEngine.GetSceneHeightCallback pcallbackgethei = null;
		private void Start()
		{
		}
		public static string GetFilePath(string dataname)
		{
			string text;
            if (Application.platform == RuntimePlatform.WindowsWebPlayer || Application.platform == RuntimePlatform.OSXWebPlayer)
			{
				string absoluteURL = Application.absoluteURL;
				text = absoluteURL.Substring(0, absoluteURL.Length - 17) + dataname;
			}
			else
			{
				text = "file:///" + Application.dataPath + "/../" + dataname;
			}
			if (!text.Contains("file:///"))
			{
				text = text.Replace("file://", "file:///");
			}
			return text.Replace("\\", "/");
		}
		public static string GetFileNameNoExt(string instr)
		{
			int length = instr.LastIndexOf('.');
			return instr.Substring(0, length);
		}
		public static void EnableObject(Transform pf, bool v)
		{
			pf.gameObject.SetActive(v);
			foreach (Transform pf2 in pf)
			{
				TEngine.EnableObject(pf2, v);
			}
		}
		public static void SetShaderFloatValue(Transform ts, string v, float _value)
		{
			if (!(ts == null))
			{
				if (ts.gameObject.GetComponent<Renderer>() != null)
				{
					Material[] materials = ts.gameObject.GetComponent<Renderer>().materials;
					for (int i = 0; i < materials.Length; i++)
					{
						Material material = materials[i];
						material.SetFloat(v, _value);
					}
				}
				foreach (Transform ts2 in ts)
				{
					TEngine.SetShaderFloatValue(ts2, v, _value);
				}
			}
		}
		public static Vector3 NormalizeGridPos(Vector3 tpos)
		{
			tpos.x = (float)((int)tpos.x);
			tpos.z = (float)((int)tpos.z);
			tpos += new Vector3(0.5f, 0f, 0.5f);
			return tpos;
		}
		public static void SetShader(Transform ts, Shader sd)
		{
			if (!(ts == null))
			{
				if (ts.gameObject.GetComponent<Renderer>() != null)
				{
					Material[] materials = ts.gameObject.GetComponent<Renderer>().materials;
					for (int i = 0; i < materials.Length; i++)
					{
						Material material = materials[i];
						material.shader=sd;
					}
				}
				foreach (Transform ts2 in ts)
				{
					TEngine.SetShader(ts2, sd);
				}
			}
		}
		public static void SetLayer(Transform ts, LayerMask layer)
		{
			if (!(ts == null))
			{
				ts.gameObject.layer=layer;
				foreach (Transform ts2 in ts)
				{
					TEngine.SetLayer(ts2, layer);
				}
			}
		}
		public static void SetShaderTexture(Transform ts, string v, Texture _value)
		{
			if (!(ts == null))
			{
				if (ts.gameObject.GetComponent<Renderer>() != null)
				{
					Material[] materials = ts.gameObject.GetComponent<Renderer>().materials;
					for (int i = 0; i < materials.Length; i++)
					{
						Material material = materials[i];
						material.SetTexture(v, _value);
					}
				}
				foreach (Transform ts2 in ts)
				{
					TEngine.SetShaderTexture(ts2, v, _value);
				}
			}
		}
		public static void SetShaderColor(Transform ts, string v, Color _value)
		{
			if (!(ts == null))
			{
				if (ts.GetComponent<Renderer>() != null)
				{
					Material[] materials = ts.GetComponent<Renderer>().materials;
					for (int i = 0; i < materials.Length; i++)
					{
						Material material = materials[i];
						material.SetColor(v, _value);
					}
				}
				foreach (Transform ts2 in ts)
				{
					TEngine.SetShaderColor(ts2, v, _value);
				}
			}
		}
		public static void TEnableMeshCollider(Transform pf, bool tv)
		{
			if (pf.GetComponent<Collider>() != null)
			{
				pf.GetComponent<Collider>().enabled=tv;
			}
			foreach (Transform pf2 in pf.transform)
			{
				TEngine.TEnableMeshCollider(pf2, tv);
			}
		}
		public static Transform GetChildByName(Transform ts, string name)
		{
			Transform result;
			if (ts == null)
			{
				result = null;
			}
			else
			{
				if (ts.name.ToLower() == name.ToLower())
				{
					result = ts;
				}
				else
				{
					foreach (Transform ts2 in ts)
					{
						Transform childByName = TEngine.GetChildByName(ts2, name);
						if (childByName != null)
						{
							result = childByName;
							return result;
						}
					}
					result = null;
				}
			}
			return result;
		}
		public static void GetChildByName(Transform ts, string name, ref List<Transform> list)
		{
			if (!(ts == null))
			{
				if (ts.name == name)
				{
					list.Add(ts);
				}
				foreach (Transform ts2 in ts)
				{
					TEngine.GetChildByName(ts2, name, ref list);
				}
			}
		}
		public static Transform[] GetAllChildByName(Transform ts, string name)
		{
			List<Transform> list = new List<Transform>();
			TEngine.GetChildByName(ts, name, ref list);
			return list.ToArray();
		}
		public static float GetAbsoluteTerrHei(float x, float z, LayerMask _mask, out Transform ts)
		{
			float result;
			if (TEngine.pcallbackgethei != null)
			{
				result = TEngine.pcallbackgethei(x, z, _mask, out ts);
			}
			else
			{
				ts = null;
				result = 0f;
			}
			return result;
		}
		public static float GetAbsoluteTerrHei(float x, float z)
		{
			LayerMask mask = LayerMask.NameToLayer("ground");
			Transform transform = null;
			float result;
			if (TEngine.pcallbackgethei != null)
			{
				result = TEngine.pcallbackgethei(x, z, mask, out transform);
			}
			else
			{
				result = 0f;
			}
			return result;
		}
		public static float GetRefTerrHei(Vector3 curpos, float _refhei)
		{
			LayerMask mask = LayerMask.NameToLayer("ground");
			Transform transform = null;
			float result;
			if (TEngine.pcallbackgetrefhei != null)
			{
				result = TEngine.pcallbackgetrefhei(mask, out transform, curpos, _refhei);
			}
			else
			{
				result = 0f;
			}
			return result;
		}
		public static float GetRefTerrHei(Vector3 curpos, float _refhei, LayerMask _mask, out Transform ts)
		{
			float result;
			if (TEngine.pcallbackgetrefhei != null)
			{
				result = TEngine.pcallbackgetrefhei(_mask, out ts, curpos, _refhei);
			}
			else
			{
				ts = null;
				result = 0f;
			}
			return result;
		}
		public static void MakeStroke(Rect position, string txt, Color txtColor, Color outlineColor, int outlineWidth)
		{
			position.y=position.y - (float)outlineWidth;
			GUI.color=outlineColor;
			GUI.Label(position, txt);
			position.y=position.y + (float)(outlineWidth * 2);
			GUI.Label(position, txt);
			position.y=position.y - (float)outlineWidth;
			position.x=position.x - (float)outlineWidth;
			GUI.Label(position, txt);
			position.x=position.x + (float)(outlineWidth * 2);
			GUI.Label(position, txt);
			position.x=position.x - (float)outlineWidth;
			GUI.color=txtColor;
			GUI.Label(position, txt);
		}
		public static byte GetByteFromString(string str)
		{
			byte b = 0;
			byte result;
			if (byte.TryParse(str, out b))
			{
				result = b;
			}
			else
			{
				result = 0;
			}
			return result;
		}
		public static int GetIntFromString(string str)
		{
			int num = 0;
			int result;
			if (int.TryParse(str, out num))
			{
				result = num;
			}
			else
			{
				result = 0;
			}
			return result;
		}
		public static float GetFloatFromString(string str)
		{
			float num = 0f;
			float result;
			if (float.TryParse(str, out num))
			{
				result = num;
			}
			else
			{
				result = 0f;
			}
			return result;
		}
		private void Update()
		{
		}
	}
