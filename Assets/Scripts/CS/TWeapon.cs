using UnityEngine;
using System.Collections;

public class TWeapon : MonoBehaviour {
	
	public GameObject weapon;	//武器
	
	public Transform hand;		//
	
	Transform GetTransByName(Transform tst, string name)
	{
		if(tst.name==name)
		{
			return tst;
		}
		
		foreach(Transform p in tst)
		{
			Transform tg= GetTransByName(p,name);	
			if(tg)
				return tg;
		}
		return null;
	}
	// Use this for initialization
	void Start ()
	{
		hand = GetTransByName(transform, "Bip01 R Hand");
		if(hand!=null)
		{
			 
		}
	}
	
	public void ChangeWeapon()
	{
		if(weapon)
			{
				DestroyImmediate(weapon);
			}
			//GameObject prefab =(GameObject)Resources.LoadAssetAtPath("Assets/GameResources/Characters/weapon/Weapon_fumo.prefab", GameObject);
            //weapon=(GameObject)Instantiate(Resources.LoadAssetAtPath( "Assets/GameResources/Characters/weapon/Weapon_fumo.prefab" , typeof(GameObject)));    
            //weapon.transform.parent = transform;
	}
	// Update is called once per frame
	void Update () {

	
		if(hand!=null)
		{
			if(weapon!=null)
			{
				weapon.transform.position = hand.transform.position;
				weapon.transform.rotation = hand.transform.rotation;
			}
		}
	}
}
