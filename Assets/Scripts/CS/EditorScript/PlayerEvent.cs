using UnityEngine;
using System.Collections;

public class PlayerEvent : MonoBehaviour {

    
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    public void AttackEndAnimationEvent()
    {

        Debug.Log("Attack is end");

       // audio.PlayOneShot(walkSound);

       // audio.volume = 0.4f;

    } 


}
