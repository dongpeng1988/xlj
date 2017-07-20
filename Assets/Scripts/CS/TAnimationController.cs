using UnityEngine;
using System.Collections;
using System.Collections.Generic;

// This is the PocketRPG Animation Controller... It is necessary to run PocketRPG trails
// THIS REPLACES METHODS LIKE ANIMATION.PLAY AND ANIMATION.CROSSFADE... YOU CANNOT USE THOSE IN CONJUNCTION WITH THESE TRAILS UNLESS YOU ARE HAPPY WITH FRAMERATE DEPENDANT ANIMATION
// PocketRPG trails run faster than the framerate... (default is 300 frames a second)... that is how they are so smooth (30fps trails are rather jerky)
// This code was written by Evan Greenwood (of Free Lives) and used in the game PocketRPG by Tasty Poison Games.
// But you can use this how you please... Make great games... that's what this is about.
// This code is provided as is. Please discuss this on the Unity Forums if you need help.

[RequireComponent(typeof(Animation))]
[AddComponentMenu("PocketRPG/Animation Controller")]
public class TAnimationController : MonoBehaviour
{
	protected List<WeaponTrail> trails;
	protected Vector3 lastEulerAngles = Vector3.zero;
	protected Vector3 lastPosition = Vector3.zero;
    protected WeaponTrail pAttackTrail;
	protected float animationIncrement = 0.003f; // ** This sets the number of time the controller samples the animation for the weapon trails

 
	void Awake ()
	{
		trails = new List<WeaponTrail> ();
		lastPosition = transform.position;
		lastEulerAngles = transform.eulerAngles;
	}


    public WeaponTrail GetAttackTail()
    {
        if (pAttackTrail == null)
        {
            for (int i = 0; i < trails.Count; i++)
            {
                if (trails[i].name == "attack")
                {
                    pAttackTrail = trails[i];
                    break;
                }
            }
        }
        return pAttackTrail;
    }
    public void OnEndAttackAni()
    {
        GetAttackTail().bStopUpdatePos = true;
    }
	public void OnEndDeathAni()
    {
        //GetAttackTail().bStopUpdatePos = true;
    }
	
	public void OnBeginAttackAni()
    {
        GetAttackTail().bStopUpdatePos = false;
    }
	
    void UpdateTail()
    {
        float deltaTime = Time.deltaTime;
        float tempT = 0;
        float m = 0;
        if (deltaTime > 0)
        {
                Vector3 eulerAngles = transform.eulerAngles;
                Vector3 position = transform.position;
                while (tempT < deltaTime)
                {
                    tempT += animationIncrement;

                    //����ֵ
                    m = tempT / deltaTime;

                    transform.eulerAngles = new Vector3(Mathf.LerpAngle(lastEulerAngles.x, eulerAngles.x, m),
                        Mathf.LerpAngle(lastEulerAngles.y, eulerAngles.y, m),
                        Mathf.LerpAngle(lastEulerAngles.z, eulerAngles.z, m));

                    transform.position = Vector3.Lerp(lastPosition, position, m);
                    //
                    // ** Samples the animation at that moment
                    //
                    GetComponent<Animation>().Sample();
                    //
                    // ** Adds the information to the WeaponTrail
                    //
                    for (int j = 0; j < trails.Count; j++)
                    {
                        if (trails[j].bStopUpdatePos == false)
                        {
                            if (trails[j].time > 0)
                            {
                                trails[j].Itterate(Time.time - deltaTime + tempT);
                            }
                            else
                            {
                                trails[j].ClearTrail();
                            }
                        }
                    }
                }
                //
                // ** End of loop
                //
                tempT -= deltaTime;
                //
                // ** Sets the position and rotation to what they were originally
                transform.position = position;
                transform.eulerAngles = eulerAngles;
                lastPosition = position;
                lastEulerAngles = eulerAngles;

            //
            // ** Finally creates the meshes for the WeaponTrails (one per frame)
            //
            for (int j = 0; j < trails.Count; j++)
            {
                if (trails[j].time > 0)
                {
                    trails[j].UpdateTrail(Time.time, deltaTime);
                }
            }
        }
    }
	protected virtual void LateUpdate ()
	{
        UpdateTail();
	}	
	//
	public void AddTrail (WeaponTrail trail)
	{
		trails.Add (trail);
	}

}
