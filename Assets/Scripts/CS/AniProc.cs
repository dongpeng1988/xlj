using UnityEngine;
using System.Collections;

public class AniProc : MonoBehaviour
{
/*	
	WeaponTrail g_weapontail;
	WeaponTrail GetAttackTail()
	{
		return g_weapontail;
	}
 */
	// Use this for initialization
    //AniProcBase[] anibaselist;
	void Start ()
	{
		BrushAniProc();
	/*	foreach(WeaponTrail w in wp)
		{
			if(w.name =="Right_Trail")// "attack")
			{
				g_weapontail = w;
			}
		}
	*/		
	}
	public void BrushAniProc()
	{
        //anibaselist = transform.parent.GetComponentsInChildren<AniProcBase>();
	}
	// Update is called once per frame
	void Update () {
	
	}
	
	public void OnEndAttackAni()
    {
        //foreach(AniProcBase pc in anibaselist)
        //{
        //    pc.OnEndAttackAni();
        //}
		/*if(GetAttackTail()!=null)
        	GetAttackTail().bStopUpdatePos = true;
        	*/
    }
	public void OnEndDeathAni()
    {
        //GetAttackTail().bStopUpdatePos = true;
    }
	
	public void OnBeginAttackAni()
    {	
        //foreach(AniProcBase pc in anibaselist)
        //{
        //    pc.OnBeginAttackAni();
        //}
    }
}
